# 3. API Server Responsible for Interaction with External Services

Date: 2018-08-27

## Status

Accepted

## Context

There are a couple external services that need to be communicated with. These are expected to be a source control system and a server running the [Cucumber Wire Protocol](1987e2349b14ca0fe93e879d762df09f1a9b3934). There are other functions that are needed such as authentication and authorization, and an abstraction around the storage and organization of Gherkin-based executable specifications

## Decision

An API server will be built to handle the following:

* Integration with source control systems (initially just `git` but the addition of others needs to be possible)
* Communication with Cucumber Wire Protocol service
* Required abstractions for creating, modifying, organizing, and executing Gherkin-based executable specifications
* Abstractions for authentication and authorization (initially fulfilled by a simple database authentication mechanism, but eventually allowing other authentication sources such as OAuth)

These functions will be independent of any user interface that's presented to facilitate carrying out these actions.

## Consequences

This will drastically simplify the user interface, because it will only need to concern itself with communication with one entity to function. However, this also makes the API server rather complex, in that it has to juggle many different responsibilities. These responsibilities can be decomposed into ancillary services and libraries as needed to mitigate this extra complexity.
