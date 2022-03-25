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

| Device name          | Release version      | Engine version | Test case            | Test result          |
| -------------------- | -------------------- | ---------------| -------------------- | -------------------- |
| Xperia 10 II         | 4.4.0.xy             |      TBD       |        TBD           |         TBD          |

## Debugging

Logging instruction can be found on the [browser development page](/Reference/Core_Areas_and_APIs/Browser/Working_with_Browser/#enabling-module-log-output).
