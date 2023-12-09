import 'package:ld_relay_client/ld_relay_client.dart';
import 'package:test/test.dart';

void main() {
  group('LaunchDarklyContext#toJson', () {
    test('when LaunchDarklyContext is empty will throws an Exception', () {
      final LaunchDarklyContext context = {};

      expect(() => context.toJson(), throwsA(isA<Exception>()));
    });

    test(
        'when LaunchDarklyContext has single context can convert to json successfully',
        () {
      final context = {
        'user': LaunchDarklyContextAttribute(key: 'test-user'),
      };

      expect(context.toJson(), {
        'kind': 'user',
        'key': 'test-user',
      });
    });

    test(
        'when LaunchDarklyContext has multi contexts can convert to json successfully',
        () {
      final context = {
        'user': LaunchDarklyContextAttribute(key: 'test-user'),
        'tenant': LaunchDarklyContextAttribute(key: 'test-tenant'),
      };

      expect(context.toJson(), {
        'kind': 'multi',
        'user': {
          'key': 'test-user',
        },
        'tenant': {
          'key': 'test-tenant',
        },
      });
    });
  });
}
