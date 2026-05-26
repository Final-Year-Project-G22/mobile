# Logo + Splash Screen — Implementation Plan

## Overview

Brand the app with the **Adisu Serategna** identity: Ethiopian-styled "A" logo, platform manifest labels, native splash handoff, and a branded Flutter splash page.

**Status**: [Not started]  
**Target**: App icon, native splash, Flutter splash page all fully branded  
**Architecture**: `flutter_svg` → SVG asset → `SplashPage` with animation → GoRouter auth redirect

---

## Phase Breakdown

Each phase is standalone, reviewable, and can be committed independently. Dependencies flow top-down.

---

### Phase 1: SVG Polish & Asset Setup

**Dependency**: None  
**Files changed**:
- `logo.svg` (modified in place)
- `pubspec.yaml` (add `flutter_svg` dependency, register asset)
- `assets/images/logo.svg` (moved from root)

**What to do**:
1. Restructure the SVG:
   - Crop `viewBox` tightly around the "A" letterform (~400×465 area), removing ~180px of top/left/right/bottom padding
   - Preserve `#293751` fill color
   - Preserve `.cls-1` transparent cutout paths (negative-space details)
   - Set `viewBox` with ~15% padding around artwork
   - Remove explicit `width`/`height` for responsive scaling
   - Simplify XML structure (merge defs, clean styles)
2. Move `logo.svg` → `assets/images/logo.svg`
3. Add `flutter_svg` to dependencies (already `flutter pub add flutter_svg`)
4. Register `assets/images/` in `pubspec.yaml` `flutter > assets`
5. Create directory `assets/images/` if needed

**Verify**: `flutter pub get` succeeds; SVG renders correctly

---

### Phase 2: Platform Manifest Updates

**Dependency**: None  
**Files changed**:
- `android/app/src/main/AndroidManifest.xml` (line 5: `android:label`)
- `ios/Runner/Info.plist` (lines 10, 31: `CFBundleDisplayName`, `CFBundleName`)
- `pubspec.yaml` (line 2: description)
- `lib/core/config/app_constants.dart` (update `appName` if needed)

**What to do**:
| File | Current | New |
|------|---------|-----|
| AndroidManifest.xml `android:label` | `"mobile"` | `"Adisu Serategna"` |
| Info.plist `CFBundleDisplayName` | `"Mobile"` | `"Adisu Serategna"` |
| Info.plist `CFBundleName` | `"mobile"` | `"Adisu Serategna"` |
| pubspec.yaml `description` | `"A new Flutter project."` | `"Business formalization platform for Ethiopian entrepreneurs"` |
| AppConstants `appName` | `"Adisu"` | `"Adisu Serategna"` |

**Verify**: `flutter build apk --debug` / `flutter build ios --debug --no-codesign` succeeds

---

### Phase 3: Native Splash Background Color

**Dependency**: None  
**Files changed**:
- `android/app/src/main/res/drawable/launch_background.xml`
- `android/app/src/main/res/drawable-v21/launch_background.xml`
- `android/app/src/main/res/values/styles.xml`
- `android/app/src/main/res/values-night/styles.xml`
- `ios/Runner/Base.lproj/LaunchScreen.storyboard`
- `ios/Runner/Assets.xcassets/LaunchImage.imageset/Contents.json` (if assets need creation)

**What to do**:
1. **Android**: Set `launch_background.xml` background to `#F8FAFC` (replace `@android:color/white`)
   - Both `drawable/` and `drawable-v21/` versions
   - Verify `styles.xml` uses `LaunchTheme` (not `NormalTheme` which has a different background)
2. **iOS**: Set LaunchScreen storyboard background color to `#F8FAFC` (RGB: 248, 250, 252)
   - Update UIView background color in the storyboard XML
   - Remove or update the `LaunchImage` image view reference (no image asset available)

**Verify**: App launches on simulator/emulator without white flash

---

### Phase 4: Flutter Splash Page

**Dependency**: Phase 1 (SVG asset must exist)  
**Files changed**:
- `lib/app/features/splash/presentation/pages/splash_page.dart`
- `pubspec.yaml` (add `google_fonts` if Playfair Display needs explicit declaration; already a dep)

**What to do**:
1. Rewrite `SplashPage`:
   ```dart
   // Pseudocode structure
   Scaffold(
     backgroundColor: AppColors.splashBackground,  // #F8FAFC
     body: Center(
       child: AnimatedOpacity(
         // Fade-in on init
         child: Column(
           mainAxisSize: MainAxisSize.min,
           children: [
             SvgPicture.asset('assets/images/logo.svg', width: 160, height: ...),
             SizedBox(height: 24),
             Text('Adisu Serategna', style: GoogleFonts.playfairDisplay(...)),
             SizedBox(height: 48),
             AdisuProgressIndicator.large(),
           ],
         ),
       ),
     ),
   )
   ```
2. Add fade-in animation using `AnimationController` + `FadeTransition`:
   - Logo fades in first: 0→1 over 600ms, delay 100ms
   - Wordmark + spinner fade in: 0→1 over 400ms, after logo completes
3. Splash retains zero navigation logic — GoRouter `redirect` handler handles auth routing

**Verify**: App shows branded splash before auth redirect; animation plays smoothly

---

### Phase 5: App Icon Generation

**Dependency**: Phase 1 (clean SVG needed as source)  
**Files changed**:
- `android/app/src/main/res/mipmap-*/ic_launcher.png` (all densities)
- `android/app/src/main/res/mipmap-*/ic_launcher_round.png` (all densities)
- `ios/Runner/Assets.xcassets/AppIcon.appiconset/Contents.json` + PNGs
- `ios/Runner/Assets.xcassets/AppIcon.appiconset/*.png`

**What to do**:
1. Generate square PNGs from the cropped SVG on `#F8FAFC` background:
   | Density | Size | Android Path |
   |---------|------|-------------|
   | mdpi | 48×48 | `mipmap-mdpi/ic_launcher.png` |
   | hdpi | 72×72 | `mipmap-hdpi/ic_launcher.png` |
   | xhdpi | 96×96 | `mipmap-xhdpi/ic_launcher.png` |
   | xxhdpi | 144×144 | `mipmap-xxhdpi/ic_launcher.png` |
   | xxxhdpi | 192×192 | `mipmap-xxxhdpi/ic_launcher.png` |
   - Same sizes for `ic_launcher_round.png`
   - iOS: 20, 29, 40, 60, 76, 83.5 (×1, ×2, ×3) → update `Contents.json`
2. Use `flutter_launcher_icons` or manual `rsvg-convert`/Inkscape export

**Verify**: App icon appears correctly on home screen (Android + iOS simulator)
