import 'package:super_string_utils/super_string_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Security', () {
    test('hashing', () {
      expect('abc'.md5Hash, isNotEmpty);
      expect('abc'.sha1Hash, isNotEmpty);
    });
    test('base64', () {
      expect('hello'.toBase64, 'aGVsbG8=');
      expect('aGVsbG8='.fromBase64, 'hello');
    });
  });

  group('Numeric', () {
    test('booleans', () {
      expect('true'.toBool, isTrue);
      expect('yes'.toBool, isTrue);
      expect('1'.toBool, isTrue);
      expect('no'.toBool, isFalse);
    });
    test('numeric checks', () {
      expect('101'.isBinary, isTrue);
      expect('1A'.isHex, isTrue);
    });
  });

  group('Web', () {
    test('url encoding', () {
      expect('hello world'.urlEncode, 'hello%20world');
    });
    test('ipv4', () {
      expect('192.168.1.1'.isIpv4, isTrue);
      expect('999.999.999.999'.isIpv4, isFalse);
    });
  });

  group('Search', () {
    test('countMatches', () {
      expect('banana'.countMatches('a'), 3);
    });
    test('substrings', () {
      expect('user@domain'.substringBefore('@'), 'user');
      expect('user@domain'.substringAfter('@'), 'domain');
    });
  });
  
  group('Analysis', () {
    test('readingTime', () {
      final longText = 'word ' * 200;
      expect(longText.readingTime(), 1.0);
    });
  });
}
