---
title: Secrets and Crypto
permalink: Reference/Core_Areas_and_APIs/Apps_and_MW/Secrets_and_Crypto/
parent: Apps and MW
grand_parent: Core Areas and APIs
layout: default
---

## Secrets and Crypto

Sailfish OS offers secure storage and cryptographic operations functionality to client applications via the Sailfish OS Secrets and Crypto Framework. This framework includes a system daemon, plugins to the system daemon which implement the functionality which is offered to clients (and may be backed by a Secure Peripheral or Trusted Execution Environment application), and Qt-based client APIs for the Secrets and Crypto domains.

### API

The secure storage and cryptographic operations stack in Sailfish OS includes several API components. All of the native API components are fully open-source.

#### Platform API

Sailfish OS provides the Sailfish::Secrets and Sailfish::Crypto APIs to clients. The APIs are thin wrappers around DBus calls to the system daemon, which delegates client requests to plugins which implement the offered functionalities.

All of the code is open source and can be found in the repository:

  - <https://github.com/sailfishos/sailfish-secrets>

#### Android Compatibility

No Android Compatibility is currently offered. In the future, this functionality is intended to be offered via the bridge service.

### Contribution

Community or third-party contributions to the secure storage and cryptographic operations stack in Sailfish OS is encouraged and appreciated. The platform API and implementation is fully open source, found on <https://github.com/sailfishos>, with discussions via IRC (#sailfishos via oftc.net) and via email.
