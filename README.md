# owasp-dependency-check

[![](https://images.microbadger.com/badges/image/pmosbach/owasp-dependency-check.svg)](https://microbadger.com/images/pmosbach/owasp-dependency-check "Get your own image badge on microbadger.com") [![Docker Pulls](https://img.shields.io/docker/pulls/pmosbach/owasp-dependency-check.svg?maxAge=2592000)](https://hub.docker.com/r/pmosbach/owasp-dependency-check/) [![license](https://img.shields.io/badge/license-MIT-blue.svg?style=plastic)](https://github.com/pmosbach/owasp-dependency-check/blob/master/LICENSE)

## About owasp-dependency-check

An alpine container for the [OWASP Dependency Check](https://www.owasp.org/index.php/OWASP_Dependency_Check) CLI, along with a pre-seeded database to speed up scans.

This was forked from embrasure/owasp-dependency-check in order to pull in a more up-to-date version of the CLI, to add Mono, and to customize to ease use with GitLab CI.

## Install

`$ docker pull pmosbach/owasp-dependency-check`

## Usage

###### run with default settings

`$ docker run --rm -v <project_source>:/tmp/src -v <report_destination_directory>:/tmp/reports -w /tmp/src -w /tmp/reports pmosbach/owasp-dependency-check`

###### run with additional arguments

`$ docker run --rm -v <project_source>:/tmp/src -v <report_destination_directory>:/tmp/reports -w /tmp/src -w /tmp/reports pmosbach/owasp-dependency-check --enableExperimental --disableBundleAudit "true"`
