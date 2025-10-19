import 'dart:convert';

/// String extension methods for common string operations
extension StringExtensions on String {
  /// Capitalize first letter of string
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  /// Capitalize first letter of each word
  String capitalizeWords() {
    if (isEmpty) return this;
    return split(' ')
        .map((word) => word.isNotEmpty ? word.capitalize() : word)
        .join(' ');
  }

  /// Convert to title case
  String toTitleCase() {
    if (isEmpty) return this;
    return replaceAllMapped(
      RegExp(r'\b\w'),
      (match) => match.group(0)!.toUpperCase(),
    );
  }

  /// Remove all whitespace
  String removeWhitespace() {
    return replaceAll(RegExp(r'\s+'), '');
  }

  /// Remove extra whitespace and trim
  String normalizeWhitespace() {
    return replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  /// Check if string is a valid email
  bool get isValidEmail {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  }

  /// Check if string is a valid phone number
  bool get isValidPhone {
    final cleanPhone = replaceAll(RegExp(r'[^\d]'), '');
    return cleanPhone.length >= 10 && cleanPhone.length <= 15;
  }

  /// Check if string contains only digits
  bool get isNumeric {
    return RegExp(r'^\d+$').hasMatch(this);
  }

  /// Check if string contains only letters
  bool get isAlphabetic {
    return RegExp(r'^[a-zA-Z]+$').hasMatch(this);
  }

  /// Check if string contains only letters and spaces
  bool get isAlphabeticWithSpaces {
    return RegExp(r'^[a-zA-Z\s]+$').hasMatch(this);
  }

  /// Extract numbers from string
  String get extractNumbers {
    return replaceAll(RegExp(r'[^\d]'), '');
  }

  /// Extract letters from string
  String get extractLetters {
    return replaceAll(RegExp(r'[^a-zA-Z]'), '');
  }

  /// Truncate string with ellipsis
  String truncate(int maxLength, {String suffix = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength - suffix.length)}$suffix';
  }

  /// Convert camelCase to snake_case
  String get camelToSnake {
    return replaceAllMapped(
      RegExp(r'([A-Z])'),
      (match) => '_${match.group(1)!.toLowerCase()}',
    );
  }

  /// Convert snake_case to camelCase
  String get snakeToCamel {
    return split('_').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join();
  }

  /// Convert to kebab-case
  String get toKebabCase {
    return replaceAll('_', '-').toLowerCase();
  }

  /// Remove special characters and replace with spaces
  String get sanitize {
    return replaceAll(RegExp(r'[^\w\s]'), ' ').normalizeWhitespace();
  }

  /// Get initials from name (first letter of each word)
  String get initials {
    final words = trim().split(RegExp(r'\s+'));
    if (words.isEmpty) return '';
    if (words.length == 1) return words[0][0].toUpperCase();
    return words.take(2).map((word) => word[0].toUpperCase()).join();
  }

  /// Check if string is empty or null
  bool get isNullOrEmpty {
    return trim().isEmpty;
  }

  /// Check if string is not empty and not null
  bool get isNotNullOrEmpty {
    return !isNullOrEmpty;
  }

  /// Convert string to boolean
  bool? toBool() {
    final lower = toLowerCase();
    if (lower == 'true' || lower == '1' || lower == 'yes') return true;
    if (lower == 'false' || lower == '0' || lower == 'no') return false;
    return null;
  }

  /// Convert string to int safely
  int? toInt() {
    return int.tryParse(this);
  }

  /// Convert string to double safely
  double? toDouble() {
    return double.tryParse(this);
  }

  /// Get file extension from path
  String get fileExtension {
    final lastDot = lastIndexOf('.');
    if (lastDot == -1) return '';
    return substring(lastDot + 1).toLowerCase();
  }

  /// Get file name from path
  String get fileName {
    final lastSeparator = lastIndexOf('/') > lastIndexOf('\\')
        ? lastIndexOf('/')
        : lastIndexOf('\\');
    if (lastSeparator == -1) return this;
    return substring(lastSeparator + 1);
  }

  /// Get file name without extension
  String get fileNameWithoutExtension {
    final fileName = this.fileName;
    final lastDot = fileName.lastIndexOf('.');
    if (lastDot == -1) return fileName;
    return fileName.substring(0, lastDot);
  }

  /// URL encode string
  String get urlEncode {
    return Uri.encodeComponent(this);
  }

  /// URL decode string
  String get urlDecode {
    return Uri.decodeComponent(this);
  }

  /// Base64 encode string
  String get toBase64 {
    return base64Encode(utf8.encode(this));
  }

  /// Base64 decode string
  String get fromBase64 {
    try {
      return utf8.decode(base64Decode(this));
    } catch (e) {
      return this;
    }
  }
}
