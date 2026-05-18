# UI Screens

## Notifications Tab — New 3-Tab Layout

The existing `InboxPage` gets a `TabBar` with 3 tabs:

```
┌─────────────────────────────────┐
│  [Inbox] [Scheduled] [Compliance] │  ← TabBar
├─────────────────────────────────┤
│                                 │
│    (Tab content here)           │
│                                 │
└─────────────────────────────────┘
│  Home  │ Guide │ Comty │ Templ. │  ← Bottom nav
└─────────────────────────────────┘
```

### Tab 1: Inbox (existing)
Unchanged. Lists system notifications, business alerts, etc.

### Tab 2: Scheduled Alerts
```
┌─────────────────────────────────┐
│  Scheduled Alerts          [+]  │  ← AppBar + FAB
├─────────────────────────────────┤
│                                 │
│  ○ Tax Filing Due              │  ← Pending (green dot)
│    Jun 15, 2026 · In-App       │
│    ┌──────┐ ┌─────────┐       │
│    │Edit  │ │ Cancel  │       │  ← Action buttons
│    └──────┘ └─────────┘       │
│                                 │
│  ✓ License Renewal             │  ← Sent (grey, checkmark)
│    May 1, 2026 · Email         │
│                                 │
│  ✕ Meeting Reminder            │  ← Cancelled (strikethrough)
│    Apr 20, 2026 · Push         │
│                                 │
│  ┌─────────────────────────┐   │
│  │  Upgrade to Pro to     │   │  ← Shown if limit reached
│  │  create more alerts    │   │
│  └─────────────────────────┘   │
│                                 │
└─────────────────────────────────┘
```

**Empty state:** Illustration + "No scheduled alerts yet. Tap + to create one."

### Tab 3: Compliance Calendar
```
┌─────────────────────────────────┐
│  Compliance Calendar      [⚙]  │  ← AppBar + settings icon
├─────────────────────────────────┤
│                                 │
│  Upcoming Deadlines            │  ← Section header
│                                 │
│  ⚠ Tax Registration           │  ← Urgent (≤7 days)
│    15 days · TIN: 1234567890  │
│    ┌─────────────────────┐    │
│    │  Create Alert       │    │  ← Quick-action button
│    └─────────────────────┘    │
│                                 │
│  ○ Trade License               │  ← Normal (>7 days)
│    45 days · LIC: ABC-123     │
│                                 │
│  ─── Scheduled Alerts ───     │  ← Section divider
│                                 │
│  ○ Tax Filing Due              │
│    Jun 15, 2026 (28 days)     │
│                                 │
└─────────────────────────────────┘
```

## Create Scheduled Alert Screen

```
┌─────────────────────────────────┐
│  ← New Scheduled Alert     Save │  ← AppBar
├─────────────────────────────────┤
│                                 │
│  Template                      │
│  ┌─────────────────────────┐   │
│  │ Tax Filing Reminder   ▼ │   │  ← Dropdown picker
│  └─────────────────────────┘   │
│                                 │
│  Title                         │
│  ┌─────────────────────────┐   │
│  │ Tax Filing Due          │   │  ← Pre-filled from template
│  └─────────────────────────┘   │
│                                 │
│  Body                          │
│  ┌─────────────────────────┐   │
│  │ Your tax filing         │   │
│  │ deadline is approaching │   │  ← Pre-filled, editable
│  └─────────────────────────┘   │
│                                 │
│  Channel                       │
│  [In-App] [Email] [Push]       │  ← Chip selector
│                                 │
│  Date & Time                   │
│  ┌─────────────────────────┐   │
│  │ Jun 15, 2026  8:00 AM  ▼│   │  ← Date/time picker
│  └─────────────────────────┘   │
│                                 │
│  ┌─────────────────────────┐   │
│  │  Schedule Alert         │   │  ← Primary button
│  └─────────────────────────┘   │
│                                 │
│  (Free users: 1 of 3 used)     │  ← Info chip
│                                 │
└─────────────────────────────────┘
```

**Validation:**
- Title required (max 255 chars)
- Body required
- Channel must be selected
- Date must be in the future
- Show counter: "2 of 3 used" for free users

**Error states:**
- Pro limit reached: show upgrade prompt instead of save button
- Network error: snackbar with retry
- Past date: inline error on date field

## Add Compliance Entry Screen

```
┌─────────────────────────────────┐
│  ← Add Compliance Entry   Save  │  ← AppBar
├─────────────────────────────────┤
│                                 │
│  Type                          │
│  ┌─────────────────────────┐   │
│  │ Tax Registration       ▼│   │  ← Dropdown (seeded types)
│  └─────────────────────────┘   │
│                                 │
│  Reference Number              │
│  ┌─────────────────────────┐   │
│  │ 1234567890              │   │
│  └─────────────────────────┘   │
│                                 │
│  Issue Date                    │
│  ┌─────────────────────────┐   │
│  │ Jan 15, 2025          ▼│   │
│  └─────────────────────────┘   │
│                                 │
│  Expiry Date                   │
│  ┌─────────────────────────┐   │
│  │ Jan 15, 2026          ▼│   │  ← Must be future
│  └─────────────────────────┘   │
│                                 │
│  Remind Me                     │
│  ┌─────────────────────────┐   │
│  │ 30 days before expiry  ▼│   │  ← Number input
│  └─────────────────────────┘   │
│                                 │
└─────────────────────────────────┘
```

## Compliance Management Screen

```
┌─────────────────────────────────┐
│  Compliance               [+]  │  ← AppBar + add FAB
├─────────────────────────────────┤
│                                 │
│  Tax Registration              │
│  TIN: 1234567890              │  ← Info row
│  Expires: Jan 15, 2026        │
│  Status: ● Active             │
│  Remind: 30 days before       │
│  ┌──────┐ ┌────────┐         │
│  │ Edit │ │ Delete │         │
│  └──────┘ └────────┘         │
│                                 │
│  ──────────────────────────    │
│                                 │
│  Trade License                 │
│  LIC: ABC-123                 │
│  Expires: Mar 20, 2026        │
│  Status: ● Active             │
│  ┌──────┐ ┌────────┐         │
│  │ Edit │ │ Delete │         │
│  └──────┘ └────────┘         │
│                                 │
└─────────────────────────────────┘
```

## Home Dashboard Widget

A small card section between `QuickActionsGrid` and `ContinueWhereYouLeftOff`:

```
┌─────────────────────────────────┐
│  Compliance Calendar      →     │  ← Section header + "See all"
├─────────────────────────────────┤
│                                 │
│  ⚠ Tax Registration           │
│    15 days remaining          │
│    ┌──────┐                   │
│    │Alert │                   │  ← Quick-create alert
│    └──────┘                   │
│                                 │
│  ○ Trade License               │
│    45 days remaining          │
│                                 │
│  ○ Business Registration       │
│    120 days remaining         │
│                                 │
└─────────────────────────────────┘
```

Shows max 3 entries. Tapping the header navigates to the full Compliance tab. Tapping "Alert" opens the Create Scheduled Alert form pre-filled with the compliance type.
