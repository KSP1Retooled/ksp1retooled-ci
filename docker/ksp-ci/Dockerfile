# Environment for Unity jobs on the self-hosted runner. Unity itself is not in
# the image: the host mounts the editor at /unity.
FROM ubuntu:24.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      ca-certificates curl git git-lfs xz-utils unzip gh jq \
      libgtk-3-0 libnss3 libasound2t64 libgbm1 libxss1 libglu1-mesa libgl1 libcups2 \
      libxkbcommon0 libxcomposite1 libxdamage1 libxrandr2 libxi6 libxtst6 \
      libvulkan1 libc6-dev libssl3 libicu74 \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://dot.net/v1/dotnet-install.sh \
      | bash -s -- --channel 10.0 --install-dir /usr/share/dotnet \
    && ln -s /usr/share/dotnet/dotnet /usr/local/bin/dotnet

# Must match the uid of the runner's host user so the shared work directory
# stays writable by both.
RUN useradd -m -u 1003 -s /bin/bash github

ENV DOTNET_CLI_TELEMETRY_OPTOUT=1 DOTNET_NOLOGO=1
USER github
