# sleavely/node-awscli

Lambda-compatible NodeJS images with AWS CLI installed.

[Docker Hub](https://hub.docker.com/r/sleavely/node-awscli) | [Github](https://github.com/Sleavely/docker-node-awscli)

## Automatic Updates

Whenever a new NodeJS version is released, an instance of [`commit-on-release`](https://github.com/Sleavely/commit-on-release) creates an empty commit in the corresponding branch (`v20`, `v22` and `v24`) so that a new image is published to Docker Hub by a Github Action workflow.

## Usage in CI/CD environments

Instead of using e.g. `node:24` and installing `awscli`, `jq`, and `zip` every time the pipeline runs, just switch out the name of the image to `sleavely/node-awscli:24.x` or [another appropriate version tag](https://hub.docker.com/r/sleavely/node-awscli/tags).

### Bitbucket Pipelines

In `bitbucket-pipelines.yml`:

```yaml
image: sleavely/node-awscli:24.x

pipelines:
  default:
    - step:
        name: Deploy to test environment
        script:
          - npm ci
          - npm run build-app-test
          - aws s3 sync ./build s3://$(WEBHOSTING_BUCKET_NAME)/
```

### CircleCI

In `.circleci/config.yml`:

```yaml
version: 2
jobs:
  deploy:
    docker:
      - image: sleavely/node-awscli:24.x
    steps:
    - checkout
    - run: npm ci
    - run: npm run build-app-test
    - run: aws s3 sync ./build s3://$(WEBHOSTING_BUCKET_NAME)/
```

### Github Actions

In `.github/worksflows/deploy.yml`:

```yaml
name: Build and deploy
on:
  push:
    branches:
      - main
jobs:
  deploy:
    runs-on: ubuntu-latest
    container:
      image: sleavely/node-awscli:24.x
    steps:
    - uses: actions/checkout@v3
    - run: npm ci
    - run: npm run build-app-test
    - run: aws s3 sync ./build s3://$(WEBHOSTING_BUCKET_NAME)/
      env:
        AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
        AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        WEBHOSTING_BUCKET_NAME: my-awesome-bucket
```
