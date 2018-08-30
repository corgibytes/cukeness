# 4. Use Docker and Docker Compose for Development Environment

Date: 2018-08-29

## Status

Accepted

## Context

It needs to be very easy to reliably construct a development environment with all of the tooling required to build and run the application.

## Decision

`docker` and `docker-compose` will be used for all development activities. starting a development version of the application should be a simple a running `docker-compose up`.

## Consequences

While creating a basic development environment will be documented and made consistent for different environments, running parts of thr application in an IDE may become difficult.
