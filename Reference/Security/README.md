---
title: Security
permalink: Reference/Security/
layout: default
nav_order: 300
---

## Security and Privacy

Security is of primary importance in the modern world. Security is the capability of a device to withstand malicious attacks to avoid allowing the attacker to gain access to capabilities or data on the device. Sailfish OS aims to be a secure operating system to power the devices of users around the world.

Privacy is similarly important. Privacy is related to the way that consumer data is handled on the device, and whether that data is kept private for the user, or whether that data is used for other purposes (such as advertising analytics, or sold to third parties). Sailfish OS respects the privacy of its users, and does not use the data for any such purposes (the full privacy policy may be viewed [here](https://jolla.com/sailfish-eula/)). In some cases, Sailfish OS makes use of third-party plugins to extend its functionality, and in those cases the third-party plugin may require that the user agrees to some separate privacy policy (for example, location and positioning plugins, which can use data about surrounding cell towers to determine the user's location). In those cases, the user is clearly informed and their express permission is requested before that functionality can be enabled.

### Security Hotfixes

Sailfish OS devices can be updated with so called "hotfixes" for specific security issues outside of the normal release update cadence. This allows vendors to provide users with security updates as they become available, with minimal delay. These fixes are provided as package updates via the normal package management systems, and are fully versioned and delivered securely with end-to-end encryption to avoid man-in-the-middle or other contamination attacks.

### Current Security Architecture

Sailfish OS currently uses a two-level security architecture. Applications available in the Harbour are rigorously tested to ensure that no malicious applications are installable by end users. Furthermore, applications available in the Harbour run at a lowered privilege level, so that they do not have access to the user's data.

Linux user groups are used to separate privileged applications from non-privileged applications, and file system access is enforced by the Linux kernel.

### Future Security Architecture

In the future, Sailfish OS will use application sandboxing and per-application access control lists to control application behaviour and limit the scope of malicious activity achievable by exploiting a vulnerability in any given application or service. This security architecture will be applied to core Sailfish OS services and applications, as well as third-party Harbour applications.
