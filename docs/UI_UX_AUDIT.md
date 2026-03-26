# Ingredex frontend — detailed UI / visibility / UX audit

This document is an expanded audit of the Flutter app under `ingredex_frontend/lib`. It is intended for product and engineering: each issue includes **what users see**, **why it happens in code**, **severity**, and **how to fix and verify** it. **No implementation is included here** — treat this as a specification backlog.

---

## How to read this document

- **Severity**
  - **P0** — Breaks core flows, data misrepresented, or accessibility/legal risk.
  - **P1** — Strongly degrades experience on common devices or themes.
  - **P2** — Polish, inconsistency, or edge-case breakage.
  - **P3** — Nice-to-have improvements.

- **Verification** — Manual test ideas after a fix (no automated test mandate in this doc).

---

## Table of contents

1. [Theme, colors, and dark mode](#1-theme-colors-and-dark-mode)  
2. [Contrast, legibility, and semantic UI](#2-contrast-legibility-and-semantic-ui)  
3. [Layout, safe areas, keyboard, and scrolling](#3-layout-safe-areas-keyboard-and-scrolling)  
4. [Navigation, routing, and shell layout](#4-navigation-routing-and-shell-layout)  
5. [Actions that do nothing or duplicate behavior](#5-actions-that-do-nothing-or-duplicate-behavior)  
6. [Errors, loading, and empty states](#6-errors-loading-and-empty-states)  
7. [Riverpod, side effects, and snackbars](#7-riverpod-side-effects-and-snackbars)  
8. [History list: filters, dismiss, and data mapping](#8-history-list-filters-dismiss-and-data-mapping)  
9. [Analysis result screen: actions and content](#9-analysis-result-screen-actions-and-content)  
10. [Scan flows: barcode, OCR, manual](#10-scan-flows-barcode-ocr-manual)  
11. [Home and shared components](#11-home-and-shared-components)  
12. [Accessibility](#12-accessibility)  
13. [Global error handling](#13-global-error-handling)  
14. [Cross-cutting recommendations](#14-cross-cutting-recommendations)  
15. [Suggested implementation phases](#15-suggested-implementation-phases)

---

## 1. Theme, colors, and dark mode

### 1.1 Auth screens are visually “light-only”

| Field | Detail |
|--------|--------|
| **Where** | `features/auth/presentation/login_screen.dart`, `otp_screen.dart` |
| **What users see** | Login uses `AppColors.creamWhite` and fixed orange/black text. OTP uses `AppTextStyles` for headings/body. If the user has **system dark mode** or toggles dark mode elsewhere, auth can still look like a bright cream screen while the rest of the app follows dark surfaces — a jarring **theme boundary** at login → home. |
| **Why (technical)** | `MaterialApp` provides `darkTheme`, but these screens do not consistently use `Theme.of(context).colorScheme` / `scaffoldBackgroundColor` for backgrounds and text. `AppTextStyles` (see 1.2) do not embed theme colors. |
| **Severity** | **P1** (consistency and perceived quality). |
| **Fix (direction)** | Introduce a single pattern for auth: e.g. `Scaffold(backgroundColor: colorScheme.surface)` and text via `textTheme` / `onSurface`. Optionally keep a **brand** gradient only on a header strip, not the full screen, so dark mode can still apply. |
| **Verify** | Enable dark mode → open app cold → entire auth flow including OTP should match brightness without flashing wrong colors when navigating to `/home`. |

---

### 1.2 `AppTextStyles` are font-only; color comes from defaults or ad-hoc overrides

| Field | Detail |
|--------|--------|
| **Where** | `core/constants/app_text_styles.dart`; consumed across home, auth, etc. |
| **What users see** | On dark surfaces, any widget that uses `AppTextStyles.body1` **without** an explicit `.copyWith(color: …)` may inherit `ThemeData.textTheme` inconsistently — some screens force `AppColors.darkBlack`, others rely on theme. Visual rhythm differs screen by screen. |
| **Why (technical)** | `GoogleFonts.poppins(...)` returns a `TextStyle` without tying to `ColorScheme`. Mixing `Theme.of(context).textTheme` and `AppTextStyles` creates two parallel typography systems. |
| **Severity** | **P2** (maintainability + long-term consistency). |
| **Fix (direction)** | Either: (a) migrate screens to `Theme.of(context).textTheme` with Poppins applied in `AppTheme`, or (b) add `extension AppTextStylesContext on BuildContext` that returns styles with `color: colorScheme.onSurface`. Document one rule: **never** hardcode `AppColors.lightText` on dark routes. |
| **Verify** | Audit grep for `AppTextStyles` + `AppColors` on same line; dark mode pass on every screen. |

---

### 1.3 White cards and surfaces pinned to `Colors.white`

| Field | Detail |
|--------|--------|
| **Where** | `home/presentation/widgets/scan_options_card.dart` (`Material(color: Colors.white)`), `history/presentation/widgets/history_item_card.dart` (`color: Colors.white` on `Card`), `home/presentation/widgets/recent_scans_section.dart` (empty state container `color: Colors.white`, shimmer placeholders). |
| **What users see** | In **dark mode**, home and history show **bright white cards** on dark scaffold — high glare, breaks Material 3 “surface hierarchy,” and feels like the app “forgot” dark theme for those widgets. |
| **Why (technical)** | Explicit `Colors.white` bypasses `ThemeData.cardColor` and `ColorScheme.surface`. |
| **Severity** | **P1**. |
| **Fix (direction)** | Remove fixed white; use `Card` without `color:` or `color: Theme.of(context).colorScheme.surfaceContainer` / `cardColor`. For shimmer, use `ColorScheme`‑aware base/highlight (package docs often suggest greys — tune for dark: e.g. `surfaceContainerHighest` vs `surface`). |
| **Verify** | Toggle theme on Home and History; cards should track surface elevation, not pure white. |

---

### 1.4 OCR confidence line uses light-theme secondary color always

| Field | Detail |
|--------|--------|
| **Where** | `features/scan/presentation/ocr_scan_screen.dart` — “Confidence: …%” uses `AppColors.lightTextSecondary`. |
| **What users see** | In dark mode, secondary text may look **muted wrong** (brownish/grey on dark) or fail contrast vs background depending on device calibration. |
| **Why (technical)** | Hardcoded semantic color for “secondary” instead of `colorScheme.onSurfaceVariant`. |
| **Severity** | **P2**. |
| **Fix (direction)** | `Theme.of(context).colorScheme.onSurfaceVariant` or `textTheme.bodySmall?.color`. |
| **Verify** | Dark mode, OCR result with confidence visible — text should match other secondary labels on the same screen. |

---

### 1.5 Account profile subtitle uses fixed grey

| Field | Detail |
|--------|--------|
| **Where** | `features/account/presentation/account_screen.dart` — “Member since …” uses `Colors.grey.shade600`. |
| **What users see** | On dark cards, grey-600 can be **too dim** (WCAG contrast risk) or visually “dirty” against warm dark backgrounds. |
| **Severity** | **P2** (accessibility on dark). |
| **Fix (direction)** | `theme.textTheme.bodySmall` / `onSurfaceVariant`. |
| **Verify** | Dark mode, account card — subtitle readable at arm’s length on low brightness. |

---

### 1.6 History stats card: white chip pills on tinted card

| Field | Detail |
|--------|--------|
| **Where** | `features/history/presentation/history_screen.dart` — `_StatsCard` `Wrap` children use `color: Colors.white` for small tags. |
| **What users see** | In dark mode, parent card is tinted orange (`primaryOrange.withValues(alpha: 0.12)`); chips remain **paper white** — harsh contrast. Text inside chips uses default (often black) which may be acceptable, but the overall look is inconsistent with M3 filled tonal chips. |
| **Severity** | **P2**. |
| **Fix (direction)** | Use `surfaceContainerHighest` + `onSurface` text, or `Chip` / `FilterChip` theming. |
| **Verify** | Dark mode history — stats breakdown readable, chips don’t look like stickers on top of the card. |

---

## 2. Contrast, legibility, and semantic UI

### 2.1 Manual entry: orange bar + gradient primary button (stacked orange)

| Field | Detail |
|--------|--------|
| **Where** | `features/scan/presentation/manual_entry_screen.dart` — `bottomNavigationBar` wraps `AppButton` in `DecoratedBox` with `AppColors.primaryOrange`; `AppButton` primary variant draws **another** orange gradient (`AppColors.lightOrange` → `AppColors.primaryOrange`). |
| **What users see** | **Low separation** between button chrome and surrounding bar; label contrast relies on white text on gradient — may feel muddy or “double painted.” Disabled state uses grey gradient inside orange bar — odd hierarchy. |
| **Severity** | **P1** (primary action clarity). |
| **Fix (direction)** | One dominant surface: e.g. neutral bottom sheet bar (`surface`) + single primary CTA, or flat orange bar with **text button** style inverse (white bar on orange — pick one design language). |
| **Verify** | Light and dark; focus keyboard up — CTA still visually primary and tappable. |

---

### 2.2 Transparent `AppBar` theme-wide

| Field | Detail |
|--------|--------|
| **Where** | `core/theme/app_theme.dart` — `AppBarTheme(backgroundColor: Colors.transparent)`. |
| **What users see** | When body content scrolls under the app bar, title and icons can sit on **busy backgrounds** (images, gradients, list items) and lose legibility unless each screen adds its own `Scaffold` extend body handling. |
| **Severity** | **P2**. |
| **Fix (direction)** | Default to `surface` / `surfaceContainer` for AppBar; use transparent only on marketing screens that control backdrop. |
| **Verify** | Scroll long content under app bar on History / Account — title remains readable. |

---

### 2.3 `RiskBadge` strict matching for risk strings

| Field | Detail |
|--------|--------|
| **Where** | `shared/widgets/risk_badge.dart` — `switch (risk.toLowerCase())` with cases `'low'`, `'medium'`, `'high'`. |
| **What users see** | If API returns `"Unknown"`, `"moderate"`, `"Very High"`, or localized strings, badge falls to **grey** — looks like “missing risk” rather than “unclassified.” |
| **Why (technical)** | No synonym map; no explicit unknown style beyond grey default. |
| **Severity** | **P1** (misleading health communication). |
| **Fix (direction)** | Document API contract; normalize: `trim()`, `toLowerCase()`, map synonyms (`moderate` → medium, etc.); dedicated **Unknown** style (outline + icon). |
| **Verify** | Mock responses with edge strings; badge always meaningful. |

---

### 2.4 Emoji in section headings (analysis result)

| Field | Detail |
|--------|--------|
| **Where** | `features/scan/presentation/analysis_result_screen.dart` — strings like `'⚠️ Concerning Ingredients'`, `'✅ Beneficial Ingredients'`, `'💡 Healthier Alternatives'`. |
| **What users see** | Emojis can **render differently** per OEM font / Android version; some users find them informal; TalkBack may read emoji names aloud (“warning sign”) before the label. |
| **Severity** | **P3** (brand/polish) / **P2** if targeting strict a11y. |
| **Fix (direction)** | Replace with leading `Icon` + `Text`; keep emoji only if brand requires, add `Semantics(label: 'Concerning ingredients')` excluding emoji. |
| **Verify** | Screen reader walkthrough of analysis screen. |

---

## 3. Layout, safe areas, keyboard, and scrolling

### 3.1 OTP screen: non-scrollable body with `Spacer`

| Field | Detail |
|--------|--------|
| **Where** | `features/auth/presentation/otp_screen.dart` — `body: Padding` → `Column` → … → `Spacer()` → verify button. |
| **What users see** | On **small phones** or when **keyboard** is up, the column can **overflow** (yellow/black stripes) or push the verify button off-screen. Email + 6 fields + timer + CTA is tall. |
| **Severity** | **P1**. |
| **Fix (direction)** | `SingleChildScrollView` + `ConstrainedBox` with `minHeight` from `MediaQuery`; or replace `Spacer` with fixed `SizedBox` spacing when `viewInsets.bottom > 0`. Ensure `resizeToAvoidBottomInset: true` (default). |
| **Verify** | Smallest emulator + open keyboard on OTP field; no overflow; Verify reachable. |

---

### 3.2 OCR screen: vertical `Column` without scroll

| Field | Detail |
|--------|--------|
| **Where** | `features/scan/presentation/ocr_scan_screen.dart` — image `height: 220` + buttons + up to 5 lines of preview (ellipsis) but column can still grow with large text scale / font scaling. |
| **What users see** | **Overflow** possible with **text scale factor > 1** or future UI additions (full OCR text). |
| **Severity** | **P2** (accessibility: dynamic type). |
| **Fix (direction)** | `SingleChildScrollView` or `ListView` with keyboard-safe padding. |
| **Verify** | System font size largest; OCR flow after image selected. |

---

### 3.3 Login: bottom sheet form vs keyboard

| Field | Detail |
|--------|--------|
| **Where** | `features/auth/presentation/login_screen.dart` — bottom `Align` + white rounded panel with email field. |
| **What users see** | Keyboard may **cover** the primary button or obscure the field on short aspect ratios. |
| **Severity** | **P2**. |
| **Fix (direction)** | Wrap stack content in scroll + pad `viewInsets.bottom`; or use `Scaffold` `resizeToAvoidBottomInset` with a scrollable bottom sheet. |
| **Verify** | Open keyboard on login; Send OTP visible without manual dismiss. |

---

## 4. Navigation, routing, and shell layout

### 4.1 “Scan Again” semantics vs `go('/home')`

| Field | Detail |
|--------|--------|
| **Where** | `features/scan/presentation/analysis_result_screen.dart` — `OutlinedButton` “Scan Again” → `context.go('/home')`. |
| **What users see** | Label suggests **repeat last scan type** (barcode vs OCR); behavior is **always home**. Users may not understand why they land on home tab, not scan hub. |
| **Severity** | **P2** (copy/IA). |
| **Fix (direction)** | Rename to **“Back to home”** or navigate to a **scan chooser** modal/route; optional query `?focus=scan`. |
| **Verify** | User test: after analysis, button matches expectation in 1 tap. |

---

### 4.2 Inconsistent bottom padding for shell FAB

| Field | Detail |
|--------|--------|
| **Where** | `app_router.dart` shell FAB; `analysis_result_screen.dart` `ListView` padding `bottom: 110`; `manual_entry_screen.dart` `padding bottom: 110`. Other screens may use different values. |
| **What users see** | Some screens **extra scroll space**; others might have list items **too close** to nav bar on specific devices. |
| **Severity** | **P2**. |
| **Fix (direction)** | Constant `kShellContentBottomInset` derived from `MediaQuery` + FAB size + safe area; document when full-screen routes (scanner) should ignore it. |
| **Verify** | Physical device with gesture nav bar — last list item not hidden. |

---

## 5. Actions that do nothing or duplicate behavior

### 5.1 Home notifications icon (no-op)

| Field | Detail |
|--------|--------|
| **Where** | `features/home/presentation/home_screen.dart` — `IconButton(..., onPressed: () {})`. |
| **What users see** | Tappable bell with **no feedback** — feels broken. |
| **Severity** | **P2**. |
| **Fix (direction)** | Remove icon until feature exists, or show **“Coming soon”** snackbar / bottom sheet once. |
| **Verify** | Tap bell — intentional feedback or hidden. |

---

### 5.2 Scan detail share icon (no-op)

| Field | Detail |
|--------|--------|
| **Where** | `features/history/presentation/scan_detail_screen.dart` — share `IconButton` `onPressed: () {}`. |
| **Severity** | **P2**. |
| **Fix (direction)** | `share_plus` / platform share with text summary; or remove. |
| **Verify** | Share sheet opens with meaningful content. |

---

### 5.3 Account: About / Privacy (no-op)

| Field | Detail |
|--------|--------|
| **Where** | `features/account/presentation/account_screen.dart` — `ListTile` `onTap: () {}`. |
| **Severity** | **P2** (trust/legal expectation on Privacy). |
| **Fix (direction)** | Open URLs in-app browser or static routes with copy; minimum: show dialog “Content coming soon.” |
| **Verify** | Tap — never silent. |

---

### 5.4 Duplicate theme control (Home vs Account)

| Field | Detail |
|--------|--------|
| **Where** | `home_screen.dart` toggles `themeProvider` + `persistThemePreference`; `account_screen.dart` uses `accountProvider.setTheme`. |
| **What users see** | Two places to change theme — can **diverge** if implementations differ (state not synced, persistence only from one path). |
| **Severity** | **P1** if `accountProvider` and `themeProvider` can desync; **P2** if they always mirror. |
| **Fix (direction)** | Single **ThemeController** / notifier; Account and Home both call it; persistence in one place. |
| **Verify** | Toggle in home → account switch reflects; toggle in account → home icon reflects; restart app — theme persists once. |

---

## 6. Errors, loading, and empty states

### 6.1 Raw exception strings in UI

| Field | Detail |
|--------|--------|
| **Where** | `history_screen.dart` `error: (e, _) => Center(child: Text('Error: $e'))`; `recent_scans_section.dart` similar for failed recent loads. |
| **What users see** | Technical messages (`DioException`, stack fragments) confuse non-technical users; may leak paths or hostnames. |
| **Severity** | **P1** (privacy + professionalism). |
| **Fix (direction)** | Map categories: network / server / auth; log `e` internally; show **short** user string + retry. |
| **Verify** | Airplane mode — friendly copy, no raw exception. |

---

### 6.2 Stats card swallows async errors

| Field | Detail |
|--------|--------|
| **Where** | `history_screen.dart` `_StatsCard` — `error: (_, __) => const SizedBox.shrink()`. |
| **What users see** | History list might load while **stats silently disappear** — user doesn’t know stats failed vs zero scans. |
| **Severity** | **P1**. |
| **Fix (direction)** | Small inline error: “Couldn’t load stats” + retry icon; or show stats row skeleton with error state. |
| **Verify** | Force stats API failure — UI shows failure, not empty air. |

---

## 7. Riverpod, side effects, and snackbars

### 7.1 OTP screen: `ref.listen` registered every `build`

| Field | Detail |
|--------|--------|
| **Where** | `features/auth/presentation/otp_screen.dart` — `ref.listen<AsyncValue<AuthState>>(authNotifierProvider, ...)` inside `build`. |
| **What users see** | Potential **duplicate snackbars** on error or multiple navigations if framework disposes/rebuilds aggressively; harder to reason about. |
| **Severity** | **P1** (subtle bug class). |
| **Fix (direction)** | `listenManual` in `initState` + close in `dispose`, or parent route listens once. |
| **Verify** | Wrong OTP 3 times — single snackbar per attempt (or debounced). |

---

### 7.2 Two snackbar systems

| Field | Detail |
|--------|--------|
| **Where** | Feature screens now call `SnackBarService.show` (same global messenger as network layer). |
| **What users saw** | Different **duration**, **behavior**, **theme** when some code used `ScaffoldMessenger` directly. |
| **Severity** | **P2** (mitigated). |
| **Fix (direction)** | `SnackBarThemeData` in `AppTheme` + `SnackBarService.show` for user-facing messages. |
| **Verify** | Trigger Dio error and local error — same visual style. |

---

## 8. History list: filters, dismiss, and data mapping

### 8.1 `Dismissible` never completes dismissal

| Field | Detail |
|--------|--------|
| **Where** | `history_screen.dart` — `confirmDismiss` awaits dialog; returns `false` always (delete happens in dialog path but row isn’t removed via dismiss). |
| **What users see** | User **swipes** expecting row to go away; row **stays** unless they use detail delete. Swipe UI is misleading. |
| **Severity** | **P2** (gesture vs outcome). |
| **Fix (direction)** | Return `true` after successful delete and remove from list; or remove `Dismissible` and use overflow menu only. |
| **Verify** | Swipe → confirm → row leaves list. |

---

### 8.2 “Manual” filter uses `'analysis'` key

| Field | Detail |
|--------|--------|
| **Where** | `history_screen.dart` `_applyFilter` — `key = _filter == 'Manual' ? 'analysis' : _filter.toLowerCase()`. |
| **What users see** | If backend sends `scanType: "manual"`, choosing **Manual** shows **no items** while “All” shows them — looks like data loss. |
| **Severity** | **P1** if API uses `manual`. |
| **Fix (direction)** | Align with OpenAPI/backend enum; unit test mapping; display label vs filter value separated. |
| **Verify** | Manual scans present when filter Manual selected. |

---

## 9. Analysis result screen: actions and content

### 9.1 “Save to History” snackbar contradicts button

| Field | Detail |
|--------|--------|
| **Where** | `features/scan/presentation/analysis_result_screen.dart` — when `canSave` is true, `ElevatedButton` “Save to History” shows snackbar: *Result is already handled by backend caching/history flow.* |
| **What users see** | Button implies **user-initiated save**; message says **no need / already done** — cognitive dissonance. |
| **Severity** | **P1** (trust). |
| **Fix (direction)** | If save isn’t needed: hide button or show **“Saved”** state when `scanId` exists; if needed: call API and show success/failure. |
| **Verify** | User never taps “save” and gets a message that sounds like an error or contradiction. |

---

### 9.2 Hero tag derived from product name string

| Field | Detail |
|--------|--------|
| **Where** | `analysis_result_screen.dart` — `heroTag = 'health-score-${productName.toLowerCase()}'`. |
| **What users see** | Two analyses of same product name in sequence could throw **duplicate Hero tag** assert in debug or odd transitions. |
| **Severity** | **P2** (edge case). |
| **Fix (direction)** | Include unique id: `scanId` or `Object.hash` / uuid from navigation extra. |
| **Verify** | Open two results with same name back-to-back — no Hero assert. |

---

## 10. Scan flows: barcode, OCR, manual

### 10.1 Barcode: permission error flag set during `errorBuilder` build

| Field | Detail |
|--------|--------|
| **Where** | `features/scan/presentation/barcode_scan_screen.dart` — `errorBuilder` assigns `_hasPermissionError = true`. |
| **What users see** | Possible **flicker** or inconsistent overlay (scanner vs error UI) if build runs multiple times. |
| **Severity** | **P2** (correctness / lint “don’t set state during build”). |
| **Fix (direction)** | Detect permission in controller callback / `WidgetsBinding.instance.addPostFrameCallback` + `setState`, or use package’s recommended pattern. |
| **Verify** | Deny camera → stable error UI, no rebuild loops. |

---

### 10.2 Barcode: raw exception in snackbar

| Field | Detail |
|--------|--------|
| **Where** | `barcode_scan_screen.dart` — `SnackBar(content: Text(e.toString()))`. |
| **Severity** | **P2** (same as 6.1). |
| **Fix (direction)** | Friendly mapping for scan/analyze failures. |

---

### 10.3 OCR: `AppButton` enabled when no image

| Field | Detail |
|--------|--------|
| **Where** | `ocr_scan_screen.dart` — “Scan Ingredients” always shown; `_scanIngredients` returns early if `_image == null` but button may still look active (depends on `AppButton` — `onPressed` is non-null). |
| **What users see** | Tap without image — **nothing happens** unless you add feedback (currently `_scanIngredients` returns silently). |
| **Severity** | **P2**. |
| **Fix (direction)** | Disable button until `_image != null` or show snackbar “Select a photo first.” |
| **Verify** | Tap analyze with no image — clear feedback. |

---

## 11. Home and shared components

### 11.1 Recent scans shimmer: hardcoded greys and white

| Field | Detail |
|--------|--------|
| **Where** | `recent_scans_section.dart` — `Shimmer.fromColors(baseColor: grey.shade300, highlight: grey.shade100)` and white placeholder boxes. |
| **What users see** | Dark mode: shimmer looks **light-theme only**; empty state box is white. |
| **Severity** | **P2**. |
| **Fix (direction)** | Theme-aware shimmer colors; empty state uses `surfaceContainer`. |

---

### 11.2 Home app bar title with emoji

| Field | Detail |
|--------|--------|
| **Where** | `home_screen.dart` — `'Hi, $firstName! 👋'`. |
| **Severity** | **P3** (same emoji considerations as 2.4). |

---

### 11.3 `AppTextField` borders always “light” divider

| Field | Detail |
|--------|--------|
| **Where** | `shared/widgets/app_text_field.dart` — `AppColors.lightDivider` for borders. |
| **What users see** | Dark forms may need **darkDivider** — borders can be too bright or too low contrast on dark surfaces. |
| **Severity** | **P2**. |
| **Fix (direction)** | `InputDecorationTheme` in `AppTheme` for light/dark; widget defers to theme when possible. |

---

### 11.4 `AppButton` loading indicator colors

| Field | Detail |
|--------|--------|
| **Where** | `shared/widgets/app_button.dart` — primary loading uses white `CircularProgressIndicator`; outlined uses default (theme-dependent). |
| **What users see** | Minor inconsistency on custom backgrounds (e.g. manual entry bar). |
| **Severity** | **P3**. |
| **Fix (direction)** | Pass `color` from context or fixed brand contrast per variant. |

---

## 12. Accessibility

### 12.1 OTP boxes: six separate fields

| Field | Detail |
|--------|--------|
| **Where** | `otp_screen.dart`. |
| **What users see** | TalkBack may announce six separate boxes; paste behavior is custom — ensure **one logical code field** for assistive tech where possible. |
| **Severity** | **P2**. |
| **Fix (direction)** | `Semantics(label: 'One time passcode')` wrapping row; or single hidden field + visual boxes (advanced pattern). |
| **Verify** | TalkBack: enter OTP end-to-end. |

---

### 12.2 Touch target size

| Field | Detail |
|--------|--------|
| **Where** | History item trailing score circle `38x38` — below Material **48dp** touch guideline for primary actions (here secondary). |
| **Severity** | **P3** unless entire card is not tappable (card is tappable — OK). |
| **Fix (direction)** | Ensure `InkWell` on card has sufficient height; icon-only buttons meet 48 min. |

---

## 13. Global error handling

### 13.1 `ErrorWidget.builder` replaces all build errors with generic UI

| Field | Detail |
|--------|--------|
| **Where** | `main.dart`. |
| **What users see** | Safer for production users; **developers lose** inline error text during QA. |
| **Severity** | **P2** (DX). |
| **Fix (direction)** | `kDebugMode ? ErrorWidget.builder = ... detailed : generic` or log to console in all modes. |
| **Verify** | Introduce intentional build error in debug — see details. |

---

## 14. Cross-cutting recommendations

1. **Design tokens** — Single source: `ColorScheme` + `TextTheme`; `AppColors` only for brand accents not in seed generation.  
2. **Screen template** — `Scaffold` + `SafeArea` policy + scroll policy + keyboard policy documented in README for contributors.  
3. **User-visible errors** — One `AppErrorMapper` from `DioException` and generic `Exception`.  
4. **Feature flags** — Hide icons for notifications/share until implemented (reduces “broken app” perception).  
5. **Visual regression** — Optional golden tests for Home/History light+dark after token migration.

---

## 15. Suggested implementation phases

| Phase | Scope | Outcome |
|-------|--------|---------|
| **A** | Dark mode surfaces (cards, recent, history, auth pass) | No white cards in dark theme. |
| **B** | Layout safety (OTP scroll, OCR scroll, login keyboard) | No overflows on small / large font. |
| **C** | Dead actions + theme single source | No silent taps; one theme pipeline. |
| **D** | Errors + stats + analysis save copy | Trustworthy messaging. |
| **E** | History dismiss + filter mapping + risk badge | Correct gestures and data. |
| **F** | A11y + polish | WCAG-oriented contrast, semantics. |

---

## P0 remediation (implemented)

The audit defines **P0** but did not tag individual rows. The following **critical** items were implemented as a first batch (trust, safety messaging, core auth flow):

| Area | Change |
|------|--------|
| **Risk display** | `RiskBadge` normalizes API strings (synonyms, unknown), uses theme-aware styling for unknown. |
| **User-facing errors** | `core/utils/user_facing_error.dart` maps `DioException` (and fallback) to short messages; used on History list, Recent scans, Scan detail. |
| **Stats load failure** | `_StatsCard` shows error + **Retry** (invalidates `historyStatsProvider`) instead of empty `SizedBox.shrink()`. |
| **History list load failure** | Friendly message + **Retry** (invalidates `historyProvider`). |
| **Analysis result** | Removed misleading **Save to History** action; single **Back to home**; Hero tag includes `scanId` / score to reduce collisions. |
| **OTP screen** | `listenManual` in `initState` (no duplicate listeners); scrollable body + keyboard inset padding. |
| **Debug noise** | Removed temporary `print` / `debugPrint` from auth + router. |

## Phase A / B remediation (implemented)

| Area | Change |
|------|--------|
| **AppBar** | `AppTheme` light/dark: solid `surface` background + `foregroundColor` / `surfaceTint` (no transparent bar). |
| **Cards / home / history** | `ScanOptionsCard`, `HistoryItemCard`, recent scans empty + shimmer, history stats chips use `ColorScheme` surfaces instead of `Colors.white`. |
| **Login** | Scaffold + bottom sheet use `surface` / `surfaceContainerHighest`; scroll padding for keyboard; removed fixed cream/white-only panels. |
| **OTP** | Themed text and outline borders; scaffold `surface` background. |
| **OCR** | `SingleChildScrollView` + keyboard padding; confidence uses `onSurfaceVariant`; **Scan Ingredients** disabled until an image is chosen; errors use `userFacingError`. |
| **Manual entry** | Bottom CTA on `surfaceContainerHighest` (no orange-on-orange stack); errors use `userFacingError`. |
| **Barcode** | Scan/analyze errors use `userFacingError`. |
| **AppTextField** | Enabled/focused borders from `colorScheme.outline` / `primary`. |
| **Account** | “Member since” uses `onSurfaceVariant`. |
| **Home app bar** | Title text color follows `onSurface`. |

**Still open (later phases):** optional global `InputDecorationTheme`, OCR long-text overflow beyond 8 lines, etc.

## Phase C remediation (implemented)

| Area | Change |
|------|--------|
| **Theme entry point** | Home app bar theme toggle calls `AccountController.setTheme` (`account_provider.dart`) — same path as Account **Dark Mode** switch (updates `themeProvider` + `persistThemePreference`). |
| **Notifications** | Bell shows a SnackBar: notifications not available yet (no dead tap). |
| **Share (scan detail)** | `share_plus` + `shareTextFromHistoryDetail` (`core/utils/share_scan_text.dart`) builds text from loaded detail; Share sheet opens when data is ready. |
| **About** | `showAboutDialog` with app name, version, short description. |
| **Privacy** | `AlertDialog` with scrollable summary text and Close. |

## Phase E remediation (implemented)

| Area | Change |
|------|--------|
| **Dismissible behavior** | In `history_screen.dart`, `confirmDismiss` now returns the delete result. Swipe + confirm removes the card immediately when delete succeeds. |
| **Delete failure UX** | If deletion fails, a friendly error SnackBar is shown using `userFacingError`, and the row stays in place. |
| **Manual filter mapping** | Manual filter now accepts both `analysis` and `manual` scan types to avoid false-empty results across backend enum variants. |
| **Filter typing** | `_applyFilter` now uses `List<HistoryItem>` (typed) for safer filtering and readability. |

---

## Remaining work (pending)

After implementing P0 + Phase A/B/C/E and the first pass of this backlog:

### Completed in this pass

- **Global input theme consolidation** — Added `InputDecorationTheme` to light/dark in `AppTheme`; simplified `AppTextField`; removed per-screen input override in login.
- **OCR long-text handling** — Added expand/collapse (“Show more / Show less”) for long OCR preview text.
- **Barcode permission builder side-effect** — Removed direct state mutation in `errorBuilder`; permission error state is now set via post-frame callback helper.

### Still pending (device verification)

- **TalkBack / VoiceOver** — Manually verify OTP field announcements and focus order after the semantics pass below.

### Completed in follow-up pass

- **Snackbar system unification** — Call sites use `SnackBarService.show` so `SnackBarThemeData` from `AppTheme` applies consistently; `SnackBarService` wraps `SnackBar(content: Text(...))` only.
- **OTP semantics** — `Semantics` on the OTP `Row` with label “One-time passcode” and a short hint.
- **Analysis result section headers** — Emoji titles replaced with `Icon` + `Text` rows (concerning / beneficial / alternatives).
- **`AppButton` loading state** — Outlined and text variants use `ColorScheme.primary` for the indeterminate `CircularProgressIndicator`; primary (gradient) keeps white for contrast.

---

*This audit is based on static review of the codebase. Confirm backend field names (`scanType`, risk levels) against your API contract before implementing filter and badge fixes.*
