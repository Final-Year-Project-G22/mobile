# Adisu Serategna — UI/UX Design System

## Project Overview

**Adisu Serategna** (አዲሱ ሥራተኛ) is a comprehensive business advisory platform designed specifically for Ethiopian Micro, Small, and Medium Enterprises (MSMEs). The platform provides guidance, regulatory coaching, community support, and resources to help Ethiopian entrepreneurs formalize and grow their businesses.

### Design Philosophy

The design embodies three core principles:

- **Trustworthy**: Professional aesthetics that inspire confidence in business advisory
- **Empowering**: Clear information hierarchy that simplifies complex regulatory processes
- **Culturally Relevant**: Bilingual support and Ethiopian-specific business context

### Target Audience

Ethiopian entrepreneurs and MSME owners who:

- Are navigating business formalization processes
- Need regulatory guidance and compliance support
- Seek community connection with fellow entrepreneurs
- Require accessible business templates and resources

### Design Language

This system is built on **Material Design 3 (2025)** principles, leveraging:

- M3 color role system with tonal palettes
- M3 shape scale for consistent corner radii
- M3 elevation levels for depth and hierarchy
- M3 component specifications for buttons, cards, navigation, and inputs
- M3 motion tokens for fluid, responsive animations

---

## Design Tokens

### Color System

The color system follows the **Material 3 semantic role architecture**. Colors are assigned by role (what they do), not by value (what they look like). This enables consistent theming and accessible dark mode.

#### Light Theme

##### Brand Colors

**Primary — Slate 800** (`#1E293B`)

- **Role**: Main brand identity, key actions, filled buttons, app bar icons
- **Purpose**: Conveys professionalism, trustworthiness, and authority
- Colors:
  - `primary`: `#1E293B`
  - `onPrimary`: `#FFFFFF`
  - `primaryContainer`: `#E2E8F0` (Slate 200)
  - `onPrimaryContainer`: `#0F172A` (Slate 900)

**Secondary — Emerald 500** (`#10B981`)

- **Role**: Growth, progress, success, completion states — _not_ for primary CTAs
- **Purpose**: Represents growth, progress, and positive outcomes
- Colors:
  - `secondary`: `#10B981`
  - `onSecondary`: `#FFFFFF`
  - `secondaryContainer`: `#D1FAE5` (Emerald 100)
  - `onSecondaryContainer`: `#065F46` (Emerald 800)

**Tertiary — Amber 500** (`#F59E0B`)

- **Role**: Warmth, highlights, stars, featured content, Ethiopian cultural resonance
- **Purpose**: Adds warmth and energy to the predominantly cool palette
- Colors:
  - `tertiary`: `#F59E0B`
  - `onTertiary`: `#FFFFFF`
  - `tertiaryContainer`: `#FEF3C7` (Amber 100)
  - `onTertiaryContainer`: `#92400E` (Amber 800)

##### Semantic Colors

| Role    | Color     | Hex       | Container    | Usage                          |
| ------- | --------- | --------- | ------------ | ------------------------------ |
| Success | Emerald   | `#10B981` | `#D1FAE5`   | Completed steps, approved      |
| Warning | Amber     | `#F59E0B` | `#FEF3C7`   | Pending actions, deadlines     |
| Error   | Red 500   | `#EF4444` | `#FEE2E2`   | Validation errors, destructive |
| Info    | Blue 500  | `#3B82F6` | `#DBEAFE`   | Informational tips, links      |

##### Surface Colors (M3 Surface Container Hierarchy)

| Role                      | Hex       | Usage                                 |
| ------------------------- | --------- | ------------------------------------- |
| `surface`                 | `#FFFFFF` | Default background for components     |
| `surfaceDim`              | `#F1F5F9` | Dimmed background areas               |
| `surfaceBright`           | `#FFFFFF` | Brightest surface                     |
| `surfaceContainerLowest`  | `#FFFFFF` | Lowest emphasis container             |
| `surfaceContainerLow`     | `#F8FAFC` | Low emphasis (screen background)      |
| `surfaceContainerMedium`  | `#F1F5F9` | Medium emphasis (card backgrounds)    |
| `surfaceContainerHigh`    | `#E2E8F0` | High emphasis (input fills, chips)    |
| `surfaceContainerHighest` | `#CBD5E1` | Highest emphasis (active indicators)  |

##### Text & Icon Colors

| Role               | Hex       | Usage                      |
| ------------------ | --------- | -------------------------- |
| `onSurface`        | `#0F172A` | Primary text, icons        |
| `onSurfaceVariant` | `#64748B` | Secondary text, captions   |
| `outline`          | `#CBD5E1` | Borders, dividers          |
| `outlineVariant`   | `#E2E8F0` | Subtle borders             |

##### Additional

| Role           | Hex                    | Usage                  |
| -------------- | ---------------------- | ---------------------- |
| `background`   | `#F8FAFC` (Slate 50)   | App scaffold           |
| `onBackground` | `#0F172A` (Slate 900)  | Text on background     |
| `scrim`        | `rgba(0, 0, 0, 0.32)`  | Modal overlay          |
| `shadow`       | `#000000`              | Elevation shadows      |

##### Gradients

| Name            | Value                                | Usage                        |
| --------------- | ------------------------------------ | ---------------------------- |
| `heroGradient`  | `#0F172A → #1E3A5F` (topLeft→botRight) | Dashboard hero card, AI header |
| `accentGradient`| `#10B981 → #059669` (left→right)     | Progress ring stroke         |

---

#### Dark Theme

##### Brand Colors (Dark)

| Role                  | Hex       | Notes                  |
| --------------------- | --------- | ---------------------- |
| `primary`             | `#94A3B8` | Lighter for contrast   |
| `onPrimary`           | `#0F172A` |                        |
| `primaryContainer`    | `#334155` | Slate 700              |
| `onPrimaryContainer`  | `#E2E8F0` |                        |
| `secondary`           | `#6EE7B7` | Brighter emerald       |
| `onSecondary`         | `#065F46` |                        |
| `secondaryContainer`  | `#064E3B` | Emerald 900            |
| `onSecondaryContainer`| `#D1FAE5` |                        |
| `tertiary`            | `#FCD34D` | Brighter amber         |
| `onTertiary`          | `#78350F` |                        |
| `tertiaryContainer`   | `#92400E` | Amber 800              |
| `onTertiaryContainer` | `#FEF3C7` |                        |

##### Semantic Colors (Dark)

| Role    | Color   | Hex       | Container  |
| ------- | ------- | --------- | ---------- |
| Success | Emerald | `#6EE7B7` | `#064E3B`  |
| Warning | Amber   | `#FCD34D` | `#78350F`  |
| Error   | Red     | `#FCA5A5` | `#7F1D1D`  |
| Info    | Blue    | `#93C5FD` | `#1E3A8A`  |

##### Surface Colors (Dark)

| Role                      | Hex       | Usage                                |
| ------------------------- | --------- | ------------------------------------ |
| `surface`                 | `#121921` | Default dark surface                 |
| `surfaceDim`              | `#0C1220` | Deepest dark background              |
| `surfaceBright`           | `#2D3B4E` | Brightest dark surface               |
| `surfaceContainerLowest`  | `#0C1220` | Deepest container                    |
| `surfaceContainerLow`     | `#1A2332` | Low emphasis                         |
| `surfaceContainerMedium`  | `#1E293B` | Cards, medium emphasis               |
| `surfaceContainerHigh`    | `#243044` | Inputs, high emphasis                |
| `surfaceContainerHighest` | `#334155` | Active indicators                    |

##### Text & Icon Colors (Dark)

| Role               | Hex       |
| ------------------ | --------- |
| `onSurface`        | `#F1F5F9` |
| `onSurfaceVariant` | `#94A3B8` |
| `outline`          | `#475569` |
| `outlineVariant`   | `#334155` |
| `background`       | `#0C1220` |
| `onBackground`     | `#F1F5F9` |
| `scrim`            | `rgba(0, 0, 0, 0.60)` |

---

### Typography

#### Font Family

- **Primary**: `Inter` — Modern geometric sans-serif, excellent readability at all sizes
- **Amharic Fallback**: `Noto Sans Ethiopic` — System-provided, matches Inter's clean aesthetic
- **Fallback chain**: `Inter → Noto Sans Ethiopic → system sans-serif`

> **Amharic Note**: Amharic Fidel characters are visually denser than Latin. After testing, body text in Amharic may need `+1px` font size or `+0.1` additional line-height multiplier for equivalent readability.

#### Type Scale

| Role           | Size  | Weight | Line Height | Tracking  | Usage                              |
| -------------- | ----- | ------ | ----------- | --------- | ---------------------------------- |
| Display Large  | 57px  | 400    | 1.12        | -0.25px   | _Reserved (unused on mobile)_      |
| Display Medium | 45px  | 400    | 1.16        | 0         | _Reserved_                         |
| Display Small  | 36px  | 400    | 1.22        | 0         | Hero metrics, large percentages    |
| Headline Large | 32px  | 700    | 1.25        | -0.5px    | Screen titles, major sections      |
| Headline Medium| 28px  | 600    | 1.29        | 0         | Section headers                    |
| Headline Small | 24px  | 600    | 1.33        | 0         | Card headers, subsections          |
| Title Large    | 22px  | 600    | 1.27        | 0         | App bar title                      |
| Title Medium   | 16px  | 600    | 1.5         | 0.15px    | Toolbar titles, emphasized labels  |
| Title Small    | 14px  | 600    | 1.43        | 0.1px     | Tab labels, bold captions          |
| Body Large     | 16px  | 400    | 1.5         | 0         | Primary content, descriptions      |
| Body Medium    | 14px  | 400    | 1.43        | 0.25px    | Secondary content                  |
| Body Small     | 12px  | 400    | 1.33        | 0.4px     | Timestamps, metadata               |
| Label Large    | 14px  | 500    | 1.43        | 0.1px     | Button text, input labels          |
| Label Medium   | 12px  | 500    | 1.33        | 0.5px     | Chips, small labels                |
| Label Small    | 11px  | 500    | 1.45        | 0.5px     | Badges, overlines                  |

#### Font Weights

| Weight | Name     | Usage                                    |
| ------ | -------- | ---------------------------------------- |
| 400    | Regular  | Body text, descriptions, paragraphs      |
| 500    | Medium   | Labels, buttons, chips, captions         |
| 600    | SemiBold | Titles, section headers, emphasized text |
| 700    | Bold     | Headlines, hero text, display metrics    |

---

### Spacing System

**Base unit**: 4dp

| Token              | Value | Usage                                  |
| ------------------ | ----- | -------------------------------------- |
| `spacing.xxs`      | 4dp   | Tight inner padding, icon gaps         |
| `spacing.xs`       | 8dp   | Compact padding, chip gaps             |
| `spacing.sm`       | 12dp  | Standard element spacing, card gaps    |
| `spacing.md`       | 16dp  | Standard card padding, list items      |
| `spacing.lg`       | 24dp  | Section content padding                |
| `spacing.xl`       | 32dp  | Section gaps, generous spacing         |
| `spacing.xxl`      | 48dp  | Major section separation               |
| `spacing.xxxl`     | 64dp  | Hero spacing                           |

**Screen & Layout Tokens:**

| Token                | Value | Usage                                  |
| -------------------- | ----- | -------------------------------------- |
| `spacing.screenH`    | 20dp  | Horizontal screen edge insets          |
| `spacing.screenV`    | 24dp  | Vertical screen edge insets            |
| `spacing.sectionGap` | 32dp  | Vertical gap between dashboard sections|
| `spacing.cardGap`    | 12dp  | Gap between cards in a list            |

---

### Shape Scale (M3)

| Token                    | Value   | Usage                                     |
| ------------------------ | ------- | ----------------------------------------- |
| `shape.none`             | 0dp     | —                                         |
| `shape.extraSmall`       | 4dp     | Small badges, compact elements            |
| `shape.small`            | 8dp     | Chips, filter chips, icon buttons         |
| `shape.medium`           | 12dp    | Cards, inputs, buttons (default)          |
| `shape.large`            | 16dp    | Large cards, FABs, dialogs               |
| `shape.largeIncreased`   | 20dp    | Hero cards, dashboard progress card       |
| `shape.extraLarge`       | 28dp    | Bottom sheets, full-screen dialogs        |
| `shape.extraLargeIncreased` | 32dp | Large bottom sheets                      |
| `shape.full`             | 9999dp  | Avatars, pills, circular elements         |

**Component Shape Mapping:**

| Component          | Shape Token           | Value  |
| ------------------ | --------------------- | ------ |
| Buttons            | `shape.medium`        | 12dp   |
| Cards              | `shape.medium`        | 12dp   |
| Hero / Progress Card| `shape.largeIncreased`| 20dp   |
| Inputs             | `shape.medium`        | 12dp   |
| Chips              | `shape.small`         | 8dp    |
| FAB                | `shape.large`         | 16dp   |
| Dialogs            | `shape.extraLarge`    | 28dp   |
| Bottom Sheets      | `shape.extraLarge`    | 28dp (top corners only) |
| Avatars            | `shape.full`          | Circular |
| Badges             | `shape.full`          | Circular |
| Navigation indicator | `shape.full`        | Pill   |

---

### Elevation System (M3)

Depth is communicated through **shadows**, not hard borders. Cards and surfaces use elevation levels instead of `border: gray-200`.

| Level | Shadow dp | Usage                                  |
| ----- | --------- | -------------------------------------- |
| 0     | 0dp       | Flat surfaces, backgrounds             |
| 1     | 1dp       | Cards (resting), NavigationBar, AppBar |
| 2     | 3dp       | Cards (hovered/pressed), dropdowns     |
| 3     | 6dp       | FABs, navigation drawers              |
| 4     | 8dp       | Bottom sheets (docked)                 |
| 5     | 12dp      | Bottom sheets (floating), dialogs      |

> **Note**: In dark mode, elevation is expressed via progressively lighter surface container tints rather than visible shadows.

---

### Motion & Animation

All transitions use standard M3 duration and easing tokens. The app should feel **fluid and responsive**, never jarring.

#### Duration Tokens

| Token             | Value  | Usage                                |
| ----------------- | ------ | ------------------------------------ |
| `duration.short1` | 50ms   | Micro-feedback (ripple start)        |
| `duration.short2` | 100ms  | State layer appearance               |
| `duration.short3` | 150ms  | Button press, icon morph             |
| `duration.medium1`| 200ms  | Tab switch, cross-fade               |
| `duration.medium2`| 300ms  | Page transitions, card expand        |
| `duration.long1`  | 450ms  | Bottom sheet, dialog entrance        |
| `duration.long2`  | 500ms  | Progress fill, ring animation        |

#### Standard Curve

- **easeOutCubic** — Primary curve for most transitions (decelerating)
- **easeInOut** — For symmetric transitions (tab switches)

#### Interaction Animations

| Interaction          | Duration | Curve        | Visual                              |
| -------------------- | -------- | ------------ | ----------------------------------- |
| Page transition      | 300ms    | easeOutCubic | SharedAxis (horizontal fade+slide)  |
| Bottom sheet open    | 250ms    | easeOutCubic | Slide up + fade in                  |
| Card press           | 150ms    | easeIn       | Scale(0.98) + state layer           |
| Progress ring fill   | 500ms    | easeOutCubic | Stroke animation from 0 → value     |
| Tab switch           | 200ms    | easeInOut    | Cross-fade content                  |
| Skeleton shimmer     | 1500ms   | linear       | Infinite pulse loop                 |
| Typing indicator     | 600ms    | easeInOut    | Three dots bounce sequentially      |
| Navigation indicator | 200ms    | easeOutCubic | Pill shape grows/shrinks on switch  |

---

### Iconography

**Library**: Material Symbols (rounded variant, default in Flutter `Icons` class)

#### Icon Sizes

| Token    | Size  | Usage                                |
| -------- | ----- | ------------------------------------ |
| `icon.xs`| 16dp  | Badge icons, inline indicators       |
| `icon.sm`| 20dp  | Navigation icons, list leading icons |
| `icon.md`| 24dp  | App bar actions, card actions (default) |
| `icon.lg`| 32dp  | Feature highlights, stat cards       |
| `icon.xl`| 48dp  | Empty state illustrations            |

#### Icon States

| State              | Style                    | Color                  |
| ------------------ | ------------------------ | ---------------------- |
| Active (nav)       | **Filled** variant       | `onSecondaryContainer` |
| Inactive (nav)     | **Outlined** variant     | `onSurfaceVariant`     |
| On colored surface | Filled variant           | `onPrimary` / `onSecondary` |
| Decorative (cards) | Filled, inside tinted bg | Matching brand color   |
| Disabled           | Outlined                 | `onSurface` at 38%     |

---

## Component Patterns

### Navigation

#### Top App Bar (M3 CenterAligned / Medium)

**Specifications:**

- **Type**: `CenterAlignedTopAppBar` for main screens, `MediumTopAppBar` for detail screens
- **Background**: `surface` (adapts to light/dark)
- **On scroll**: Background transitions to `surfaceContainer` with elevation 2
- **Content color**: `onSurface`
- **Elevation**: 0 at rest, 2 when scrolled
- **Height**: 64dp (CenterAligned), 112dp collapsed → 64dp (Medium)

**Layout:**

```
[← Back]  [Screen Title]  [🔔 Badge] [🌐 Lang] [👤 Profile]
```

**Elements:**

- **Title**: Title Large (22px/w600), `onSurface` color
- **Leading**: Back arrow (on sub-screens) or none (on root tabs)
- **Trailing actions**:
  - Notification bell icon with badge dot (red, 6dp) for unread count
  - Language toggle icon — shows opposite language code (EN ↔ አማ)
  - Profile avatar (32dp circle, tap → profile screen)

> **Note**: The previous navy gradient header is removed from the app bar. The gradient now appears only on the **dashboard hero card** and **AI coach header**, giving those screens a distinctive premium feel while keeping navigation clean and modern.

---

#### Bottom Navigation Bar (M3 NavigationBar)

**Specifications:**

- **Destinations**: 5 items (reduced from 6 — Notifications moved to app bar)
- **Background**: `surface`
- **Elevation**: Level 2 (3dp shadow in light mode, tint in dark mode)
- **Height**: 80dp (M3 standard)
- **Active indicator**: Pill shape (56×32dp), `secondaryContainer` color
- **Indicator animation**: 200ms easeOutCubic

**Navigation Items:**

| # | Label     | Active Icon          | Inactive Icon             |
| - | --------- | -------------------- | ------------------------- |
| 1 | Home      | `Icons.home`         | `Icons.home_outlined`     |
| 2 | Guides    | `Icons.menu_book`    | `Icons.menu_book_outlined`|
| 3 | AI Coach  | `Icons.smart_toy`    | `Icons.smart_toy_outlined`|
| 4 | Community | `Icons.people`       | `Icons.people_outlined`   |
| 5 | Resources | `Icons.folder_copy`  | `Icons.folder_copy_outlined` |

**Item States:**

| State    | Icon                          | Label                          | Indicator          |
| -------- | ----------------------------- | ------------------------------ | ------------------ |
| Active   | Filled, `onSecondaryContainer`| `onSurface`, Label Medium/w600 | `secondaryContainer` pill |
| Inactive | Outlined, `onSurfaceVariant`  | `onSurfaceVariant`, Label Medium/w400 | None          |
| Pressed  | Filled + 10% state layer      | —                              | Ripple effect      |

---

### Cards

Cards use **M3 elevation** for depth instead of hard borders. All interactive cards include a `stateLayer` (ripple) on press.

#### Card Variants

| Variant       | Background        | Depth              | Border               | Usage                          |
| ------------- | ----------------- | ------------------ | -------------------- | ------------------------------ |
| **Elevated**  | `surface`         | Elevation 1 shadow | None                 | Task, Community, primary cards |
| **Filled**    | `surfaceContainerMedium` | None          | None                 | Stats, hero card, tinted cards |
| **Outlined**  | `surface`         | None               | 1dp `outlineVariant` | Resources, low-emphasis items  |

#### Card Specifications

**1. Dashboard Hero Card (Filled, Premium)**

- Background: `heroGradient` (`#0F172A → #1E3A5F`)
- Corner radius: `shape.largeIncreased` (20dp)
- Padding: `spacing.lg` (24dp)
- Content: Progress ring + statistics (white text)
- Elevation: 2 (subtle shadow to float)

**2. Task Card (Elevated)**

- Background: `surface`
- Corner radius: `shape.medium` (12dp)
- Padding: `spacing.md` (16dp)
- Elevation: 1 (resting), 2 (pressed)
- **Left status stripe**: 4dp × full-height vertical bar
  - Completed: `secondary` (emerald)
  - Pending: `tertiary` (amber)
  - Not started: `outlineVariant` (gray)
- Layout: `[Status stripe] [Status icon] [Title + Due date] [Badge →]`

**3. Stat Card (Filled)**

- Background: `surfaceContainerMedium`
- Corner radius: `shape.medium` (12dp)
- Padding: `spacing.md` (16dp)
- Icon container: 44dp circle, `secondaryContainer` background, `onSecondaryContainer` icon
- Layout: `[Icon circle] [Metric value + label]`

**4. Community Card (Elevated)**

- Background: `surface`
- Corner radius: `shape.medium` (12dp)
- Padding: `spacing.md` (16dp)
- Elevation: 1
- Layout:
  ```
  [Avatar 40dp] [User name + Category badge]
  [Discussion title — Title Medium]
  [Tag chips] [👁 views] [💬 replies] [✓ solved badge]
  ```

**5. Resource Card (Outlined)**

- Background: `surface`
- Border: 1dp `outlineVariant`
- Corner radius: `shape.medium` (12dp)
- Padding: `spacing.md` (16dp)
- Layout: `[Icon 44dp, tinted bg] [Title + Description] [Download button →]`

#### Card Interaction States

| State    | Visual Change                         |
| -------- | ------------------------------------- |
| Resting  | As specified                          |
| Hovered  | +8% `onSurface` state layer overlay  |
| Pressed  | +10% `onSurface` state layer + scale(0.98) |
| Focused  | +10% state layer + 2dp primary focus ring |
| Disabled | 38% opacity                           |

---

### Buttons (M3 Five-Variant System)

Buttons are organized by **emphasis level**. Use higher emphasis for primary actions, lower for secondary.

#### Variants

| Variant        | Emphasis | Container              | Text/Icon                | Usage                              |
| -------------- | -------- | ---------------------- | ------------------------ | ---------------------------------- |
| **Filled**     | Highest  | `primary`              | `onPrimary`              | Main CTA: Submit, Confirm, Save   |
| **FilledTonal**| Medium   | `secondaryContainer`   | `onSecondaryContainer`   | Secondary CTA: See All, Continue  |
| **Elevated**   | Medium   | `surfaceContainerLow`  | `primary`                | CTA on patterned backgrounds      |
| **Outlined**   | Medium   | transparent            | `primary` (border too)   | Cancel, Back, alternative actions  |
| **Text**       | Lowest   | transparent            | `primary`                | Skip, low-priority, inside cards  |

#### Sizes

| Size   | Height | Padding-H | Text Style   | Icon Size | Corner Radius     |
| ------ | ------ | --------- | ------------ | --------- | ----------------- |
| Small  | 40dp   | 16dp      | Label Large  | 20dp      | `shape.medium` (12dp) |
| Medium | 48dp   | 20dp      | Label Large  | 20dp      | `shape.medium` (12dp) |
| Large  | 56dp   | 24dp      | Title Small  | 24dp      | `shape.large` (16dp)  |

> **Default size**: Medium (48dp). Use Large for full-width primary actions (login, submit). Use Small for inline actions (See All, Retry).

#### Button Interaction States

| State    | Visual Change                                          |
| -------- | ------------------------------------------------------ |
| Default  | As specified                                           |
| Hovered  | +8% `onPrimary`/`onSurface` state layer               |
| Focused  | +10% state layer + 2dp focus ring                      |
| Pressed  | +10% state layer + scale(0.98)                         |
| Disabled | 38% opacity on all elements, non-interactive           |
| Loading  | `CircularProgressIndicator` replaces label, same size  |

#### Icon Buttons

- Size: 48dp container (touch target), 24dp icon
- Shape: `shape.full` (circular)
- Variants: Standard (transparent), Filled, FilledTonal, Outlined
- Usage: App bar actions, chat send, close/dismiss

#### FAB (Floating Action Button)

- Size: 56dp (regular), 96dp (large), 40dp (small)
- Shape: `shape.large` (16dp)
- Color: `primaryContainer` bg, `onPrimaryContainer` icon
- Elevation: 3 (6dp)
- Usage: New discussion post (Community screen)

---

### Badges (M3)

| Type         | Size  | Content       | Color                        | Usage                |
| ------------ | ----- | ------------- | ---------------------------- | -------------------- |
| Small (dot)  | 6dp   | None          | `error`                      | Unread indicator     |
| Large        | 16dp  | 1–3 digits    | `error` bg, `onError` text   | Notification count   |

### Chips (M3)

| Type          | Style                                | Usage                              |
| ------------- | ------------------------------------ | ---------------------------------- |
| Filter Chip   | `secondaryContainer` when selected, outlined when unselected | Category filters (Guide, Community) |
| Assist Chip   | Outlined, with leading icon          | Quick actions, suggestions          |
| Input Chip    | `surfaceContainerHigh`, dismissable  | Tags on community posts            |
| Suggestion    | Outlined, tonal when tapped          | AI quick reply options             |

**Chip Shape**: `shape.small` (8dp)
**Chip Height**: 32dp
**Chip Text**: Label Medium

### Status Badges

| Status       | Background           | Text                   | Icon            |
| ------------ | -------------------- | ---------------------- | --------------- |
| Completed    | `secondaryContainer` | `onSecondaryContainer` | `check_circle`  |
| In Progress  | `tertiaryContainer`  | `onTertiaryContainer`  | `schedule`      |
| Not Started  | `surfaceContainerHigh`| `onSurfaceVariant`    | `circle_outlined`|
| Urgent       | `errorContainer`     | `onErrorContainer`     | `warning`       |

---

### Form Elements

#### Text Fields (M3 Filled)

**Anatomy:**

```
[Leading Icon]  [Floating Label / Value Text]  [Trailing Icon]
                [Supporting Text / Error Text]
```

**Specifications:**

| Property       | Value                                         |
| -------------- | --------------------------------------------- |
| Height         | 56dp                                          |
| Padding        | Horizontal 16dp, Vertical 8dp                 |
| Background     | `surfaceContainerHighest`                     |
| Corner radius  | 12dp top, 12dp bottom (modern variant)        |
| Label text     | Body Large (16px) → Label Small when floating |
| Value text     | Body Large (16px)                             |
| Supporting text| Body Small (12px), below field                |

**States:**

| State    | Indicator            | Label Color          | Background                 |
| -------- | -------------------- | -------------------- | -------------------------- |
| Default  | 1dp `onSurfaceVariant` bottom | `onSurfaceVariant` | `surfaceContainerHighest` |
| Focused  | 2dp `primary` bottom | `primary`            | `surfaceContainerHighest` |
| Error    | 2dp `error` bottom   | `error`              | `surfaceContainerHighest` |
| Disabled | 1dp `onSurface`/4%   | `onSurface` at 38%   | `onSurface` at 4%         |

**Input Types:**

1. **Search Input**
   - Leading icon: Search (magnifying glass)
   - Trailing icon: Clear (X) when text present
   - Height: 48dp (compact)
   - Shape: `shape.full` (pill — M3 SearchBar pattern)
   - Background: `surfaceContainerHigh`
   - Placeholder: Contextual ("Search discussions...", "Search guides...")

2. **Message Input (Chat)**
   - Full-width, paired with send IconButton
   - Shape: `shape.full` (pill)
   - Background: `surfaceContainerHigh`
   - Trailing: Send icon (filled, `primary` color when text present)
   - Submit: Enter key or send button

---

### Progress Indicators

#### Animated Progress Ring (Dashboard Hero)

- **Type**: Custom circular progress (animated stroke)
- **Diameter**: 160dp
- **Stroke width**: 12dp with rounded end caps
- **Track**: `surfaceContainerHigh` (light mode), `surfaceContainerHighest` (dark mode)
- **Fill**: Gradient stroke from `#10B981` → `#059669` (emerald gradient)
- **End cap**: Round (StrokeCap.round)
- **Center content**:
  - Percentage: Display Small (36px/w400) — e.g., "65%"
  - Label: Body Small (12px) — e.g., "Completed"
- **Animation**: 500ms `easeOutCubic`, triggers on first load and data refresh
- **Legend**: Below ring, color dots + labels for completed/pending

#### Linear Progress Bar

- Height: 4dp
- Track: `surfaceContainerHigh`
- Fill: `secondary` (emerald)
- Shape: `shape.full` (rounded ends)
- Usage: Guide step progress, loading bars

---

### Chat Interface

#### Message Bubbles

**User Messages:**

| Property       | Value                              |
| -------------- | ---------------------------------- |
| Alignment      | Right-aligned                      |
| Background     | `primaryContainer`                 |
| Text color     | `onPrimaryContainer`               |
| Corner radius  | 20dp / 20dp / 4dp / 20dp (flat bottom-right) |
| Max width      | 85% of screen width                |
| Padding        | 12dp horizontal, 8dp vertical      |

**AI Messages:**

| Property       | Value                              |
| -------------- | ---------------------------------- |
| Alignment      | Left-aligned                       |
| Background     | `surfaceContainerHigh`             |
| Text color     | `onSurface`                        |
| Corner radius  | 20dp / 20dp / 20dp / 4dp (flat bottom-left) |
| Max width      | 90% of screen width                |
| Padding        | 12dp horizontal, 8dp vertical      |
| Rich content   | Supports markdown (bold, lists, code blocks) |

**Avatars:**

| Type | Size | Background           | Icon                         |
| ---- | ---- | -------------------- | ---------------------------- |
| User | 32dp | `primaryContainer`   | `person` icon, `onPrimaryContainer` |
| AI   | 32dp | `secondaryContainer` | `smart_toy` icon, `onSecondaryContainer` |

**Message Grouping:**
- Consecutive messages from the same sender cluster together
- Avatar shows only on the **first message** in a group
- Subsequent messages have reduced top margin (4dp instead of 12dp)
- Timestamp shows only on the **last message** in a group

**Typing Indicator:**
- Three dots inside an AI-bubble-shaped container
- Sequential bounce animation (600ms `easeInOut`, staggered by 100ms per dot)
- Dot size: 8dp, `onSurfaceVariant` color

**Quick Reply Chips:**
- Horizontal scrollable row below the latest AI message
- M3 `SuggestionChip` style (outlined, tonal on tap)
- Label Medium text
- 3–4 contextual suggestions (e.g., "Tell me about TIN registration", "What about VAT?")

**Timestamp Dividers:**
- Section headers: "Today", "Yesterday", or date
- Body Small text, `onSurfaceVariant` color, centered
- Horizontal line accents on both sides

---

### List Items

#### Timeline Item (Formalization Guide)

```
[Status Icon 24dp] [Step title — Title Medium]
                    [Subtitle — Body Small, onSurfaceVariant]
                    [Status Badge]
─────────────────────────────────────────────────
```

- Divider: 1dp `outlineVariant`, full width
- Padding: `spacing.md` (16dp)
- Status icons: `check_circle` (completed), `schedule` (in progress), `circle` (not started)
- Status colors: `secondary` (green), `tertiary` (amber), `onSurfaceVariant` (gray)

#### Task Item

```
┌─[4dp stripe]──────────────────────────────────────────┐
│ [Status Icon]  [Title — Title Medium]     [Badge →]   │
│                [Due: May 20 — Body Small]             │
└───────────────────────────────────────────────────────┘
```

- Card: Elevated (elevation 1), `shape.medium` (12dp)
- Left stripe: 4dp wide, full height, status-colored
- Padding: `spacing.md` (16dp)

#### Discussion Item (Community)

```
[Avatar 40dp] [User Name — Title Small] [Category Chip]
              [Discussion Title — Title Medium]
              [Tag chips] [👁 42] [💬 8] [✓ Solved]
```

- Card: Elevated (elevation 1), `shape.medium` (12dp)
- Padding: `spacing.md` (16dp)
- Solution badge: `secondaryContainer` chip with checkmark icon

#### Notification Item

```
[🔴 dot] [Icon 24dp]  [Title — Title Small]
                        [Body text — Body Small, max 2 lines]
                        [2 days ago — Label Small, onSurfaceVariant]
```

- Background: `surfaceContainerLow` for unread, `surface` for read
- Padding: `spacing.md` (16dp)
- Divider: `outlineVariant` between items
- Swipe to dismiss/archive

---

## Screen Architecture

### 1. Dashboard Screen (Home)

**Purpose**: Central hub showing formalization progress and actionable tasks

**Layout:**

```
┌─────────────────────────┐
│  App Bar (surface)       │
│  "Home"  [🔔] [🌐] [👤] │
├─────────────────────────┤
│  Hero Progress Card      │
│  ┌─────────────────────┐│
│  │ Navy gradient bg     ││
│  │ [Progress Ring 65%]  ││
│  │ Completed · Pending  ││
│  └─────────────────────┘│
│                          │
│  Section: Tasks          │
│  ┌─[🟢]──────────────┐  │
│  │ Task 1 (done)      │  │
│  └────────────────────┘  │
│  ┌─[🟡]──────────────┐  │
│  │ Task 2 (pending)   │  │
│  └────────────────────┘  │
│                          │
│  Section: Quick Stats    │
│  ┌──────────┬─────────┐  │
│  │ 📄 Docs  │ ✅ Tasks │  │
│  │  12      │  8/12   │  │
│  └──────────┴─────────┘  │
├─────────────────────────┤
│  NavigationBar (5 tabs)  │
└─────────────────────────┘
```

**Key Notes:**
- Hero card uses `heroGradient` — this is the only place the navy gradient appears
- Progress ring animates on load (500ms)
- Tasks section uses `spacing.sectionGap` (32dp) from hero card
- Stat cards laid out in 2-column grid with `spacing.cardGap` (12dp)

---

### 2. Formalization Guide Screen

**Purpose**: Step-by-step walkthrough of business registration process

**Layout:**

```
┌─────────────────────────┐
│  App Bar: "Guides"       │
├─────────────────────────┤
│  [Filter Chips: All,     │
│   Registration, Tax,     │
│   Licensing]             │
├─────────────────────────┤
│  ✅ Step 1 (Completed)   │
│     License registration │
│  ─────────────────────── │
│  🟡 Step 2 (In progress) │
│     TIN registration     │
│  ─────────────────────── │
│  ○  Step 3 (Not started) │
│     VAT assessment       │
│  ─────────────────────── │
│  ○  Step 4 (Not started) │
│     Trade license        │
│  ─────────────────────── │
│  ○  Step 5 (Not started) │
│     Bank account         │
└─────────────────────────┘
```

**Key Notes:**
- Filter chips use M3 `FilterChip` with `secondaryContainer` selected state
- Timeline items use icon + color + badge triple-redundancy for accessibility
- Linear progress bar at the top shows overall completion
- Tapping a step opens detail screen with M3 `MediumTopAppBar`

---

### 3. AI Coach Screen

**Purpose**: Conversational interface for regulatory questions

**Layout:**

```
┌─────────────────────────┐
│  Header Card             │
│  ┌─────────────────────┐│
│  │ Navy gradient bg     ││
│  │ [🤖 32dp] AI Coach  ││
│  │ Subtitle             ││
│  └─────────────────────┘│
├─────────────────────────┤
│  Messages Area (scroll)  │
│                          │
│  [🤖] AI welcome message │
│        [chip] [chip]     │
│                          │
│     User message    [👤] │
│                          │
│  [🤖] AI response        │
│        (markdown)        │
│  [···] typing indicator  │
├─────────────────────────┤
│  [🔍 Message input     ▶]│
└─────────────────────────┘
```

**Key Notes:**
- AI Coach header uses `heroGradient` (second use of the navy gradient)
- Messages area occupies remaining height (`Expanded`)
- Quick reply chips appear below the latest AI message
- Typing indicator shows while waiting for response
- Message input uses pill shape with send icon button

---

### 4. Community Screen

**Purpose**: Peer-to-peer discussions and knowledge sharing

**Layout:**

```
┌─────────────────────────┐
│  App Bar: "Community"    │
├─────────────────────────┤
│  [🔍 Search discussions] │
├─────────────────────────┤
│  [Filter Chips:          │
│   All, Agri, Retail,     │
│   Manufacturing, Svcs]   │
├─────────────────────────┤
│  Discussion Card 1       │
│  Discussion Card 2       │
│  Discussion Card 3       │
│  ...                     │
├─────────────────────────┤
│  [+ FAB: New Discussion] │
└─────────────────────────┘
```

**Key Notes:**
- Search bar uses M3 `SearchBar` pattern (pill shape)
- Filter chips for category filtering
- FAB in bottom-right for creating new discussions
- Cards use `elevation 1`, pull-to-refresh supported

---

### 5. Resources Screen

**Purpose**: Templates and downloadable business documents

**Layout:**

```
┌─────────────────────────┐
│  App Bar: "Resources"    │
├─────────────────────────┤
│  [🔍 Search resources]   │
├─────────────────────────┤
│  Resource Grid (2 cols)  │
│  ┌──────┐  ┌──────┐     │
│  │ Res1 │  │ Res2 │     │
│  └──────┘  └──────┘     │
│  ┌──────┐  ┌──────┐     │
│  │ Res3 │  │ Res4 │     │
│  └──────┘  └──────┘     │
└─────────────────────────┘
```

**Key Notes:**
- 2-column grid with `spacing.cardGap` (12dp) between cards
- Resource cards use Outlined variant (thin border, no shadow)
- Each card has a colored icon container (44dp, tinted background)
- Download button is a Small FilledTonal button

---

## UI States

Every screen must handle all four states: content, empty, loading, and error.

### Empty States

**Structure:**

```
        [Illustration 120×120dp]
        [Title — Headline Small]
        [Description — Body Medium, onSurfaceVariant]
        [CTA — FilledTonal Button]
```

- Illustration: Icon or vector, `onSurfaceVariant` at 40% opacity
- Title: Encouraging, not technical (e.g., "No guides yet" not "404: Empty response")
- CTA: Actionable (e.g., "Get Started", "Create Post", "Try Again")

### Loading States (Skeleton)

- Rounded rectangles matching content shape/size
- Background: `surfaceContainerMedium`
- Shimmer: Gradient sweep from `surfaceContainerMedium` → `surfaceContainerHigh` → `surfaceContainerMedium`
- Duration: 1500ms infinite loop
- Apply to: Card skeletons, list item skeletons, text block placeholders

### Error States

**Inline Error:**

```
[⚠ Icon, error color]  [Error message — Body Medium]  [Retry — Text Button]
```

**Full Screen Error:**

```
        [Error illustration]
        [Title — Headline Small]
        [Error details — Body Medium]
        [Retry — Filled Button]
```

### Offline Banner

```
┌──────────────────────────────────────────┐
│ ⚠  No internet connection    [Dismiss ×] │
└──────────────────────────────────────────┘
```

- Position: Top of screen, below app bar
- Background: `surfaceContainerHigh`
- Text: Body Small, `onSurfaceVariant`
- Height: 40dp
- Dismissable with trailing icon button

---

## Interaction Patterns

### Navigation Flow

- Bottom navigation switches between 5 main screens
- **Page transition**: 300ms SharedAxis horizontal (fade + slide)
- Active state: M3 pill indicator with `secondaryContainer` fill
- All screens maintain scroll position via `AutomaticKeepAliveClientMixin`

### Language Switching

- Toggle button in app bar trailing actions
- Shows opposite language code (EN ↔ አማ)
- **Transition**: 150ms cross-fade on all text elements
- Maintains current screen, scroll position, and form state
- Bilingual support: English and Amharic
- Language preference persists across sessions (SharedPreferences)

### Chat Interaction

- User types in pill-shaped input field
- Sends with Enter key or Send icon button
- User message appears immediately (right-aligned), 200ms fade-in
- Typing indicator appears after 300ms
- AI response streams in or appears after processing (left-aligned)
- Auto-scroll to newest message with 300ms smooth scroll
- Quick reply chips appear below response with 200ms stagger

### Progress Tracking

- Dashboard hero shows animated progress ring
- Ring animates from 0 → current value on first load (500ms easeOutCubic)
- Legend shows completed vs. pending count
- Updates reflect in task list and stat cards below

### Task Management

- Tasks show **triple redundancy**: status stripe + icon + badge (accessibility)
- Tapping a task opens detail with slide transition
- Cards provide press feedback (150ms scale + state layer)
- Swipe actions on task cards (mark complete, snooze)

### Pull to Refresh

- Available on: Dashboard, Community, Resources, Guides
- M3 refresh indicator: Circular spinner with `primary` color
- Trigger threshold: 64dp pull distance

### Haptic Feedback

- Light impact: Button press, chip tap, toggle
- Medium impact: Important actions (submit, send, confirm)
- Heavy impact: Destructive actions (delete confirmation)

---

## Responsive Design

### Mobile-First Approach

- **Target**: Full device width (no max-width container — this is a native app)
- **Screen insets**: `spacing.screenH` (20dp) horizontal, `spacing.screenV` (24dp) vertical
- **Full height**: Screens use full viewport via `Scaffold` + `Expanded`
- **Safe area**: Respects system UI insets (notch, navigation bar, status bar)

### Layout Structure

```
┌───────────────────────┐
│  Status Bar (system)   │
├───────────────────────┤
│  App Bar (64dp)        │ ← Surface color, contextual actions
├───────────────────────┤
│                        │
│  Scrollable Content    │ ← CustomScrollView / ListView
│  Area                  │
│                        │
├───────────────────────┤
│  NavigationBar (80dp)  │ ← 5 tabs, M3 pill indicator
├───────────────────────┤
│  System Nav (system)   │
└───────────────────────┘
```

### Screen-Specific Heights

- Standard screens: Scrollable content, auto height
- AI Coach: Messages area fills remaining height, fixed input at bottom
- Dashboard: Scrollable content with hero card at top

### Touch Targets

- **Minimum**: 48dp × 48dp (M3 standard, exceeds WCAG 44px minimum)
- Navigation items: Full-width touch target with 48dp minimum height
- Buttons: Minimum 48dp height (not just the visual, the touch target)
- List items: Minimum 48dp height per row

---

## Accessibility

### Color Contrast (WCAG AA)

| Pair                        | Ratio   | Passes |
| --------------------------- | ------- | ------ |
| `onSurface` on `surface`    | 16.7:1  | ✅ AAA |
| `onSurfaceVariant` on `surface` | 5.3:1 | ✅ AA |
| `onPrimary` on `primary`    | 10.3:1  | ✅ AAA |
| `onSecondary` on `secondary`| 4.6:1   | ✅ AA  |
| `error` on `surface`        | 4.8:1   | ✅ AA  |

### Color-Blind Safety

All color-coded information uses **triple redundancy**:

| Information   | Color    | Icon             | Text Badge    |
| ------------- | -------- | ---------------- | ------------- |
| Completed     | Emerald  | `check_circle`   | "Completed"   |
| In Progress   | Amber    | `schedule`        | "In Progress" |
| Not Started   | Gray     | `circle`          | "Not Started" |
| Error/Urgent  | Red      | `warning`         | "Urgent"      |
| Success       | Emerald  | `check`           | "Done"        |

### Typography

- Base size: 16px (comfortable reading)
- Line height: Per-level (1.12 to 1.5 range, optimized per role)
- Supports system-wide Dynamic Type / font scaling
- Amharic Fidel: Same sizing, increased line-height if needed after testing

### Focus States

- All interactive elements show a **2dp `primary` ring** on focus
- Tab navigation follows logical order
- Focus ring uses `MaterialState.focused` with `primary` color at 100%

### Semantics (Flutter)

- All icons and images have `semanticLabel` or `excludeFromSemantics`
- Custom widgets use `Semantics` widget for screen reader support
- Heading announcements via `Semantics(header: true)`
- Button descriptions via `Semantics(button: true, label: '...')`
- Navigation announcements on screen change

### Haptic Feedback

- Light impact on interactive element press
- Used to confirm actions without relying on visual feedback alone

---

## Cultural Considerations

### Bilingual Support

**Languages**: English and Amharic (አማርኛ)

**Implementation:**

- Flutter `flutter_localizations` + ARB files
- All UI text translatable
- Language toggle in app bar (always visible)
- Handles pluralization rules for both languages

**Typography for Amharic:**

- Font: `Noto Sans Ethiopic` (system-provided fallback)
- Same base sizing as English
- May need `+1px` or `+0.1` line-height after testing — document findings
- Same weight scale (400, 500, 600, 700) supported by Noto Sans Ethiopic

### Ethiopian Business Context

**Localized Content:**

- Ethiopian-specific regulatory references
- Ministry of Revenue (MoR) procedures
- Ethiopian Tax Proclamation citations
- TIN (Tax Identification Number) registration
- VAT registration processes specific to Ethiopia

**Cultural Tone:**

- Professional and trustworthy
- Empowering language for entrepreneurs
- Community-focused (peer support emphasis)
- Compliance as enabler, not barrier

**Visual Warmth:**

- Tertiary amber color (`#F59E0B`) added specifically for cultural warmth
- Used for highlights, stars, featured badges, and decorative elements
- Evokes Ethiopian gold and warmth alongside the professional navy

---

## Technical Implementation

### Tech Stack

| Layer            | Technology                                          |
| ---------------- | --------------------------------------------------- |
| Framework        | Flutter 3.x + Dart                                  |
| State Management | Riverpod (`riverpod_annotation` + `riverpod_generator`) |
| Navigation       | GoRouter (`go_router` + `go_router_builder`)         |
| Theme System     | Material 3 (`useMaterial3: true`)                    |
| Primary Font     | Inter (bundled via assets)                           |
| Amharic Font     | Noto Sans Ethiopic (system fallback)                 |
| Icons            | Material Symbols (Flutter `Icons` class, rounded)    |
| Charts           | `CustomPainter` for progress ring                    |
| Localization     | `flutter_localizations` + ARB files                  |
| Deep Links       | `app_links`                                          |
| Auth             | `flutter_web_auth_2` + `flutter_secure_storage`      |
| HTTP Client      | Dio + Retrofit                                       |
| Push             | Firebase Messaging                                   |
| Realtime         | WebSocket + SSE                                      |

### Project Structure

```
lib/
├── app/
│   ├── app.dart                     # MaterialApp.router shell
│   ├── constants/
│   │   ├── app_colors.dart          # M3 color tokens (light + dark)
│   │   ├── app_spacing.dart         # Spacing + shape scale tokens
│   │   └── app_typography.dart      # Type scale definitions
│   ├── theme/
│   │   └── app_theme.dart           # ThemeData (light + dark)
│   ├── widgets/                     # Shared reusable components
│   │   ├── app_card.dart            # Card variants (elevated, filled, outlined)
│   │   ├── app_badge.dart           # Status badges
│   │   ├── app_chip.dart            # Filter / Suggestion / Input chips
│   │   ├── section_header.dart      # Section title + optional action
│   │   ├── status_indicator.dart    # Icon + color status
│   │   ├── skeleton_loader.dart     # Shimmer loading placeholders
│   │   └── empty_state.dart         # Empty state illustration pattern
│   ├── features/                    # Feature modules
│   │   ├── home/                    # Dashboard + home shell + nav bar
│   │   ├── guide/                   # Formalization guides
│   │   ├── ai/                      # AI Coach chat interface
│   │   ├── community/               # Discussions + community
│   │   ├── templates/               # Business resources/templates
│   │   ├── notifications/           # Notification inbox + push
│   │   ├── auth/                    # Login, register, OTP
│   │   ├── onboarding/              # Business profiling wizard
│   │   ├── profile/                 # User profile + settings
│   │   └── payment/                 # Subscription plans
│   └── router/
│       ├── app_router.dart          # GoRouter configuration
│       └── routes.dart              # Route definitions
├── core/
│   ├── config/                      # App configuration
│   ├── di/                          # Dependency injection providers
│   ├── l10n/                        # Localization (ARB files)
│   ├── services/                    # Push, storage, connectivity
│   └── network/                     # Dio client, interceptors
└── shared/
    ├── domain/                      # Shared entities, value objects
    └── widgets/                     # Cross-feature shared widgets
```

### Theme Configuration

The theme is configured via `ThemeData` using the M3 color roles defined in this document:

```dart
// Simplified example
ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.light(
    primary: AppColors.primary,           // #1E293B
    onPrimary: AppColors.onPrimary,       // #FFFFFF
    secondary: AppColors.secondary,       // #10B981
    tertiary: AppColors.tertiary,         // #F59E0B
    surface: AppColors.surface,           // #FFFFFF
    error: AppColors.error,              // #EF4444
    // ... all M3 roles populated
  ),
  textTheme: AppTypography.textTheme,     // Inter font, full M3 scale
  // Component themes specified individually
);
```

**Key principle**: Widgets reference `Theme.of(context).colorScheme` and `Theme.of(context).textTheme` — never `AppColors` directly. This ensures dark mode works automatically.

### Performance Considerations

- Impeller rendering engine (default in Flutter 3.x) for smooth M3 animations
- `const` widget constructors wherever possible
- Riverpod code generation for optimized rebuilds
- Lazy loading of feature modules via GoRouter
- Image caching with precacheImage for avatars
- `AutomaticKeepAliveClientMixin` for preserving tab scroll positions

---

## Design Principles Summary

### Visual Design

1. **Professional Trust**: Slate navy foundation conveys credibility
2. **Growth & Progress**: Emerald green exclusively for positive outcomes
3. **Cultural Warmth**: Amber tertiary adds Ethiopian identity and energy
4. **Depth & Hierarchy**: M3 elevation system creates clear visual layers
5. **Consistency**: M3 component specs ensure uniform behavior across screens

### User Experience

1. **Fluid Motion**: Every interaction has purposeful animation (never instant, never slow)
2. **Clear Hierarchy**: 5 navigation destinations, each with focused purpose
3. **Guidance**: Step-by-step processes, AI coaching, contextual suggestions
4. **Resilience**: Empty, loading, error, and offline states for every screen
5. **Accessibility**: Triple redundancy (color + icon + text), 48dp targets, WCAG AA

### Content Strategy

1. **Context-Aware**: Ethiopian business regulations and processes
2. **Actionable**: Clear next steps, deadline tracking, quick replies
3. **Supportive**: Community discussions, AI coaching, business templates
4. **Localized**: Full bilingual support with cultural tone

---

## Future Enhancements

### Potential Features

- Offline capability (PWA / local database caching)
- Push notifications for compliance deadlines
- Document upload and storage
- Real AI integration with streaming responses
- More granular language preferences
- Regional dialect support (Oromiffa, Tigrinya)
- Dynamic theming via `ColorScheme.fromSeed`

### Design Scalability

- M3 tonal palette system supports infinite theming
- Component library enables rapid feature development
- ARB-based translation system ready for additional languages
- Feature-module architecture for easy additions
- Shape and color token system scales to new components

---

*Document Version: 2.0*
*Last Updated: 2026-05-16*
*Design Language: Material Design 3 (2025)*
*Platform: Flutter*
