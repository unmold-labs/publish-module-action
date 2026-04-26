# publish-module

Publish an OpenTofu or Terraform module to Unmold.dev from a GitHub Action workflow.

This repository contains a Docker-based GitHub Action that wraps the Unmold CLI to publish modules.

## Inputs

The action is configured in `action.yaml` and supports the following inputs:

- `unmold-api-token` (required): API token for Unmold.dev. Provide via a secret.
- `namespace` (optional): Namespace to publish the module under. If omitted the provided module name is used as-is.
- `name` (required): Module name.
- `system` (optional): Target system for the module (for example `aws`, `gcp`).
- `version` (required): Module version to publish.
- `module-path` (optional): Path to the module directory inside the repository (default: `.`).

## Example usage

Basic example (in a workflow file):

```yaml
uses: unmold-cloud/publish-module-action@v1
with:
  unmold-api-token: ${{ secrets.UNMOLD_API_TOKEN }}
  namespace: my-org
  name: my-module
  version: 1.2.3
  system: aws
  module-path: ./modules/my-module
```

You can call the action from a `workflow_dispatch` or on a release tag. The action runs the Unmold CLI inside a small Docker image and forwards the inputs as CLI flags.

## Test Locally

Run the following command with the environment variable `UNMOLD_API_TOKEN`

``` bash
bash test/run-local-test.sh
```

## Contributing

Contributions, bug reports and PRs are welcome. Please open issues for bugs or feature requests.

## License

MIT

