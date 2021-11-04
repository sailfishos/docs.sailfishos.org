---
title: Docs Contribution Checklist
permalink: Reference/Core_Areas_and_APIs/Docs_Contribution_Checklist/
parent: Core Areas and APIs
layout: default
nav_order: 800
---

The goal of component documentation in the [Core Areas and APIs](/Reference/Core_Areas_and_APIs) is to let a competent developer understand the area and guide them towards further information.

Think about the following:

  - **Design/architecture**
    Talk about what this area does, other areas it interacts with and what happens (eg include things such as sequence diagrams).
  - **APIs**
    This should describe how applications should access the area's functionality; often via a Qt module.
    It can also talk about inter-component APIs (eg dbus)
    If there are specific helper systems (such as UI Layer APIs) then these should be mentioned.
    Any Android compatibility or access information should also be presented.
    If there is automatic API documentation available, link to it
  - **Data storage information**
    Describe how and where information is stored (or link to documentation or source)
    Any xml/DB/file schemas should be mentioned.
    What to backup/restore.
  - **Configuration**
    Describe what configuration is available for the component and how this should be used
  - **Network**
    If the service uses or offers any network capabilities
  - **Security and Privacy**
    Does the area have any particular security or privacy implications
  - **Tutorials/Examples**
    Try to provide a useful example of accessing the area from an application.
    This could be a link to source or autodoc examples.
  - **Contribution**
      - Links to source in github.com (or ...)
      - Any applicable policies
      - Suggestions for contribution
      - Try to avoid generic contribution content
