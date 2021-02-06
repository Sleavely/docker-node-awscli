# sleavely/node-awscli

Lambda-compatible NodeJS images with AWS CLI installed.

[Docker Hub](https://hub.docker.com/r/sleavely/node-awscli) | [Github](https://github.com/Sleavely/docker-node-awscli)

## Usage in CI/CD environments

Instead of using e.g. `node:12` and installing `awscli` every time the pipeline runs, just switch out the name of the image to `sleavely/node-awscli` with the appropriate version tag. Tags are named after the Lambda NodeJS runtime identifier.

### Bitbucket Pipelines

In `bitbucket-pipelines.yml`:

```yaml
image: sleavely/node-awscli:12.x

pipelines:
  default:
    - step:
        name: Deploy to test environment
        script:
          - npm install
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
      - image: sleavely/node-awscli:12.x
    steps:
    - checkout
    - run: npm install
    - run: npm run build-app-test
    - run: aws s3 sync ./build s3://$(WEBHOSTING_BUCKET_NAME)/
```

## Automatic Updates

The `v10`, `v12` and `v14` branches are set up to automatically trigger a new build in Docker Hub. Whenever a new NodeJS version is released, an instance of [`commit-on-release`](https://github.com/Sleavely/commit-on-release) creates an empty commit in the corresponding branch so that a new image is published.
