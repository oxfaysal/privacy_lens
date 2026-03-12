## 1.0.3

* **Added:** Full support for **Swift Package Manager (SPM)** on iOS and macOS platforms.
* **Improved:** Added `Package.swift` files for modern dependency management.
* **Updated:** Configured `podspec` to meet current Flutter plugin standards.
* **Fixed:** Resolved `Platform support` warnings on `pub.dev` to ensure 20/20 platform score.
* **General:** Internal project structure optimizations for better maintainability.

## 1.0.2

* **Added:** `overlayColor` property to customize the tint color over the blurred content.
* **Added:** `privacyChild` property to display custom widgets (e.g., logos, icons, or text) when blurred.
* **Added:** `enableInDebug` flag to optionally disable the blur effect during development.
* **Added:** Smooth blur transitions using `TweenAnimationBuilder` for a better user experience.
* **Added:** `animationDuration` property to control the speed of the blur fade-in/out effect.
* **Improved:** Updated the example project with an interactive UI to showcase all new features.

## 1.0.1

* **Fixed:** Resolved `unused_field` warning by removing unnecessary `MethodChannel` reference.
* **Fixed:** Resolved `deprecated_member_use` warning by updating `.withOpacity()` to `.withValues(alpha:)`.
* **Fixed:** Removed `unnecessary_library_name` to improve compliance with Flutter analysis standards.
* **Added:** Implemented `didUpdateWidget` in `_PrivacyLensState` for reactive UI updates when `isProtected` property changes.
* **Improved:** Updated export structure in `lib/privacy_lens.dart` for cleaner API access.
* **Updated:** Configured `platforms` support in `pubspec.yaml` for better `pub.dev` compatibility.

## 1.0.0

* Initial release of the `privacy_lens` package.
* Added `PrivacyLens` widget for selective UI masking.
* Implemented `blurStrength` and `isProtected` properties for customizable security.
* Added support for Flutter-based applications.