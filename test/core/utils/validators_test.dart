import 'package:flutter_test/flutter_test.dart';
import 'package:neurocare_app/core/utils/validators.dart';

void main() {
  group('Validators', () {
    group('validateEmail', () {
      test('returns null for valid email', () {
        expect(Validators.validateEmail('test@example.com'), isNull);
        expect(Validators.validateEmail('user.name+tag@domain.co.uk'), isNull);
      });

      test('returns error message for invalid email', () {
        expect(Validators.validateEmail(''), isNotNull);
        expect(Validators.validateEmail('invalid-email'), isNotNull);
        expect(Validators.validateEmail('test@'), isNotNull);
        expect(Validators.validateEmail('@example.com'), isNotNull);
      });

      test('returns error message for null email', () {
        expect(Validators.validateEmail(null), isNotNull);
      });
    });

    group('validatePassword', () {
      test('returns null for valid password', () {
        expect(Validators.validatePassword('ValidPass123'), isNull);
        expect(Validators.validatePassword('MySecurePassword!2024'), isNull);
      });

      test('returns error for password too short', () {
        expect(Validators.validatePassword('123'), isNotNull);
        expect(Validators.validatePassword('abcdef'), isNotNull);
      });

      test('returns error for password without uppercase', () {
        expect(Validators.validatePassword('validpass123'), isNotNull);
      });

      test('returns error for password without lowercase', () {
        expect(Validators.validatePassword('VALIDPASS123'), isNotNull);
      });

      test('returns error for password without digits', () {
        expect(Validators.validatePassword('ValidPassword'), isNotNull);
      });

      test('returns error for null or empty password', () {
        expect(Validators.validatePassword(null), isNotNull);
        expect(Validators.validatePassword(''), isNotNull);
      });
    });

    group('validatePhone', () {
      test('returns null for valid phone numbers', () {
        expect(Validators.validatePhone('1234567890'), isNull);
        expect(Validators.validatePhone('+1234567890123'), isNull);
      });

      test('returns error for invalid phone numbers', () {
        expect(Validators.validatePhone('123'), isNotNull);
        expect(Validators.validatePhone('abcdefghij'), isNotNull);
        expect(Validators.validatePhone(''), isNotNull);
      });

      test('returns error for null phone', () {
        expect(Validators.validatePhone(null), isNotNull);
      });
    });

    group('validateRequired', () {
      test('returns null for non-empty strings', () {
        expect(Validators.validateRequired('test'), isNull);
        expect(Validators.validateRequired('  test  '), isNull);
      });

      test('returns error for empty or whitespace-only strings', () {
        expect(Validators.validateRequired(''), isNotNull);
        expect(Validators.validateRequired('   '), isNotNull);
      });

      test('returns error for null value', () {
        expect(Validators.validateRequired(null), isNotNull);
      });

      test('uses custom field name in error message', () {
        final result = Validators.validateRequired(null, fieldName: 'Name');
        expect(result, contains('Name'));
      });
    });

    group('validateMinLength', () {
      test('returns null for strings meeting minimum length', () {
        expect(Validators.validateMinLength('test', 4), isNull);
        expect(Validators.validateMinLength('hello', 3), isNull);
      });

      test('returns error for strings below minimum length', () {
        expect(Validators.validateMinLength('hi', 4), isNotNull);
        expect(Validators.validateMinLength('', 1), isNotNull);
      });

      test('returns null for null values (optional validation)', () {
        expect(Validators.validateMinLength(null, 4), isNull);
      });
    });

    group('validateMaxLength', () {
      test('returns null for strings within maximum length', () {
        expect(Validators.validateMaxLength('test', 4), isNull);
        expect(Validators.validateMaxLength('hi', 4), isNull);
      });

      test('returns error for strings exceeding maximum length', () {
        expect(Validators.validateMaxLength('hello', 3), isNotNull);
      });

      test('returns null for null values (optional validation)', () {
        expect(Validators.validateMaxLength(null, 4), isNull);
      });
    });
  });
}
