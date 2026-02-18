Super String Utils

A powerhouse collection of 80+ String extension methods and Fluent UI builders for Dart and Flutter. Stop rewriting utility functions and start building faster.

<p align="center">
<a href="https://www.google.com/search?q=https://pub.dev/packages/super_string_utils">
<img src="https://www.google.com/search?q=https://img.shields.io/pub/v/super_string_utils.svg" alt="Pub" />
</a>
<a href="https://www.google.com/search?q=https://github.com/tharanitharan305/super_string_utils">
<img src="https://www.google.com/search?q=https://img.shields.io/github/stars/tharanitharan305/super_string_utils%3Fstyle%3Dsocial" alt="GitHub stars" />
</a>
<a href="https://opensource.org/licenses/MIT">
<img src="https://www.google.com/search?q=https://img.shields.io/badge/license-MIT-blue.svg" alt="License: MIT" />
</a>
</p>

⚡ Supercharge Your Strings

Dart's String class is great, but it lacks the batteries-included utilities needed for modern app development. Super String Utils fills that gap by providing a comprehensive suite of extensions for validation, manipulation, security, and—unique to this package—Fluent UI Builders.

📱 Live Demo

Experience the power of Super String Utils directly in your browser:
View Live Example App

🚀 Features

🛡️ Validation – isEmail, isUrl, isStrongPassword, isIpv4, isJson

✨ Transformation – toTitleCase, slugify, reverse, initials

🔒 Security – md5Hash, sha256Hash, toBase64, maskEmail

🎨 Fluent UI – Build Text, Row, Column, and SnackBar widgets directly from Strings

🧩 Extraction – Get lists of #hashtags, urls, emails, or numbers instantly

🧠 Analysis – readingTime, wordCount, fuzzyMatch (Levenshtein/Jaro-Winkler)

📐 Advanced Layout – Per-index control for list generation (padding, expansion, flex)

📦 Installation

Add this to your pubspec.yaml:

dependencies:
super_string_utils: ^1.1.0


Then run:

flutter pub get


🧠 Usage

1. Core Utilities

Manipulate and validate strings with ease.

import 'package:super_string_utils/super_string_utils.dart';

// Validation
print("user@example.com".isEmail); // true
print("192.168.1.1".isIpv4);       // true
print("Hello 😀".containsEmoji);   // true

// Transformation
print("hello world".toTitleCase);  // "Hello World"
print("Hello World!".slugify);     // "hello-world"

// Extraction
String bio = "Reach me at test@test.com or #flutter";
print(bio.extractEmails);   // ["test@test.com"]
print(bio.extractHashtags); // ["#flutter"]


2. Fluent UI Builders

Stop writing boilerplate Text widgets. Use the fluent API.

// Simple
"Hello World".toText(style: TextStyle(fontSize: 20));

// Advanced Builder
"Welcome Back"
.toTextBuilder
.size(24)
.weight(FontWeight.bold)
.color(Colors.indigo)
.center()
.build();

// Snackbars
"File Saved".toSnackbarBuilder
.floating()
.color(Colors.green)
.withCloseIcon()
.build();


3. Advanced Layouts

Generate complex Row or Column layouts from lists of strings with per-item customization.

["Header", "Body Content", "Footer"]
.toTextColumn()
.spacing(10)
.style(TextStyle(fontSize: 16))
// Customize specific indices
.containerAt(0, color: Colors.grey[200], padding: EdgeInsets.all(8))
.expandAt(1) // Make the body expand
.align(TextAlign.center)
.build();


4. Security & Web

Handle hashing and encoding directly on the string object.

String data = "Sensitive Data";

// Hashing
print(data.md5Hash);
print(data.sha256Hash);

// Encoding
String encoded = data.toBase64;
print(encoded.fromBase64); // "Sensitive Data"


🛠️ List of Categories

Category

Key Methods

Boolean

isBlank, isNumeric, isAlpha, isUrl, isStrongPassword

Transform

capitalizeSafe, toTitleCase, slugify, removeAccents

Security

mask, maskEmail, md5Hash, toBase64

Web

urlEncode, isIpv4, isJson

Numeric

toBool, toDoubleOrNull, isBinary, isHex

Analysis

readingTime, wordFrequency, countMatches

Fluent UI

toText, toTextRow, toSnackbarBuilder

📣 Credits

Author: Tharanitharan Kumarasamy

Repository: https://github.com/tharanitharan305/super_string_utils

Developed for the global Flutter developer community.

🤝 Open Source Contributions

Super String Utils is open source and welcomes contributions!

How to Contribute

⭐ Star the repository

Fork the project

Create a feature branch: git checkout -b feature/amazing-feature

Commit your changes

Push to your fork

Open a Pull Request

☕ Support the Project

If this package saved you time, consider buying me a coffee to support maintenance and new features:

<p>
<a href="https://www.google.com/search?q=https://github.com/tharanitharan305/super_string_utils">
<img src="https://www.google.com/search?q=https://img.shields.io/github/stars/tharanitharan305/super_string_utils%3Fstyle%3Dsocial" />
</a>
&nbsp;&nbsp;
<a href="https://buymeacoffee.com/tharanitharan">
<img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" height="40"/>
</a>
</p>

Your support helps keep the code clean and the features coming! ❤️

📜 License

This project is released under the MIT License.