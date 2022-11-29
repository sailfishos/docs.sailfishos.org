---
title: Setup General Email Account
permalink: Support/Help_Articles/Accounts_Setup/Setup_General_Email_Account/
parent: Accounts Setup
grand_parent: Help Articles
layout: default
nav_order: 400
---

On Sailfish OS, accounts are created and managed in the menu "Settings > Accounts".

By **General email** we mean all IMAP and POP3 email accounts.

If the email account you wish to set up is a **Microsoft Exchange** account, please see **[this article](/Support/Help_Articles/Setup_Exchange_Account/)**. Setting up a **Google** account is explained in **[this article](/Support/Help_Articles/Setup_Google_Account/)**.

[**This article**](https://jolla.zendesk.com/hc/en-us/articles/205278388) has an overview of using the Email application of Sailfish OS.

# What are IMAP and POP accounts?

## IMAP4

When using the IMAP protocol, the mail program handles emails directly from the server, whereby an email can be deleted or stored elsewhere in one message, or retained on the server. This is especially advantageous when the same mailbox is handled by more than one computer (or phone), for example, at work and home. Therefore, it is recommended that you use the IMAP protocol.

You should use IMAP, especially on your phone.

## POP3

When using the POP3 protocol, the mail program retrieves messages from the inbox of the server to the computer (or phone) from which the email is read. In this case, the inbox in your mailbox will be left empty on the email server after the mail has been retrieved. Mail programs often have an alternative setting that leaves a copy of all retrieved emails to the mail server.

POP3 protocol does not retrieve messages other than the inbox. The advantage of the POP3 protocol is that the mailbox is usually never full when messages are downloaded from the server to their own computer. The drawback is that the message is readable only from the machine the emails are loaded to.

# Setting up a General Email account on Sailfish

When installing this type of account, you can let your Sailfish OS device **automatically** fetch email settings. You can also insert your account settings **manually**, but we recommend you try letting your device fetch them automatically first.

## Setting up the account automatically

Make sure you have an Internet connection from your device.

1. Go to Settings > Accounts
2. Tap "Add account".
3. Select "General email", and the view of the first picture below appears.
4. Enter your email address and password. Tap the eye button to check that you have written the password correctly.
5. Swipe left or tap Accept at the top right corner.
6. Your Sailfish OS device will retrieve the settings automatically. If it succeeds, you should soon see the view below right (the email address here is just an example).

<div class="flex-images" markdown="1">

* <a href="Email_settings_create_new.jpg"><img src="Email_settings_create_new.jpg" alt="Template"></a>
  <span class="md_figcaption">
    Start automatic account creation
  </span>
* <a href="Email_settings_home_view.jpg"><img src="Email_settings_home_view.jpg" alt="Account created automatically"></a>
  <span class="md_figcaption">
    Account created automatically
  </span>
</div>


## Setting up the account manually

In case Sailfish can't get your email account's settings from the server, i.e. the automatic setup failed, you will be asked to enter them by hand. The missing items are indicated in red colour. The correct email settings must then be entered. If you don't know them, please consult your service provider.

Alternatively, you can start over at "Settings > Accounts > Add new account > Generic email". At the bottom of this page, tap the button "**Manual setup**".

For a list of some known email server settings, please [**see here**](https://jolla.zendesk.com/hc/en-us/articles/203323503).

Below, there is a list of settings you will need to type to the settings page.

### Incoming mail server settings

* Server type: IMAP (or POP3)
* Server address: xxxxxx.imap.com
    _(replace the address with the actual address you got from your service provider)_
* Secure connection: SSL/StartTLS/nothing  _(we recommend: SSL)_
* Port number:

Note: selecting SSL or StartTLS will automatically set an appropriate number to the Port number field. Please do not attempt to change the number.

Once done, you should see the view below _(the email address and server address are imaginary examples)_:

<div class="flex-images" markdown="1">

* <a href="Email_settings_incoming.jpg" class="narrow-image"><img src="Email_settings_incoming.jpg" alt="Incoming direction"></a>
  <span class="md_figcaption">
    Settings for incoming direction
  </span>
</div>


### Outgoing mail server settings

* Server type: SMTP
* Server address:  yyyyyy.smtp.com
    _(replace the address with the actual address you got from your service provider)_
* Secure connection: SSL/StartTLS/nothing    _(we recommend: SSL)_
* Port number:Note: selecting SSL or StartTLS will automatically set an appropriate number to the Port number field. Please do not attempt to change the number.
* Authentication required: turning ON recommended.

This setting ensures the best available security for the outgoing direction.

Once done, you should see the view below _(the email address and server address are examples)_.

<div class="flex-images" markdown="1">

* <a href="Email_settings_outgoing.jpg" class="narrow-image"><img src="Email_settings_outgoing.jpg" alt="Outgoing direction"></a>
  <span class="md_figcaption">
    Settings for incoming direction
  </span>
</div>


### Warning about untrusted certificates

We recommend leaving "Accept untrusted certificates" OFF unless you fully understand the potential security risks.

# Troubleshooting issues with General email

If you have received the settings from your email service provider, but you can't get your email to work, check if the question & answer pairs below are of any help to you.

**Q: I can't install my account, I just see a "Synchronization error"**

**A:** Try going into your email account settings through Settings > Accounts and select your General Email account. Change the setting at the very bottom, which deals with accepting SSL certificates. Try disabling it if active, or enabling it if disabled.

**Q: I can only send emails, but cannot receive any!**

**A:** If you can't receive any email, your incoming mail server settings need to be adjusted. Double-check them and make changes, and try again.

**Q: I can only receive emails, but cannot send any**

**A:** If you can't send emails, but you can receive them, your outgoing mail server settings need to be adjusted. Double-check them, make changes, and try again.


