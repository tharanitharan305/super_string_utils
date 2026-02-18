import 'dart:convert';
import 'package:crypto/crypto.dart';

/// Cryptographic and encoding extensions.
extension SecurityExtensions on String {
  /// MD5 Hash.
  String get md5Hash => md5.convert(utf8.encode(this)).toString();

  /// SHA-1 Hash.
  String get sha1Hash => sha1.convert(utf8.encode(this)).toString();

  /// SHA-256 Hash.
  String get sha256Hash => sha256.convert(utf8.encode(this)).toString();

  /// Base64 Encode.
  String get toBase64 => base64Encode(utf8.encode(this));

  /// Base64 Decode.
  String get fromBase64 {
    try {
      return utf8.decode(base64Decode(this));
    } catch (_) {
      return '';
    }
  }
}
