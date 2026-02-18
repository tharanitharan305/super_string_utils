# super_string_utils

A production‑grade Flutter utility engine delivering 80+ powerful String extensions and Fluent UI builders for modern Dart & Flutter development.

---

## 🚀 Why super_string_utils?

Dart’s native `String` class is powerful — but modern applications demand far more.

Validation. Hashing. Parsing. Extraction. Layout generation. UI building.

Developers repeatedly rewrite regex patterns, widget boilerplate, and transformation helpers.

**super_string_utils eliminates that repetition.**

It bridges the gap between raw strings and production-ready Flutter UI using a clean, fluent, and chainable architecture.

Built for serious Flutter developers who value speed, clarity, and scalability.

---

## ✨ Core Features

### 🔡 80+ Extensions

Comprehensive toolkit covering validation, transformation, extraction, security, analysis, and processing.

### 🎨 Fluent UI Builders

Build `Text`, `SnackBar`, `Row`, and `Column` widgets directly from strings using a clean Builder pattern.

### 📐 Advanced Layout Engine

Generate structured layouts from `List<String>` with per-index control:

* `expandAt()`
* `containerAt()`
* `paddingAt()`
* `flexibleAt()`
* `align()`

### 🔐 Security Suite

Built-in hashing and encoding utilities:

* MD5
* SHA-256
* Base64
* Email masking
* String obfuscation

### 🌐 Web & Network Utilities

IPv4 validation, JSON detection, URL encoding/decoding, numeric parsing helpers.

### 🧠 Text Analysis Tools

Reading time estimation, word count, fuzzy matching (Levenshtein), word frequency.

### 🛡 Production Ready

Fully null-safe, optimized, dependency-minimal, and designed for cross-platform Flutter apps.

---

## 📦 Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  super_string_utils: ^1.1.0
```

Then run:

```bash
flutter pub get
```

---

## 🧠 Basic Usage

Import the package:

```dart
import 'package:super_string_utils/super_string_utils.dart';
```

---

## 🔍 Validation Examples

```dart
"user@domain.com".isEmail;       // true
"192.168.1.1".isIpv4;            // true
"StrongP@ss1".isStrongPassword;  // true
"Hello 😀".containsEmoji;        // true
```

---

## ✨ Transformation Examples

```dart
"hello world".toTitleCase;      // "Hello World"
"Flutter & Dart".slugify;       // "flutter-dart"
"123.45".toDoubleOrNull;        // 123.45
"example".reverse;              // "elpmaxe"
```

---

## 🔐 Security & Encoding

```dart
"password".md5Hash;             // "5f4dcc3b..."
"data".toBase64;                // "ZGF0YQ=="
"secret@mail.com".maskEmail;    // "s*****@mail.com"
```

---

## 🔎 Extraction & Processing

```dart
"Visit https://pub.dev".extractUrls;      // ["https://pub.dev"]
"Order #1234 cost $50".extractNumbers;    // [1234, 50]
"Some text".wordCount;                    // 2
```

---

# 🎨 Fluent UI Builders

Stop writing repetitive Flutter boilerplate.

### 📝 Text Builder

```dart
"Super String".toTextBuilder
    .size(20)
    .weight(FontWeight.w600)
    .color(Colors.indigo)
    .padded(EdgeInsets.all(16))
    .insideContainer(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(8),
    )
    .center()
    .build();
```

---

### 🔔 SnackBar Builder

```dart
"Action Success".toSnackbarBuilder
    .floating()
    .color(Colors.green)
    .withCloseIcon()
    .build();
```

---

# 📐 Advanced List Layout Engine

Generate dynamic layouts from `List<String>` with per-index customization.

```dart
["Header", "Content Body", "Footer"]
    .toTextColumn()
    .spacing(12)
    .crossAxis(CrossAxisAlignment.start)
    .style(TextStyle(fontSize: 14))
    .containerAt(0, color: Colors.blue)
    .expandAt(1)
    .align(TextAlign.right)
    .build();
```

This enables flexible UI construction for menus, dashboards, and dynamic layouts.

---

## 📊 Feature Categories

| Category   | Includes Methods Like                          |
| ---------- | ---------------------------------------------- |
| Boolean    | isBlank, isNumeric, isAlpha, isUrl             |
| Transform  | toTitleCase, slugify, reverse                  |
| Security   | md5Hash, sha256Hash, maskEmail                 |
| Web        | urlEncode, urlDecode, isIpv4                   |
| Numeric    | toDoubleOrNull, toIntOrNull                    |
| Analysis   | wordCount, readingTime, fuzzyMatch             |
| Processing | indent, unindent, removeWhitespace             |
| Fluent UI  | toTextBuilder, toSnackbarBuilder, toTextColumn |

---

## 📱 Live Demo

Explore the interactive showcase app:

👉 [https://super-string-utils-example.vercel.app/](https://super-string-utils-example.vercel.app/)

---

## 🤝 Contributing

Contributions are welcome.

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to your fork
5. Open a Pull Request

Help grow the Flutter ecosystem.

---

## 📜 License

Released under the MIT License.

---

<p align="center">
<strong>Built with 💙 for the Flutter community</strong>
</p>
