---
title: URLs and Files
permalink: Reference/Core_Areas_and_APIs/Apps_and_MW/URLs_and_Files
parent: Apps and MW
grand_parent: Core Areas and APIs
layout: default
---

## Opening URLs and files externally

Sometimes applications want to open URLs or files with some other application.
The most common example of this would be opening web urls with the Browser, or
local files with the application that knows how to handle the file types.

On sailfish these cases can be handled with the Qt.openUrlExternally(url)
QML API, or alternatively QDesktopServices::openUrl() from C++.
The system UI will present an application choosing dialog in case there are
multiple apps handling the file type or url.

The supported URL types may include:
- file:// for local files.
- http:// and https:// for web pages.
- mailto:user@example.org for starting to compose an email.
- sms:\<number\> for starting writing an SMS.
- tel:\<number\> for initiating a call.
- geo:\<latitude\>,\<longitude\> for opening a location with a mapping application.

In addition to the standard coordinate, the geo: url can be also used with
free text search or street address as extra parameters on the URL.
The parameter list is a 'key=value' list after a "?" character, separated with "&".

Potential extra parameters are:
- "q:" for free text query, e.g. "geo:?q=search_term"
- Street address in "street", "city", "region", "zipcode", and "country".

To note that applications might not support all the parameters.
Android map apps might support the free text search.

## Registering handlers for url and file types

For registering above file types and url schemes to be used by other applications,
the .desktop file is used with the MimeType field.

For file types, this is the standard form of e.g. "MimeType=audio/*;application/pdf"

For urls, there are two variants:
- "MimeType=x-scheme-handler/http" which registers handler for a url scheme, or
- "MimeType=x-url-handler/\<hostname\>" as special case for registering http(s) url
handler for a specific hostname, e.g. if there's an application created for a specific
web service.
