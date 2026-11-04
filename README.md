# ksp1retooled-ci
CI builds for ksp1retooled. Runs are dispatched by the ksp1retooled-automation
bot (`sha`, `check_run_id`) and report back to a check run on the private repo.
Only `workflow_dispatch` triggers exist; secrets live in the `ci` environment,
restricted to `main`. See ksp1retooled-automation for setup.
