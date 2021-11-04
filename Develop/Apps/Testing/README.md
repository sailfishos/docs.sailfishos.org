---
title: Testing
permalink: Develop/Apps/Testing/
parent: Apps
layout: default
nav_order: 900
---

## Testing

When testing a change, it is important to keep the testing environment as stable as possible, to ensure that the testing results are the same each time. Thus it is recommended to have the latest available SDK installed.

### Debugging Output & Journal

Most application output (including debug logging as well as warnings or critical error information) is recorded in the [systemd journal which can be tuned for your degugging needs](/Reference/Sailfish_OS_Cheat_Sheet#diagnostics)

### Unit Tests

Any behaviour change made by a contributor should be matched with a new unit test, to ensure that a future code change doesn't break the functionality (i.e., a regression). In most cases, the unit tests are run automatically as part of the continuous integration gating process for the package, and so the contributor should ensure that their newly added unit test is added to the "tests.xml" file (if it exists in the repository) which tells "testrunnerlite" (the CI unit-test runner) to run the test as part of integration testing. The contributor should also run all of the unit tests manually, to ensure that their code change hasn't accidentally caused a regression in behaviour.

If a particular package doesn't include unit tests, a change may still be accepted by the maintainer even if the contribution doesn't include a unit test for that change. However, this should be considered an exception rather than the rule; where possible, unit tests should always be added. If a particular component lacks unit tests for existing functionality, this is a prime candidate for contribution from quality-focused community members! The more automatable the quality-assurance process is, the faster we can release new versions of Sailfish OS, and with higher confidence that no regressions were introduced.
