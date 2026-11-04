#!/usr/bin/env bash
# Turns a published launcher into the packages for its platform.
# Usage: package.sh <rid> <version> <publish dir> <output dir>
set -euo pipefail

rid=$1
version=$2
publish=$(cd "$3" && pwd)
mkdir -p "$4"
out=$(cd "$4" && pwd)
here=$(cd "$(dirname "$0")" && pwd)

case "$rid" in
  win-*)
    # Without this, MSYS rewrites iscc's /D and /O switches as paths.
    MSYS_NO_PATHCONV=1 iscc "/DAppVersion=$version" "/DPublishDir=$(cygpath -w "$publish")" \
      "/O$(cygpath -w "$out")" "$(cygpath -w "$here/installer.iss")"
    ;;

  linux-*)
    tar -czf "$out/retooled-launcher-$version-$rid.tar.gz" -C "$publish" .
    # nfpm reads contents paths literally, so give it a fixed layout to read.
    stage=$(mktemp -d)
    cp -R "$publish" "$stage/app"
    cp "$here/nfpm.yaml" "$here/retooled-launcher.desktop" "$stage/"
    for format in deb rpm; do
      (cd "$stage" && VERSION=$version nfpm package --config nfpm.yaml --packager "$format" --target "$out/")
    done
    ;;

  osx-*)
    stage=$(mktemp -d)
    app="$stage/KSP Retooled Launcher.app"
    mkdir -p "$app/Contents/MacOS"
    cp "$publish"/* "$app/Contents/MacOS/"
    sed "s/@VERSION@/$version/g" "$here/Info.plist" > "$app/Contents/Info.plist"
    # Bundling invalidates the linker's ad-hoc signature, and Apple Silicon
    # refuses to run unsigned code.
    codesign --force --deep --sign - "$app"
    ln -s /Applications "$stage/Applications"
    hdiutil create -volname "KSP Retooled Launcher" -srcfolder "$stage" -format UDZO -ov \
      "$out/RetooledLauncher-$version-$rid.dmg"
    ;;

  *)
    echo "unknown runtime: $rid" >&2
    exit 1
    ;;
esac
