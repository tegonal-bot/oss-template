Following the steps you should perform after cloning this template repository:

1. execute init.sh
2. adjust/check the TBD in this file
3. add a [new discussion category](https://github.com/tegonal/scala-commons/discussions/categories/new) 
   `Contributor Q&A` -- `Ask other contributors for help`
4. in order that the tegonal-bot pushes changes to its own fork (e.g. when executing gt-update.yml -- 
   see below for an explanation) and then create a normal PR you need to:
   1. [add the repository variable](https://github.com/tegonal/minimalist/settings/variables/actions/new)
      `AUTO_PR_FORK_NAME` with value tegonal-bot/PROJECT_NAME_GITHUB
   2. login as tegonal-bot and then [fork the repository](https://github.com/tegonal/PROJECT_NAME_GITHUB/fork)

5. Following a short introduction in the scripts already setup in this repository:
   1. before-pr.sh is executed in .github/workflows/quality_assurance.yml and runs cleanup-on-push-to-main.sh and run-shellcheck.sh 
   2. cleanup-on-push-to-main.sh is executed in .github/workflows/cleanup.yml meant to cleanup after a PR.
      => put commands such as code formatting in it
   3. run-shellcheck.sh checks that shellcheck doesn't find issues in script located in /scripts 
 
6. Following a short introduction in the workflows already setup in this repository:
   1. cleanup.yml => run after push on main and intended to cleanup after a PR. 
   2. gt-update.yml => run periodically, updates all files pulled in via [gt](https://github.com/tegonal/gt)
   3. quality-assurance.yml => run for PR and pushed, checks that the code/script quality and such are ok.
      => you will typically add more jobs which run tests (sbt test or gradle build)

7. git commit -a -m "initialised"
8. As last step, delete this section and you are ready to start with your new OSS project

<!-- for main -->

[![Download](https://img.shields.io/badge/Download-v0.1.0-%23007ec6)](https://github.com/tegonal/PROJECT_NAME/releases/tag/v0.1.0)
LICENSE_BADGE
[![Quality Assurance](https://github.com/tegonal/PROJECT_NAME/actions/workflows/quality-assurance.yml/badge.svg?event=push&branch=main)](https://github.com/tegonal/PROJECT_NAME/actions/workflows/quality-assurance.yml?query=branch%3Amain)
[![Newcomers Welcome](https://img.shields.io/badge/%F0%9F%91%8B-Newcomers%20Welcome-blueviolet)](https://github.com/tegonal/PROJECT_NAME/issues?q=is%3Aissue+is%3Aopen+label%3A%22good+first+issue%22 "Ask in discussions for help")

<!-- for main end -->
<!-- for release -->
<!--
[![Download](https://img.shields.io/badge/Download-v1.1.0-%23007ec6)](https://github.com/tegonal/PROJECT_NAME/releases/tag/v1.1.0)
LICENSE_BADGE
[![Newcomers Welcome](https://img.shields.io/badge/%F0%9F%91%8B-Newcomers%20Welcome-blueviolet)](https://github.com/tegonal/PROJECT_NAME/issues?q=is%3Aissue+is%3Aopen+label%3A%22good+first+issue%22 "Ask in discussions for help")
-->
<!-- for release end -->

# PROJECT_NAME

TBD<add project description>

---
❗ You are taking a *sneak peek* at the next version. It could be that some features you find on this page are not
released yet.  
Please have a look at the README of the corresponding release/git tag. Latest
version: [README of v0.1.0](https://github.com/tegonal/PROJECT_NAME/tree/main/README.md).

---

**Table of Content**

- [Installation](#installation)
- [Documentation](#documentation) 
- [Contributors and contribute](#contributors-and-contribute)
- [License](#license)

# Installation

TBD<adjust if not published to maven central> 
PROJECT_NAME is published to maven central.

# Documentation

TBD<adjust if not published to github pages>
Code documentation can be found on github-pages: <https://tegonal.github.io/PROJECT_NAME>.

# Contributors and contribute

Our thanks go to [code contributors](https://github.com/tegonal/PROJECT_NAME/graphs/contributors)
as well as all other contributors (e.g. bug reporters, feature request creators etc.)

You are more than welcome to contribute as well:

- star this repository if you like/use it
- [open a bug](https://github.com/tegonal/PROJECT_NAME/issues/new?template=bug_report.md) if you find one
- Open a [new discussion](https://github.com/tegonal/PROJECT_NAME/discussions/new?category=ideas) if you are missing a
  feature
- [ask a question](https://github.com/tegonal/PROJECT_NAME/discussions/new?category=q-a)
  so that we better understand where we can improve.
- have a look at
  the [help wanted issues](https://github.com/tegonal/PROJECT_NAME/issues?q=is%3Aissue+is%3Aopen+label%3A%22help+wanted%22).

Please have a look at
[CONTRIBUTING.md](https://github.com/tegonal/PROJECT_NAME/tree/main/.github/CONTRIBUTING.md)
for further suggestions and guidelines.

# License

PROJECT_NAME is licensed under LICENSE_LINK