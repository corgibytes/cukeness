# 2. Use Arlo's Commit Notation

Date: 2018-08-27

## Status

Accepted

## Context

We need a quick method for evaluating the impact of a particular commit.

## Decision

We will use [Arlo Belshee's Commit Notation](https://github.com/RefactoringCombos/ArlosCommitNotation) for this project. We will also use the `d` prefix to indicate that documentation changes have been made. We've also submitted a [pull request](https://github.com/RefactoringCombos/ArlosCommitNotation/pull/1) to Arlo's Commit Notation which may or not be accepted by that project. Regardless of that team's decision, `d` will be used on this project in a manner that is consistent with the description below, which also appears in the pull request description.

### Use of `d` prefix

The `d` prefix is meant to track changes to files such as `README*` or anything that might appear in a `docs` folder. The intent is to use this prefix for documentation changes which have absolutely no effect on the output of the code. It should not be used for making changes to any documentation that is rendered to a user of code in question. For example changes to the output produced by running `--help` for a console application should not use this prefix. An upper-case prefix should be used for such changes.

## Consequences

It will be much easier to review the commit log and determine the risk associate with each commit.
