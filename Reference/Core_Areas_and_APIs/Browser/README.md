---
title: Browser
permalink: Reference/Core_Areas_and_APIs/Browser/
has_children: true
parent: Core Areas and APIs
layout: default
nav_order: 200
---

## Sailfish OS Browser

The web browser in Sailfish OS is a fully open-source component which has been developed in active collaboration with community members. It uses Sailfish Silica UI elements for the browser chrome, and an embedded Gecko engine for content rendering. The source code can be found at <https://github.com/sailfishos/sailfish-browser> and is available under a permissive MPLv2.0 license.

## Performance testing

Performance testing steps need to be such that one they are reproducible and comparable between different test runs.

Steps that are executed only once

1. Flash release or release candidate image x.x.0
2. Do not install additional software
3. Do not setup accounts
4. Setup network access
5. Start browser
6. From browser Menu > Settings > Home page > set "about:license" as home page
7. Close all tabs
8. Close browser

Steps that are executed for each test case

1. Start browser
2. Wait about:license loaded
3. Open test case url
4. Run test case
5. Document findings
6. Stop browser
7. rm -rf $HOME/.local/share/org.sailfishos/browser/.mozilla/startupCache/
8. rm -rf $HOME/.local/share/org.sailfishos/browser/.mozilla/cache2

Test cases

1. JetStream2 from https://browserbench.org
2. MotionMark from https://browserbench.org
3. speedometer from https://browserbench.org
4. Octane 2.0 from https://chromium.github.io/octane

### Performance testing results

Results are preliminary. Higher numbers are better but are not comparible across different test cases.

| Device name          | Release version      | Engine version | Test case            | Test result          |
| -------------------- | -------------------- | ---------------| -------------------- | -------------------- |
| Xperia 10            | 4.3.0.15             | 60.9.1         | Octane 2.0           | 4801                 |
| Xperia 10            | 4.4.0.58             | 78.15.1        | Octane 2.0           | 4209                 |
| Xperia 10 II         | 4.3.0.15             | 60.9.1         | Octane 2.0           | 1194                 |
| Xperia 10 II         | 4.4.0.58             | 78.15.1        | Octane 2.0           | 6696                 |
| Xperia 10            | 4.3.0.15             | 60.9.1         | JetStream2           | 13.24                |
| Xperia 10            | 4.4.0.58             | 78.15.1        | JetStream2           | 13.376               |
| Xperia 10 II         | 4.3.0.15             | 60.9.1         | JetStream2           | Failed to complete   |
| Xperia 10 II         | 4.4.0.58             | 78.15.1        | JetStream2           | 19.046               |
| Xperia 10            | 4.3.0.15             | 60.9.1         | Speedometer          | 5.21 ± 0.15          |
| Xperia 10            | 4.4.0.58             | 78.15.1        | Speedometer          | 6.29 ± 0.13          |
| Xperia 10 II         | 4.3.0.15             | 60.9.1         | Speedometer          | 8.61 ± 0.16          |
| Xperia 10 II         | 4.4.0.58             | 78.15.1        | Speedometer          | 8.85 ± 0.13          |

## Debugging

Logging instruction can be found on the [browser development page](/Reference/Core_Areas_and_APIs/Browser/Working_with_Browser/#enabling-module-log-output).
