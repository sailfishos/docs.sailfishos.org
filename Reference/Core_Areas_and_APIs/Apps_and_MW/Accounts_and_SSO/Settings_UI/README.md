---
title: Settings UI
permalink: Reference/Core_Areas_and_APIs/Apps_and_MW/Accounts_and_SSO/Settings_UI
parent: Accounts and SSO
grand_parent: Apps and MW
layout: default
---

## Settings UI

The settings UI for a provider must be located at `/usr/share/accounts/ui/` and named `<provider>-settings.qml` where `<provider>` matches the [name](https://sailfishos.org/develop/docs/sailfish-accounts/qml-sailfishaccounts-provider.html/#name-prop) of the [Provider](https://sailfishos.org/develop/docs/sailfish-accounts/qml-sailfishaccounts-provider.html/).

The root element of the settings UI should be `AccountSettingsAgent` which is available via `import com.jolla.settings.account 1.0`.  The `/usr/share/accounts/ui/` also contains helper component `OnlineSyncAccountSettingsAgent` which can be used instead.

The implementation must:

1. Set the initialPage property (i.e. the first page in the account flow) to a page
2. Emit accountDeletionRequested() signal and pop the page when the user wants to delete the account.

The accountId property will automatically be set to the ID of the account to be displayed.

### Account creation UI

The UI for creating an account must be located at `/usr/share/accounts/ui/` and named `<provider>.qml` where `<provider>` matches the [name](https://sailfishos.org/develop/docs/sailfish-accounts/qml-sailfishaccounts-provider.html/#name-prop) of the [Provider](https://sailfishos.org/develop/docs/sailfish-accounts/qml-sailfishaccounts-provider.html/).

The root element of the settings UI should be `AccountCreationAgent` which is available via `import com.jolla.settings.account 1.0`. The `/usr/share/accounts/ui/` also contains helper component `OnlineSyncAccountCreationAgent` which can be used instead.

The implementation must:

1. Set the initialPage property (i.e. the first page in the account flow) to a Page or Dialog
2. Ensure the page that follows the last account creation page is the provided endDestination.

For example, a typical implementation of a UI flow would be:

1. Set initialPage to be a Dialog that allows the user to enter username and password details
2. When the dialog is accepted, show a page with a busy-spinner animation while creating the account asynchronously in the background. 
 - If the account is created, show the account settings dialog to allow the user to confirm or customize particular settings. When the settings dialog is accepted, save the updated settings and move onto the endDestination. If the save operation is asynchronous, set `delayDeletion=true` until the save is done (or fails) to prevent the agent instance from being deleted until the operation completes.
 - If the account cannot be created, allow the user to go back to try again, or move onto the endDestination if the retry action is not possible.

3. Use the [createAccount()](https://sailfishos.org/develop/docs/sailfish-accounts/qml-sailfishaccounts-accountmanager.html/#createAccount-method) method of [AccountManager](https://sailfishos.org/develop/docs/sailfish-accounts/qml-sailfishaccounts-accountmanager.html/) to create the account in the Accounts & SSO framework. Note that the AccountManager is provided as a convenience property `accountManager` in `AccountCreationAgent`.

4. Create possible [sync profiles](/Reference/Core_Areas_and_APIs/Apps_and_MW/Synchronization/#sync-profiles). Note that the sync profiles for [Backup Accounts](../Backup_Accounts) are created by the backup settings UI when automatic backups are configured.

