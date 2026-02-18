/// Web related utilities.
extension WebExtensions on String {
  /// URL Encode.
  String get urlEncode => Uri.encodeComponent(this);

  /// URL Decode.
  String get urlDecode => Uri.decodeComponent(this);

  /// Checks if string is a valid IPv4.
  bool get isIpv4 => RegExp(r'^((25[0-5]|(2[0-4]|1\d|[1-9]|)\d)\.?\b){4}$').hasMatch(this);
  
  /// Checks if string seems to be JSON.
  bool get isJson => (startsWith('{') && endsWith('}')) || (startsWith('[') && endsWith(']'));
}
