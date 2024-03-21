---
title: Webhooks
permalink: Services/Development/Webhooks/
parent: Development
layout: default
nav_order: 400
---

A [webhook](https://en.wikipedia.org/wiki/Webhook) is a tool that connects web services together to trigger behaviors when specific actions are detected.

Sailfish OS development makes use of webhooks to automate the testing and release of source code packages on the [Open Build Service](/Services/Development/Open_Build_Service) (OBS).

There are webhooks attached to the Sailfish OS source code repositories at <https://github.com/sailfishos>, and when a new version of a source package in a repository is released through a git *tag*, the webhook notifies the OBS, which then builds a new version of the package based on the updated repository.

# Setting up webhook for a Sailfish OS repository

## Enable webhooks on a Git repository

### github.com

1.  Go to your package repository
2.  Click on *Settings*
3.  Click on *Webhooks*
4.  Add *<https://webhook.sailfishos.org/webhook/>* as the Payload URL
5.  Content type should be *application/json*
6.  Enable *SSL verification*
7.  Enable *Just the push event*
8.  Enable *Active*

### bitbucket.org

1.  Go to your package repository
2.  Click on *Repository settings*
3.  Click on *Webhooks*
4.  Select *Add webhook*
5.  Add *<https://webhook.sailfishos.org/webhook/>* as the URL

## Enable webhook on OBS

In a place under your home project, create a package as usual and create a file called `_service` which contains an XML description of the webhook, followed by the service required to process that git repo (e.g. `tar_git`).

Adjust this XML example to your needs.
```xml
<services>
  <service name="webhook">
    <param name="repourl">https://github.com/sailfishos/pcre2.git</param>
    <param name="branch">master</param>
    <param name="build">true</param>
    <param name="notify">true</param>
    <param name="comment"/>
  </service>
  <service name="tar_git">
    <param name="url">https://github.com/sailfishos/pcre2.git</param>
    <param name="branch">master</param>
    <param name="revision">9b811e378e4c0d452ed08f4a7434a86d326ff87e</param>
    <param name="token"/>
    <param name="debian"/>
    <param name="dumb"/>
  </service>
</services>
```

Give the OBS cibot permissions to access the repository, by adding the *cibot* user as a maintainer for the project. This can be done via the OBS web interface:

1.  Go to the web page for the project (you can check out how it's already done in e.g. <https://build.sailfishos.org/package/show/sailfishos:chum/pcre2>)
2.  Click on the "Users" tab
3.  Click the "Add user" link (only available if you have the required project permissions)
4.  Enter *cibot* as the user and leave the role as "maintainer", and click the "Add user" button.

Now that the webhook is set up, the OBS should automatically trigger a build for your project when a new tag is pushed to project's remote git repository.

# Typical use cases

## Copy a package to a personal work area and use a different branch or repo

You can just branch the package - you'll get a webhook automatically. You can then edit the `_service` file and change the *branch* or *repourl* param values.

Branching is useful as it will ensure the same build repositories are used:

1.  Go to the web page for a project you'd like to branch (e.g. <https://build.sailfishos.org/package/show/sailfishos:chum/pcre2>)
2.  Click on "Branch package" link
3.  Click "Ok" (or check out more options)

You can then edit the branched `_service` file and change "repourl" from <https://github.com/sailfishos/pcre2.git> to e.g. <https://github.com/my-forks/pcre2.git>. Branch can also be changed to e.g. *myfeaturebranch*.

Now any tags pushed to *myfeaturebranch* on your forked repo will build a package in your branch area (ensure you enabled webhooks on your forked git as explained [here](#enable-webhooks-on-a-git-repository)).

## Delete a package

Just delete the package. Webhooks which reference a deleted package will be deleted periodically.
