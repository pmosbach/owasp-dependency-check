# owasp-dependency-check

[![](https://images.microbadger.com/badges/image/pmosbach/owasp-dependency-check.svg)](https://microbadger.com/images/pmosbach/owasp-dependency-check "Get your own image badge on microbadger.com") [![Docker Pulls](https://img.shields.io/docker/pulls/pmosbach/owasp-dependency-check.svg?maxAge=2592000)](https://hub.docker.com/r/pmosbach/owasp-dependency-check/) [![license](https://img.shields.io/badge/license-MIT-blue.svg?style=plastic)](https://github.com/pmosbach/owasp-dependency-check/blob/master/LICENSE)

## About owasp-dependency-check

An alpine container for the [OWASP Dependency Check](https://www.owasp.org/index.php/OWASP_Dependency_Check) CLI, along with a pre-seeded database to speed up scans.

This was forked from embrasure/owasp-dependency-check in order to pull in a more up-to-date version of the CLI, to add Mono, and to customize to ease use with GitLab CI.

## Install

`$ docker pull pmosbach/owasp-dependency-check`

## Usage

### Basic configuration with GitLab CI

The following is an example job from a `.gitlab-ci.yml` file to use this image to run OWASP Dependency Check:
```yml
dependency_check:
  stage: code_analysis
  image:
    name: pmosbach/owasp-dependency-check:latest
    entrypoint: [""]
  script:
    - /tmp/dependency-check/bin/dependency-check.sh --scan "./" --format ALL --project "$CI_PROJECT_NAME --enableExperimental"
  artifacts:
    paths:
      - 'dependency-check-report.html'
      - 'dependency-check-report.json'
```

If you do not specify the job as above, the image will attempt to run OWASP Dependency Check on the `/builds` directory, where GitLab will inject code
(see [here](https://docs.gitlab.com/ce/ci/docker/using_docker_images.html#how-docker-integration-works) for more details). If you do not override the
`entrypoint`, OWASP Dependency Check will be invoked like this:

`/tmp/dependency-check/bin/dependency-check.sh --scan /builds --format ALL --project GENERIC --enableExperimental`

### If you insist on running via the Docker CLI

`$ docker run --rm -v <project_source>:/builds/src -v <report_destination_directory>:/tmp/reports -w /tmp/src -w /tmp/reports pmosbach/owasp-dependency-check --enableExperimental`
