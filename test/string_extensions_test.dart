import 'package:super_string_utils/super_string_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Boolean Checks', () {
    test('isBlank', () {
      expect(''.isBlank, isTrue);
      expect('   '.isBlank, isTrue);
      expect(' a '.isBlank, isFalse);
    });

    test('isNumeric', () {
      expect('123'.isNumeric, isTrue);
      expect('12.34'.isNumeric, isTrue);
      expect('12.34.56'.isNumeric, isFalse);
      expect('abc'.isNumeric, isFalse);
    });

    test('isAlpha', () {
      expect('abc'.isAlpha, isTrue);
      expect('ABC'.isAlpha, isTrue);
      expect('a1'.isAlpha, isFalse);
      expect(''.isAlpha, isFalse);
    });

    test('isAlphaNumeric', () {
      expect('abc123'.isAlphaNumeric, isTrue);
      expect('abc!'.isAlphaNumeric, isFalse);
      expect(''.isAlphaNumeric, isFalse);
    });

    test('isUrl', () {
      expect('https://google.com'.isUrl, isTrue);
      expect('http://example.org/path'.isUrl, isTrue);
      expect('google.com'.isUrl, isFalse);
      expect(''.isUrl, isFalse);
    });

    test('containsEmoji', () {
      expect('Hello 😀'.containsEmoji, isTrue);
      expect('Hello'.containsEmoji, isFalse);
      expect('🔥'.containsEmoji, isTrue);
    });

    test('isStrongPassword', () {
      expect('Pass123!'.isStrongPassword, isTrue);
      expect('pass123!'.isStrongPassword, isFalse);
      expect('PASS123!'.isStrongPassword, isFalse);
      expect('PassWord!'.isStrongPassword, isFalse);
      expect('Pass1234'.isStrongPassword, isFalse);
      expect('Pa1!'.isStrongPassword, isFalse);
    });

    test('Case Insensitive', () {
      expect('Hello'.equalsIgnoreCase('hello'), isTrue);
      expect('Hello'.equalsIgnoreCase('World'), isFalse);
      expect('Hello World'.containsIgnoreCase('WORLD'), isTrue);
    });
  });

  group('Transformations', () {
    test('capitalizeSafe', () {
      expect('hello'.capitalizeSafe, 'Hello');
      expect(''.capitalizeSafe, '');
      expect('h'.capitalizeSafe, 'H');
    });

    test('toTitleCase', () {
      expect('hello world'.toTitleCase, 'Hello World');
      expect('hello   world'.toTitleCase, 'Hello World');
      expect(''.toTitleCase, '');
    });

    test('toSentenceCase', () {
      expect('HELLO WORLD'.toSentenceCase, 'Hello world');
      expect(''.toSentenceCase, '');
    });

    test('toggleCase', () {
      expect('HeLLo'.toggleCase, 'hEllO');
    });

    test('reverse', () {
      expect('abc'.reverse, 'cba');
      expect(''.reverse, '');
    });

    test('removeSpecialChars', () {
      expect('Hello@# World!'.removeSpecialChars, 'Hello World');
      expect('123!@#'.removeSpecialChars, '123');
    });

    test('removeAccents', () {
      expect('Crème Brûlée'.removeAccents, 'Creme Brulee');
      expect(''.removeAccents, '');
    });

    test('slugify', () {
      expect('Hello World!'.slugify, 'hello-world');
      expect('Café & Bar'.slugify, 'cafe--bar');
      expect('  Space  '.slugify, 'space');
      expect(''.slugify, '');
    });

    test('normalizeWhitespace', () {
      expect('  Hello    World  '.normalizeWhitespace, 'Hello World');
      expect(''.normalizeWhitespace, '');
    });

    test('stripHtml', () {
      expect('<p>Hello</p>'.stripHtml, 'Hello');
      expect('<div class="a">World</div>'.stripHtml, 'World');
      expect('Plain'.stripHtml, 'Plain');
    });

    test('repeat', () {
      expect('a'.repeat(3), 'aaa');
      expect('a'.repeat(0), '');
    });

    test('initials', () {
      expect('John Doe'.initials(), 'JD');
      expect('John'.initials(), 'J');
      expect(''.initials(), '');
      expect('John Doe Smith'.initials(limit: 3), 'JDS');
    });
  });

  group('Substrings', () {
    test('truncate', () {
      expect('Hello World'.truncate(5), 'Hello...');
      expect('Hi'.truncate(5), 'Hi');
      expect(''.truncate(5), '');
    });

    test('limitWords', () {
      expect('one two three four'.limitWords(2), 'one two...');
      expect('one'.limitWords(2), 'one');
    });

    test('padCenter', () {
      expect('a'.padCenter(3, '-'), '-a-');
      expect('a'.padCenter(4, '-'), '-a--');
      expect('abc'.padCenter(2), 'abc');
    });

    test('between', () {
      expect('[data]'.between('[', ']'), 'data');
      expect('abc'.between('x', 'y'), '');
      expect('prefix[mid]suffix'.between('[', ']'), 'mid');
    });

    test('prefixes/suffixes', () {
      expect('Mr. John'.removePrefix('Mr. '), 'John');
      expect('John'.removePrefix('Mr. '), 'John');

      expect('image.png'.removeSuffix('.png'), 'image');
      expect('image.jpg'.removeSuffix('.png'), 'image.jpg');

      expect('http'.ensureStartsWith('https://'), 'https://http');
      expect('https://domain'.ensureStartsWith('https://'), 'https://domain');

      expect('file'.ensureEndsWith('.txt'), 'file.txt');
      expect('file.txt'.ensureEndsWith('.txt'), 'file.txt');
    });
  });

  group('Extraction', () {
    test('extractHashtags', () {
      expect('Love #coding and #dart'.extractHashtags, ['#coding', '#dart']);
      expect('No tags'.extractHashtags, isEmpty);
    });

    test('extractEmails', () {
      expect('Contact test@email.com now'.extractEmails, ['test@email.com']);
      expect('No email'.extractEmails, isEmpty);
    });

    test('extractUrls', () {
      expect('Go to https://dart.dev'.extractUrls, ['https://dart.dev']);
      expect('No url'.extractUrls, isEmpty);
    });

    test('extractNumbers', () {
      expect('Order 50 items at 12.99'.extractNumbers, [50, 12.99]);
      expect('No numbers'.extractNumbers, isEmpty);
    });

    test('digitsOnly', () {
      expect('+1 (555) 123-4567'.digitsOnly, '15551234567');
    });

    test('wordCount', () {
      expect('Hello world'.wordCount, 2);
      expect(''.wordCount, 0);
    });

    test('charCount', () {
      expect('abc'.charCount, 3);
      expect(''.charCount, 0);
    });
  });

  group('Masking & Fuzzy', () {
    test('mask', () {
      expect('1234567890'.mask(visibleCount: 4), '******7890');
      expect('123'.mask(visibleCount: 4), '123');
    });

    test('maskEmail', () {
      expect('johndoe@gmail.com'.maskEmail, 'j******e@gmail.com');
      expect('me@io.com'.maskEmail, 'm*@io.com');
      expect('a@b.com'.maskEmail, 'a@b.com'); // Too short to mask safely
      expect('ab@c.com'.maskEmail, 'a*@c.com');
      expect('invalid'.maskEmail, 'invalid');
    });

    test('obfuscate', () {
      final original = 'abc';
      final obf = original.obfuscate;
      expect(obf, isNot(original));
    });

    test('fuzzyMatch', () {
      expect('kitten'.fuzzyMatch('sitten'), closeTo(0.83, 0.01));
      expect('test'.fuzzyMatch('test'), 1.0);
      expect('abc'.fuzzyMatch('xyz'), 0.0);
      expect(''.fuzzyMatch('a'), 0.0);
    });
  });
}
