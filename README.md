# ksp1retooled-ci
CI builds for ksp1retooled. Runs are dispatched by the ksp1retooled-automation
bot (`sha`, `check_run_id`) and report back to a check run on the private repo.
Only `workflow_dispatch` triggers exist; secrets live in the `ci` environment,
restricted to `main`. See ksp1retooled-automation for setup.

`launcher.yml` follows each CI run and packages the launcher for every platform:
a setup `.exe`, `.dmg`s, and a `.deb`, `.rpm` and tarball. Its result does not
feed the `ci` check, so see the Actions tab for failures. Unsigned for now.
