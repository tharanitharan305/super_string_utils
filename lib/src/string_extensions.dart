import 'dart:math';

/// Extension methods for [String] to add powerful utility functions.
extension SuperStringUtils on String {
  // =============================================================
  // BOOLEAN CHECKS
  // =============================================================

  /// Checks if the string is empty or consists only of whitespace.
  bool get isBlank => trim().isEmpty;

  /// Checks if the string contains only numeric characters.
  bool get isNumeric => double.tryParse(this) != null;

  /// Checks if the string contains only alphabet characters (a-z, A-Z).
  bool get isAlpha => isNotEmpty && RegExp(r'^[a-zA-Z]+$').hasMatch(this);

  /// Checks if the string contains only alphanumeric characters (a-z, A-Z, 0-9).
  bool get isAlphaNumeric =>
      isNotEmpty && RegExp(r'^[a-zA-Z0-9]+$').hasMatch(this);

  /// Checks if the string is a valid URL.
  bool get isUrl {
    if (isBlank) return false;
    final pattern = r'^(http|https):\/\/([\w.]+\/?)\S*$';
    return RegExp(pattern, caseSensitive: false).hasMatch(this);
  }

  /// Checks if the string contains any emojis.
  bool get containsEmoji {
    final regex = RegExp(
        r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])');
    return regex.hasMatch(this);
  }

  /// Checks if two strings are equal, ignoring case.
  bool equalsIgnoreCase(String other) => toLowerCase() == other.toLowerCase();

  /// Checks if the string contains [other], ignoring case.
  bool containsIgnoreCase(String other) =>
      toLowerCase().contains(other.toLowerCase());

  /// Checks if a password is considered "strong".
  bool get isStrongPassword {
    if (length < 8) return false;
    if (!contains(RegExp(r'[A-Z]'))) return false;
    if (!contains(RegExp(r'[a-z]'))) return false;
    if (!contains(RegExp(r'[0-9]'))) return false;
    if (!contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return false;
    return true;
  }

  // =============================================================
  // TRANSFORMATION & FORMATTING
  // =============================================================

  /// Capitalizes the first character of the string.
  String get capitalizeSafe {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Converts the string to Title Case.
  String get toTitleCase {
    if (isEmpty) return this;
    return split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .map((word) => word.capitalizeSafe)
        .join(' ');
  }

  /// Converts the string to Sentence case.
  String get toSentenceCase {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  /// Capitalizes all words in the string.
  String get capitalizeWords => toTitleCase;

  /// Toggles the case of each character.
  String get toggleCase {
    return split('').map((char) {
      if (char == char.toUpperCase()) return char.toLowerCase();
      return char.toUpperCase();
    }).join('');
  }

  /// Alias for [toggleCase].
  String get swapCase => toggleCase;

  /// Reverses the string.
  String get reverse => String.fromCharCodes(runes.toList().reversed);

  /// Removes all special characters.
  String get removeSpecialChars => replaceAll(RegExp(r'[^a-zA-Z0-9\s]'), '');

  /// Removes all accents/diacritics from the string.
  String get removeAccents {
    if (isEmpty) return this;
    var str = this;
    var withDia =
        'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
    var withoutDia =
        'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';

    for (int i = 0; i < withDia.length; i++) {
      str = str.replaceAll(withDia[i], withoutDia[i]);
    }
    return str;
  }

  /// Converts string to a URL-friendly slug.
  String get slugify {
    if (isEmpty) return this;
    return removeAccents
        .toLowerCase()
        .trim()
        .replaceAll(RegExp(r'[^a-z0-9\s-]'), '')
        .replaceAll(RegExp(r'\s+'), '-');
  }

  /// Replaces multiple whitespace characters with a single space.
  String get normalizeWhitespace => trim().replaceAll(RegExp(r'\s+'), ' ');

  /// Alias for [normalizeWhitespace].
  String get removeExtraSpaces => normalizeWhitespace;

  /// Removes HTML tags from the string.
  String get stripHtml =>
      replaceAll(RegExp(r'<[^>]*>', multiLine: true, caseSensitive: false), '');

  /// Repeats the string [times] times.
  String repeat(int times) {
    if (times <= 0) return '';
    return this * times;
  }

  /// Returns the initials of the words in the string.
  String initials({int limit = 2}) {
    if (isEmpty) return '';
    final words =
        trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toList();
    if (words.isEmpty) return '';

    final buffer = StringBuffer();
    for (var i = 0; i < words.length && i < limit; i++) {
      buffer.write(words[i][0].toUpperCase());
    }
    return buffer.toString();
  }

  // =============================================================
  // SUBSTRINGS & PADDING
  // =============================================================

  /// Truncates the string to [length] and adds [ellipsis] if needed.
  String truncate(int length, {String ellipsis = '...'}) {
    if (this.length <= length) return this;
    if (length < 0) return this;
    return '${substring(0, length)}$ellipsis';
  }

  /// Limits the string to [wordCount] words.
  String limitWords(int wordCount, {String ellipsis = '...'}) {
    final words = split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toList();
    if (words.length <= wordCount) return this;
    return '${words.sublist(0, wordCount).join(' ')}$ellipsis';
  }

  /// Pads the string on both sides to reach [width].
  String padCenter(int width, [String padding = ' ']) {
    if (length >= width) return this;
    final delta = width - length;
    final left = delta ~/ 2;
    final right = delta - left;
    return padding * left + this + padding * right;
  }

  /// Returns text between [start] and [end] delimiters.
  String between(String start, String end) {
    if (isEmpty) return '';
    final startIndex = indexOf(start);
    if (startIndex == -1) return '';
    final startOfText = startIndex + start.length;
    final endIndex = indexOf(end, startOfText);
    if (endIndex == -1) return '';
    return substring(startOfText, endIndex);
  }

  /// Removes [prefix] if present.
  String removePrefix(String prefix) {
    if (startsWith(prefix)) return substring(prefix.length);
    return this;
  }

  /// Removes [suffix] if present.
  String removeSuffix(String suffix) {
    if (endsWith(suffix)) return substring(0, length - suffix.length);
    return this;
  }

  /// Ensures the string starts with [prefix].
  String ensureStartsWith(String prefix) {
    if (startsWith(prefix)) return this;
    return '$prefix$this';
  }

  /// Ensures the string ends with [suffix].
  String ensureEndsWith(String suffix) {
    if (endsWith(suffix)) return this;
    return '$this$suffix';
  }

  // =============================================================
  // EXTRACTION & PARSING
  // =============================================================

  /// Extracts all hashtags (#tag) from the string.
  List<String> get extractHashtags {
    final regex = RegExp(r'(#+[a-zA-Z0-9_]+)');
    return regex.allMatches(this).map((m) => m.group(0)!).toList();
  }

  /// Extracts all email addresses.
  List<String> get extractEmails {
    final regex = RegExp(r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}');
    return regex.allMatches(this).map((m) => m.group(0)!).toList();
  }

  /// Extracts all URLs.
  List<String> get extractUrls {
    final regex = RegExp(
        r'https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)');
    return regex.allMatches(this).map((m) => m.group(0)!).toList();
  }

  /// Extracts all numbers.
  List<num> get extractNumbers {
    final regex = RegExp(r'-?\d+(\.\d+)?');
    return regex.allMatches(this).map((m) => num.parse(m.group(0)!)).toList();
  }

  /// Returns digits only.
  String get digitsOnly => replaceAll(RegExp(r'[^0-9]'), '');

  /// Returns the number of words.
  int get wordCount {
    if (isBlank) return 0;
    return RegExp(r'[\w-]+').allMatches(this).length;
  }

  /// Returns the number of characters.
  int get charCount => length;

  // =============================================================
  // MASKING & SECURITY
  // =============================================================

  /// Masks the string.
  String mask({int visibleCount = 4, String char = '*'}) {
    if (length <= visibleCount) return this;
    return char * (length - visibleCount) + substring(length - visibleCount);
  }

  /// Masks an email address.
  String get maskEmail {
    if (!contains('@')) return this;
    final parts = split('@');
    final local = parts[0];
    final domain = parts[1];

    if (local.length <= 1) return '$local@$domain';
    if (local.length == 2) return '${local[0]}*@$domain';

    return '${local[0]}${'*' * (local.length - 2)}${local[local.length - 1]}@$domain';
  }

  /// Simple obfuscation.
  String get obfuscate {
    return String.fromCharCodes(runes.map((c) => c + 1));
  }

  // =============================================================
  // SEARCH & SIMILARITY
  // =============================================================

  /// Calculates a fuzzy match score (0.0 to 1.0).
  double fuzzyMatch(String other) {
    if (this == other) return 1.0;
    if (isEmpty || other.isEmpty) return 0.0;

    int len1 = length;
    int len2 = other.length;
    List<List<int>> matrix =
        List.generate(len1 + 1, (i) => List.filled(len2 + 1, 0));

    for (int i = 0; i <= len1; i++) matrix[i][0] = i;
    for (int j = 0; j <= len2; j++) matrix[0][j] = j;

    for (int i = 1; i <= len1; i++) {
      for (int j = 1; j <= len2; j++) {
        int cost = (this[i - 1] == other[j - 1]) ? 0 : 1;
        matrix[i][j] = [
          matrix[i - 1][j] + 1,
          matrix[i][j - 1] + 1,
          matrix[i - 1][j - 1] + cost
        ].reduce(min);
      }
    }

    int distance = matrix[len1][len2];
    int maxLength = max(len1, len2);
    return 1.0 - (distance / maxLength);
  }
}
