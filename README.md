# Super String Utils

A powerful, production-ready library of Dart `String` extension methods. 

`super_string_utils` is designed to reduce boilerplate code by providing a robust suite of string manipulation, validation, and extraction tools without heavy external dependencies.

## Features

- **Boolean Checks:** `isBlank`, `isNumeric`, `isAlpha`, `isUrl`, `isStrongPassword`, `containsEmoji`, etc.
- **Transformation:** `capitalizeSafe`, `toTitleCase`, `slugify`, `removeAccents`, `reverse`, etc.
- **Extraction:** `extractEmails`, `extractHashtags`, `extractUrls`, `extractNumbers`.
- **Security:** `mask`, `maskEmail`, `obfuscate`.
- **Comparison:** `fuzzyMatch` (Levenshtein distance), `equalsIgnoreCase`.

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  super_string_utils: ^1.0.0
```

## Usage

Import the package and use the extensions on any String object.

```dart
import 'package:super_string_utils/super_string_utils.dart';

void main() {
  // Checks
  print('  '.isBlank); // true
  print('user@email.com'.isEmail); // true based on regex extraction logic
  
  // Transformation
  print('hello world'.toTitleCase); // "Hello World"
  print('Crème Brûlée'.removeAccents); // "Creme Brulee"
  print('Hello World'.slugify); // "hello-world"
  
  // Extraction
  String post = "Learning #Dart and #Flutter at [https://flutter.dev](https://flutter.dev)";
  print(post.extractHashtags); // ["#Dart", "#Flutter"]
  print(post.extractUrls); // ["[https://flutter.dev](https://flutter.dev)"]
  
  // Security
  print('password123'.mask(visibleCount: 2)); // *********23
  
  // Fuzzy Match (0.0 to 1.0 similarity)
  print('kitten'.fuzzyMatch('sitten')); // ~0.83
}
```

## Testing

This package includes comprehensive unit tests ensuring 100% coverage for edge cases, null handling (via empty strings), and unicode support.

## License

MIT
