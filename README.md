# Privacy Lens

A lightweight and efficient Flutter widget designed to mask sensitive data, protecting your application's information from unauthorized screen captures and screen recordings.

## Features

* **Selective Masking:** Protect specific sensitive widgets (e.g., credit card numbers, passwords, personal data) without affecting the entire screen.
* **Customizable Blur:** Easily control the intensity of the blur effect.
* **Zero-Dependency:** Lightweight and easy to integrate into any project.


## Usage

Simply wrap any sensitive content with the `PrivacyLens` widget:

```dart
PrivacyLens(
  isProtected: true, // Toggle visibility based on your app's security logic
  blurStrength: 8.0,
  child: Text("Sensitive Card Info: 1234-5678-9012"),
)
```
