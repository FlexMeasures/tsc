
# Contributing to FlexMeasures

Thank you for your interest in contributing to FlexMeasures. This document explains our contribution process and procedures:

* [How to Contribute a Bug Fix or Change](#How-to-Contribute-a-Bug-Fix-or-Change)
* [Development Workflow](#Development-Workflow)
* [Coding Style](#Coding-Style)

For a description of the roles and responsibilities of the various members of the FlexMeasures community, see the [governance policies], and for further details, see the project's [Technical Charter]. Briefly, Contributors are anyone who submits content to the project, Committers review and approve such submissions, and the Technical Steering Committee provides general project oversight.

If you just need help or have a question, refer to [SUPPORT.md](SUPPORT.md).

## How to Contribute a Bug Fix or Change

To contribute code to the project, first read over the [governance policies] page to understand the roles involved. 

Each contribution must meet the [coding style] and include..

* Submitted to the project as a pull request.
* Tests and documentation to explain the functionality.
* Any new files have [copyright and license headers](https://github.com/lf-energy/tac/blob/main/process/contribution_guidelines.md#code-license-identification)
* A [Developer Certificate of Origin signoff]. This can be done by adding `-s` to your `git commit` command.

FlexMeasures is licensed under the [Apache 2.0](LICENSE) license. Contributions should abide by that standard license.

Project committers will review the contribution in a timely manner, and advise of any changes needed to merge the request.


## Development workflow

At the moment, we have not established a workflow, other than we require contributions to be made in pull requests. Bigger topics should be discussed as [projects](https://github.com/FlexMeasures/flexmeasures/projects) first.


## Coding style

We program in Python and follow the PEP8 style guide.
You can [read more](https://flexmeasures.readthedocs.io/en/latest/dev/introduction.html), e.g. on how versioning works or how to apply our automatic code style tooling (Flake8, Black).


[governance policies]: GOVERNANCE.md
[Technical Charter]: tsc/CHARTER.md
[copyright and license headers]: https://github.com/lf-energy/tac/blob/main/process/contribution_guidelines.md#license
[Developer Certificate of Origin signoff]: https://github.com/lf-energy/tac/blob/main/process/contribution_guidelines.md#contribution-sign-off
