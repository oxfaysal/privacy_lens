# Privacy Lens

**Privacy Lens** is a lightweight, zero-dependency Flutter widget that allows you to mask sensitive information (such as credit card numbers, passwords, or personal data) from unauthorized screen captures and screen recordings.

---

## 🚀 Key Features

* **Selective Masking:** Protect only the sensitive parts of your UI, rather than masking the entire screen.
* **Customizable Blur:** Easily adjust the blur intensity to match your app's design requirements.
* **Dynamic Protection:** Toggle masking on/off programmatically based on your app's security logic or user settings.
* **Zero-Dependency:** Extremely lightweight and easy to integrate without bloating your project.

---

## Preview
![Privacy Lens Demo](https://raw.githubusercontent.com/oxfaysal/privacy_lens/main/assets/masonry_demo.jpg)

## 📥 Installation

Add `privacy_lens` to your `pubspec.yaml` file:

```yaml
dependencies:
  privacy_lens: ^1.0.0
```

Then, run the following command in your terminal:

```
flutter pub get
```

## ⚡ Usage

Simply wrap any sensitive content with the `PrivacyLens` widget:

```dart
import 'package:privacy_lens/privacy_lens.dart';

PrivacyLens(
  // true Always blur for demonstration OR false only blur when app is backgrounded
  isProtected: true, // defult value false 
  blurStrength: 10.0, // Adjust intensity of the blur
  child: Text("Sensitive Data: 1234-5678-9012"),
)
```


### Advanced Scenario (Conditional Security)

You can integrate this with your own security logic (e.g., detecting if the user is in a "sensitive" mode):


```dart
PrivacyLens(
  isProtected: isScreenLocked, // Your custom state variable
  blurStrength: 15.0,
  child: CreditCardWidget(cardNumber: "5500-XXXX-XXXX-1234"),
)
```

## 🛠 Why Privacy Lens?

* Privacy First: Build trust with your users by ensuring their sensitive data remains invisible during accidental screen captures or malicious screen recordings.

* Developer Experience: Clean, simple API that integrates seamlessly into your existing widget tree.

