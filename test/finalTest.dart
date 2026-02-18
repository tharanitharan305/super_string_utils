import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_string_utils/super_string_utils.dart';

void main() {
  // ===========================================================================
  // 1. CORE EXTENSIONS (Logic)
  // ===========================================================================
  group('Core: Boolean Checks', () {
    test('isBlank', () {
      expect(''.isBlank, true);
      expect('   '.isBlank, true);
      expect('a'.isBlank, false);
    });

    test('isNumeric', () {
      expect('123'.isNumeric, true);
      expect('12.5'.isNumeric, true);
      expect('12a'.isNumeric, false);
    });

    test('isAlpha / isAlphaNumeric', () {
      expect('abc'.isAlpha, true);
      expect('123'.isAlpha, false);
      expect('a1'.isAlphaNumeric, true);
      expect('a!'.isAlphaNumeric, false);
    });

    test('isUrl', () {
      expect('https://google.com'.isUrl, true);
      expect('google.com'.isUrl, false); // Strict check
    });

    test('isStrongPassword', () {
      expect('Pass123!'.isStrongPassword, true);
      expect('weak'.isStrongPassword, false);
    });

    test('containsEmoji', () {
      expect('Hello 😀'.containsEmoji, true);
      expect('Hello'.containsEmoji, false);
    });

    test('Case Sensitivity', () {
      expect('ABC'.equalsIgnoreCase('abc'), true);
      expect('Hello World'.containsIgnoreCase('world'), true);
    });
  });

  group('Core: Transformation', () {
    test('Capitalization', () {
      expect('hello'.capitalizeSafe, 'Hello');
      expect(''.capitalizeSafe, '');
      expect('hello world'.toTitleCase, 'Hello World');
      expect('HELLO WORLD'.toSentenceCase, 'Hello world');
      expect('hello world'.capitalizeWords, 'Hello World');
    });

    test('Case Swapping', () {
      expect('AbC'.toggleCase, 'aBc');
      expect('AbC'.swapCase, 'aBc');
    });

    test('Reversal', () {
      expect('abc'.reverse, 'cba');
    });

    test('Slugify', () {
      expect('Hello World!'.slugify, 'hello-world');
      expect('Café'.slugify, 'cafe');
    });
  });

  group('Core: Cleaning', () {
    test('Special Chars', () {
      expect('a!b@c#'.removeSpecialChars, 'abc');
    });

    test('Accents', () {
      expect('àéîö'.removeAccents, 'aeio');
    });

    test('Whitespace', () {
      expect(' a   b '.normalizeWhitespace, 'a b');
      expect(' a   b '.removeExtraSpaces, 'a b');
    });

    test('HTML', () {
      expect('<p>Test</p>'.stripHtml, 'Test');
    });

    test('Digits Only', () {
      expect('+1 (555)'.digitsOnly, '1555');
    });
  });

  group('Core: Extraction', () {
    test('Hashtags', () {
      expect('Hi #flutter'.extractHashtags, ['#flutter']);
    });

    test('Emails', () {
      expect('Email: test@test.com'.extractEmails, ['test@test.com']);
    });

    test('URLs', () {
      expect('Click https://dart.dev'.extractUrls, ['https://dart.dev']);
    });

    test('Numbers', () {
      expect('Cost 10.50'.extractNumbers, [10.50]);
    });

    test('Initials', () {
      expect('John Doe'.initials(limit: 2), 'JD');
    });

    test('Between', () {
      expect('User[123]'.between('[', ']'), '123');
    });
  });

  group('Core: Manipulation', () {
    test('Truncate & Limit', () {
      expect('Hello World'.truncate(5), 'Hello...');
      expect('one two three'.limitWords(2), 'one two...');
    });

    test('Padding', () {
      expect('A'.padCenter(3, '-'), '-A-');
    });

    test('Prefix/Suffix', () {
      expect('Mr. A'.removePrefix('Mr. '), 'A');
      expect('img.png'.removeSuffix('.png'), 'img');
      expect('site.com'.ensureStartsWith('https://'), 'https://site.com');
      expect('file'.ensureEndsWith('.txt'), 'file.txt');
    });

    test('Repeat', () {
      expect('a'.repeat(3), 'aaa');
    });
  });

  group('Core: Security (Basic)', () {
    test('Masking', () {
      expect('12345'.mask(visibleCount: 2), '***45');
      expect('johndoe@gmail.com'.maskEmail, 'j*****e@gmail.com');
    });

    test('Obfuscate', () {
      expect('abc'.obfuscate, isNot('abc')); // Simple check
    });
  });

  group('Core: Stats', () {
    test('Counts', () {
      expect('one two'.wordCount, 2);
      expect('abc'.charCount, 3);
    });
  });

  // ===========================================================================
  // 2. ADVANCED MODULES
  // ===========================================================================

  group('Module: Security & Crypto', () {
    test('Hashes', () {
      expect('abc'.md5Hash.isNotEmpty, true);
      expect('abc'.sha1Hash.isNotEmpty, true);
      expect('abc'.sha256Hash.isNotEmpty, true);
    });

    test('Base64', () {
      expect('hello'.toBase64, 'aGVsbG8=');
      expect('aGVsbG8='.fromBase64, 'hello');
    });
  });

  group('Module: Web & Network', () {
    test('URL Encoding', () {
      expect('hello world'.urlEncode, 'hello%20world');
      expect('hello%20world'.urlDecode, 'hello world');
    });

    test('Validation', () {
      expect('192.168.1.1'.isIpv4, true);
      expect('999.999.999'.isIpv4, false);
      expect('{"a":1}'.isJson, true);
    });
  });

  group('Module: Numeric', () {
    test('Boolean Parsing', () {
      expect('true'.toBool, true);
      expect('yes'.toBool, true);
      expect('1'.toBool, true);
      expect('no'.toBool, false);
    });

    test('Numeric Parsing', () {
      expect('12.5'.toDoubleOrNull, 12.5);
      expect('abc'.toDoubleOrNull, null);
      expect('10'.toIntOrNull, 10);
      expect('101'.isBinary, true);
      expect('1A'.isHex, true);
    });
  });

  group('Module: Search & Analysis', () {
    test('Reading Time', () {
      final text = 'word ' * 200; // 200 words
      expect(text.readingTime(wpm: 200), 1.0);
    });

    test('Word Frequency', () {
      expect('a b a'.wordFrequency, {'a': 2, 'b': 1});
    });

    test('Substrings', () {
      expect('banana'.countMatches('a'), 3);
      expect('a-b'.substringBefore('-'), 'a');
      expect('a-b'.substringAfter('-'), 'b');
    });
  });

  group('Module: Date & Time', () {
    test('Date Parsing', () {
      expect('2023-01-01'.isDate, true);
      expect('2023-01-01'.toDateTime.year, 2023);
      expect('invalid'.toDateTimeOrNull, null);
    });

    test('Duration Parsing', () {
      expect('01:30:00'.toDurationOrNull, const Duration(hours: 1, minutes: 30));
    });
  });

  group('Module: Collections', () {
    test('Lists', () {
      expect('a,b'.csvToList, ['a', 'b']);
      expect('1234'.chunk(2), ['12', '34']);
      expect('A\nB'.lines, ['A', 'B']);
    });

    test('Maps', () {
      expect('{"a":1}'.jsonToMap?['a'], 1);
      expect('a=1&b=2'.queryToMap['a'], '1');
    });
  });

  group('Module: Text Processing', () {
    test('Processing', () {
      expect('Hello World'.reverseWords, 'World Hello');
      expect(' a b '.removeWhitespace, 'ab');
      expect('A\nB'.indent(2), '  A\n  B');
      expect('  A'.unindent, 'A');
    });
  });

  group('Module: Fuzzy & Replace', () {
    test('Fuzzy', () {
      expect('test'.fuzzyMatch('test'), 1.0);
      expect('test'.jaroWinkler('test'), 1.0);
    });

    test('Replace', () {
      expect('a b c'.replaceAt(2, 'z'), 'a z c');
      expect('A b A'.replaceFirstIgnoreCase('a', 'X'), 'X b A');
    });
  });

  group('Module: International', () {
    test('ASCII/Unicode', () {
      expect('abc'.isAscii, true);
      expect('abc'.hasUnicode, false);
      expect('©'.isAscii, false);
      expect('👍'.hasUnicode, true);
    });
  });

  group('Module: Structural', () {
    test('Null Checks', () {
      expect(''.nullIfEmpty, null);
      expect(' '.nullIfBlank, null);
      expect('a'.nullIfEmpty, 'a');
    });
  });

  // ===========================================================================
  // 3. UI & BUILDERS (Widget Tests)
  // ===========================================================================

  group('Flutter UI Extensions', () {
    testWidgets('.toText builds a Text widget', (tester) async {
      await tester.pumpWidget(MaterialApp(home: "Hello".toText()));
      expect(find.text("Hello"), findsOneWidget);
    });

    testWidgets('.toColor parses hex strings', (tester) async {
      final color = "#FF0000".toColor;
      expect(color, const Color(0xFFFF0000));
      // Render to ensure no crash
      await tester.pumpWidget(Container(color: color));
    });
  });

  group('Fluent Builders: TextBuilder', () {
    testWidgets('Builds with styles and container', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: "Test".toTextBuilder
              .color(Colors.red)
              .size(20)
              .weight(FontWeight.bold)
              .insideContainer(color: Colors.blue)
              .build(),
        ),
      ));

      // Find Text
      final textFinder = find.text("Test");
      expect(textFinder, findsOneWidget);

      final textWidget = tester.widget<Text>(textFinder);
      expect(textWidget.style?.color, Colors.red);
      expect(textWidget.style?.fontWeight, FontWeight.bold);

      // Find Container wrapper
      final containerFinder = find.ancestor(of: textFinder, matching: find.byType(Container));
      expect(containerFinder, findsOneWidget);
      final container = tester.widget<Container>(containerFinder);
      expect(container.color, Colors.blue);
    });

    testWidgets('Expanded functionality', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Column(children: ["Test".toTextBuilder.expanded().build()]),
      ));
      expect(find.byType(Expanded), findsOneWidget);
    });
  });

  group('Fluent Builders: TextListBuilder (Rows/Columns)', () {
    testWidgets('toTextColumn builds Column with children', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: ["A", "B"].toTextColumn().build()),
      ));
      expect(find.text("A"), findsOneWidget);
      expect(find.text("B"), findsOneWidget);

      // The builder returns a Flex widget, not specifically a Column or Row
      final flexFinder = find.byType(Flex);
      expect(flexFinder, findsOneWidget);

      final flex = tester.widget<Flex>(flexFinder);
      expect(flex.direction, Axis.vertical);
    });

    testWidgets('Basic row construction', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: ["A", "B"].toTextRow().build()),
      ));
      expect(find.text("A"), findsOneWidget);
      expect(find.text("B"), findsOneWidget);

      // The builder returns a Flex widget, not specifically a Column or Row
      final flexFinder = find.byType(Flex);
      expect(flexFinder, findsOneWidget);

      final flex = tester.widget<Flex>(flexFinder);
      expect(flex.direction, Axis.horizontal);
    });

    testWidgets('Per-index Layout: expandAt and paddingAt', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              ["A", "B"].toTextRow()
                  .expandAt(1) // Expand "B"
                  .paddingAt(0, const EdgeInsets.all(10)) // Pad "A"
                  .build()
            ],
          ),
        ),
      ));

      // Check "A" has padding
      final aFinder = find.text("A");
      final paddingFinder = find.ancestor(of: aFinder, matching: find.byType(Padding));
      expect(paddingFinder, findsOneWidget);

      // Check "B" is expanded
      final bFinder = find.text("B");
      final expandedFinder = find.ancestor(of: bFinder, matching: find.byType(Expanded));
      expect(expandedFinder, findsOneWidget);
    });
  });

  group('Fluent Builders: SnackbarBuilder', () {
    testWidgets('Builds proper snackbar', (tester) async {
      // SnackBars usually need to be triggered, but we can verify the object properties
      // by building it in isolation for property checking (unit-style widget test)

      final builder = "Toast".toSnackbarBuilder
          .color(Colors.green)
          .floating()
          .action("Undo", () {});

      final snackbar = builder.build();

      expect(snackbar.content, isA<Text>());
      expect((snackbar.content as Text).data, "Toast");
      expect(snackbar.backgroundColor, Colors.green);
      expect(snackbar.behavior, SnackBarBehavior.floating);
      expect(snackbar.action, isNotNull);
    });
  });
}