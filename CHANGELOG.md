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