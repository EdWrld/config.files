# CRM <-> RMX Syncing Guide (Reference)

## Primary doc location
- `/mnt/wsl/yourcrm/public/includes/logical/rmx-sync/UptimeRMX-CRM-Integration-Instructions.md`

## CRM paths (PHP)
- `/mnt/wsl/yourcrm/public/includes/logical/rmx-sync/RmxSynchronizer.php`
- `/mnt/wsl/yourcrm/public/includes/logical/rmx-sync/Api/RmxSyncApi.php`
- `/mnt/wsl/yourcrm/public/includes/logical/rmx-sync/Enums/SyncTables.php`
- `/mnt/wsl/yourcrm/public/includes/logical/rmx-sync/Models/` (DTOs)

## RMX paths (.NET)
- `UptimeRMX/UptimeRMX.Service/CrmSyncing/CrmSyncingInboxService.cs`
- `UptimeRMX/UptimeRMX.Service/CrmSyncing/SyncingInboxPayload.cs`
- `UptimeRMX/UptimeRMX.Service/CrmSyncing/JsonModels/` (CRM payload models)
- `UptimeRMX/UptimeRMX.Service/CrmSyncing/InboxMappers/` (mapping CRM -> RMX)
- `UptimeRMX/UptimeRMX/Models/Context/DefaultContext.cs`
- `UptimeRMX/UptimeRMX/Models/DefaultContextModels/` (EF Core entities)
- `UptimeRMX/UptimeRMX.Migrations/` (EF Core migrations)

## Existing sync pattern (high level)
- CRM writes changes into `sync_outbox` (via triggers) and bundles CRM entity data into a payload.
- CRM posts payload to RMX inbox endpoint.
- RMX stores payload, then `CrmSyncingInboxService` maps CRM entities and upserts into RMX DB.
- RMX -> CRM outbox and live sync are optional, event-driven additions.

## New entity checklist
- CRM: add triggers, SyncTables enum, DTO model, and payload population in `RmxSynchronizer.php`.
- RMX: add JsonModel, mapper, payload collection, EF Core model/migration if needed, and insert/update logic in `CrmSyncingInboxService.cs`.
- Validate: payload shape, dependency order, logs, and sync_outbox status.

## Dependency order reminder
Ensure parent entities sync before children to avoid FK errors.
