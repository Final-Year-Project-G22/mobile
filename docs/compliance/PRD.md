# Compliance Tracking — Mobile App

## Overview

The compliance feature helps users track business deadlines (tax registration, trade license, business registration). It connects to BusinessProfile data and guide step completion to auto-generate entries, while also supporting manual entry creation.

## Screens

### 1. Compliance Management Page (`/compliance/manage`)

Two sections:

```
Auto-tracked
├── Tax Registration                      [Edit]
│     TIN: 1234567890
│     Expires: Jan 15, 2026
│     Remind: 30 days before
│     Source: Auto-generated
│
├── Trade License                         [Edit]
│     Expires: Mar 20, 2026
│     Source: From guide step
│
Manual                                      [+]
└── (empty, tap + to add)
```

- Auto entries: status badge, source label, tap to edit expiry/reminder
- Manual entries: full CRUD via FAB
- Empty state: "Complete your business profile to auto-track compliance"

### 2. Compliance Entry Form (`/compliance/manage/add`)

| Field | Type |
|-------|------|
| Type | Dropdown from `GET /api/v1/compliance/types` |
| Reference Number | Text input |
| Issue Date | Date picker |
| Expiry Date | Date picker |
| Remind before | Number input (days) |

### 3. Entry Detail/Edit (`/compliance/manage/:id`)

- All fields editable
- Auto entries: type is read-only, source shown as label
- Manual entries: delete button available
- Save button

### 4. Settings Entry Point

"Compliance" list tile in Settings (visible only if BusinessProfile exists).

### 5. Calendar Enhancement

Existing Compliance tab gets a "Manage" button in AppBar.

## Routes

```
/compliance/manage          → ComplianceManagementPage
/compliance/manage/add      → ComplianceEntryFormPage (source=manual)
/compliance/manage/:id      → ComplianceEntryDetailPage
```

## Data Flow

```
BusinessProfile (source)
    │  (auto-generated)
    ▼
ComplianceEntry (source=auto)
    │  (user edits expiry/reminder)
    ▼
BusinessAlertScheduler → Notification → User

User creates manually (source=manual)
    │
    ▼
ComplianceEntry (source=manual)
    │
    ▼
BusinessAlertScheduler → Notification → User
```
