---
title: Troubleshooting Exchange Account
permalink: Support/Help_Articles/Accounts_Setup/Troubleshooting_Exchange_Account/
parent: Accounts Setup
grand_parent: Help Articles
layout: default
nav_order: 10000
---

This article is meant for troubleshooting problems with Exchange accounts, please note that setting up Exchange account is explained in [this article](/Support/Help_Articles/Accounts_Setup/Setup_Exchange_Account/).
Please also note that in order to have Exchange account you need to have Sailfish OS license, please [read more](/Support/Help_Articles/Sailfish_OS_Licence/).

# Known limitations related to Exchange

* The syncing of the photos of your Exchange contacts isn’t supported.
* Remotely wiping Sailfish devices using provisioning isn't currently supported.

## Changing of Microsoft Exchange account password fails

If you fail in updating/changing your Microsoft Exchange password, please try the following:

1. Open your Exchange account's server settings from the top menu, do not change anything there and navigate back to the accounts list page.
2. Enter again the same account and open the server settings from the top menu.
3. Change the password and navigate back to the accounts list to save the password.

## Exchange account is ready but there is no Outlook or Exchange app

SailfishOS has only one Email (client) application, "Mail". Mail handles all email accounts you have configured. They appear in the home view of this application.There is no native Outlook or Exchange application for SailfishOS.

Mail can be installed from Jolla Store.

The support for Exchange account is also installed from Jolla Store. However, since this is not a separate application there will be no icon for it at the application launcher grid. You need to visit Settings > Accounts > New account > Exchange to create an account and use it through Mail, Calendar and People applications.

## Syncing of emails, calendar or contacts fails

* Double check that Exchange support is installed from the Jolla Store, and that you have attempted setting an account up through Settings > Account > “Add account”.
* Try to delete and re-install your Exchange account.
* Double check that your Exchange account settings are correct. When you first define them to your Sailfish device, everything might appear to go through, but if the settings are wrong you might not be able to receive or send any data from your Exchange Account.

* **General knowledge about Exchange settings**
	* Your exchange address is usually: firstname.lastname@yourcompany.com
	* Your username is most times different to that of the first part of your email address.
	* Your password, make sure your Exchange Account password hasn’t recently been changed.
	* Server domain: often times can be left blank, but can also be crucial to fill.
	* Server address, Server port, Secure connection & Accepting all SSL certificates: if all the settings above are correct, these should be found automatically and you shouldn’t have to enter them manually. Please consult your Exchange system administrator if you feel you might have to enter them by hand.

* **If you want to enter these settings manually, here’s some information**
	* Server address: Your server address, or an address that points to the server where the email service is stored.
	* Server port: very often there is no need to change the port from the default 443, but to be sure consult your email service provider.
	* Secure connection: Enabled for the majority of service providers.
	* Accept all SSL certificates: Enable this if the server you are connecting to has a self-signed or untrusted certificate. Please note: accepting untrusted certificates might pose security threats to your data.

* Double check that you have selected all the items you want to sync in your Exchange account’s settings: Settings > Accounts > select your Exchange account.
* A brightly lit dot represents an active selection.
* To **“force” a sync**, you only need to go to your email Inbox, and select “Update”. You can also do this in Settings > Accounts > your Exchange account and selecting "Sync" from the pulley menu above.

* Register your device’s IMEI-number to your Exchange system administrator in case its required.
	* Some (especially corporate) Exchange servers require that all devices wishing to use the servers must be registered to a database. By adding your device’s IMEI-number to the database, your device is “allowed access” to using the Exchange server. Contact your system administrator to confirm whether you need to do this.
	* To see the IMEI code of your device go to menu "Settings > System > About product" and look for “IMEI”
	* The Exchange servers of many companies keep book about the mobile devices connected. In addition, there is typically an upper limit for the number of devices for each account, for instance 10. If you keep failing to make your Exchange account work then sign in to your account from a PC, seek for "Options > Phone > Mobile Phones"  and make sure that there are not too many devices registered. Remove all unnecessary ones.
	
### Provisioning

* See if toggling **provisioning** on or off has an effect
	* In the settings of your Exchange account (Settings > Account > select your Exchange account), provisioning is the very last setting in the view.
	* By default, it is on. Provisioning means, that you are giving the Exchange server the possibility to for example force a lock code to be used on your Sailfish device, in compliance to corporate policy for example.

* Sailfish OS supports the following provisioning policies related to the device lock:
	* DevicePasswordEnabled
	* AutomaticLocking
	* MinDevicePasswordLength
	* MaxDevicePasswordFailedAttempts
	* MaxInactivityTimeDeviceLock

* By toggling it off, see if there’s a change when you try to sync your emails.
* By toggling it back on again, see if you receive a request from the server.

NOTE: When changing provisioning settings, it is often best to start the setting up of the account from scratch.

## Only some of the information from the Exchange account is synced

* Double check that you have selected all the items you want to sync from your Exchange account in your Exchange account’s settings: Settings > Accounts > select your Exchange account.
* A brightly lit dot represents an active selection.
* Check the section "Content sync", too. It sets the period of time from which old emails and calendar events need to be synced. There is also an option to select which email folders should be synced.
* To **force a sync**, you only need to go to your email Inbox, and select “Update”. Alternatively you can do this by going to Settings > Accounts > your Exchange account, and selecting "Sync" from the pulley menu above.
* We also recommend, that you try deleting and then re-installing your Exchange account.


