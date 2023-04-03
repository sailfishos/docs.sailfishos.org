---
title: Backup Accounts
permalink: Reference/Core_Areas_and_APIs/Apps_and_MW/Accounts_and_SSO/Backup_Accounts
parent: Accounts and SSO
grand_parent: Apps and MW
layout: default
---

# Backup Accounts

Backup accounts are implemented as [Buteo client plugins](/Reference/Core_Areas_and_APIs/Apps_and_MW/Synchronization/#buteo-client-plugins). On the Accounts and SSO side, the plugin [provides](../Providers_and_Services#provider-description-files) a [storage service](../Providers_and_Services#predefined-service-types). The service is called `<provider>-backup`, where `<provider>` is the id of the provider.

Note that backup accounts are always online accounts. No account is needed for creating a backup on a SD card.

## Service configuration

The backup service configuration is done via [Account Settings UI](/Reference/Core_Areas_and_APIs/Apps_and_MW/Accounts_and_SSO/Settings_UI). The location of backup files on the server is configured via settings key `backups_path`. If `OnlineSyncAccountCreationAgent` or `OnlineSyncAccountsSettingsAgent` are used, this setting is configured in the advanced settings dialog.

Note that it is possible to access the Account settings UI also from Backup settings, in order to create a backup account if no backup accounts exist on the device.

## Sync profiles

Even though the accounts are created and the services configured via  [Account Settings UI](/Reference/Core_Areas_and_APIs/Apps_and_MW/Accounts_and_SSO/Settings_UI), the [sync profiles](/Reference/Core_Areas_and_APIs/Apps_and_MW/Synchronization/#sync-profiles) are not. Instead they are created by the Backup settings UI (Settings → System → Backup). There are three profiles for each provider: `Backup`, `BackupQuery` and `BackupRestore`. Each profile matches to an operation, which are described below.

## Operations

Towards Buteo the interface of all three operations is basically the same: The client plugin implements `Buteo::ClientPlugin::startSync()` method, which is called when the operation is requested.

### Backup operation

The creation of the backup file is done by backup/restore application (jolla-vault). When `Buteo::ClientPlugin::startSync()` method is called, the client plugin uses D-Bus to initiate the backup. The backup/restore application listens to `org.sailfishos.backup` interface at path `/sailfishbackup` on the `org.sailfishos.backup` service on the session bus. The following methods are available:

| method                     | arguments  | return value | description                                     |
| ------                     | ---------  | ------------ | -----------                                     |
| backupFileDeviceId         |            | string       | Device ID, to be used as backup directory name  |
| createBackupForSyncProfile | Profile ID | string       | Starts backup to file, returns backup file path |

The backup/restore application uses the following signals to notify about the progress:

| signal                   | arguments                                       | Description                                                                                                                                |
| ------                   | ---------                                       | -----------                                                                                                                                |
| cloudBackupStatusChanged | int accountId, string status                    | `UploadingBackup` Backup file is ready to be uploaded <br/> `Canceled` Backup operation was canceled <br/> `Error` Backup operation failed |
| cloudBackupError         | int accountId, string error, string errorString |                                                                                                                                            |

Finally, once the upload is complete, the client plugin emits `success()` or `error()` to notify Buteo.

### Backup Query operation

Backup Query operation takes care of requesting a list of backup files available on the server.

Again, the operation is started by a call to `Buteo::ClientPlugin::startSync()`. The client then fetches the list of backup files from server, and uses the following method to report the result to the backup/restore application:

| method                     | arguments                          | description                                     |
| ------                     | ---------                          | -----------                                     |
| setCloudBackups            | string profileId, string[] backups | report list of found backups on the server      |

And again, once the operation is finished, Buteo is notified by emitting `success()` or `error()`

### Backup Restore operation

Backup Restore operation fetches a backup file from the remote server.

The local path, including the backup file name, for the backup file is stored in the sync profile key `sfos-backuprestore-file`.

Once finished downloading, the client plugin notifies Buteo by emitting `success()` or `error()`

