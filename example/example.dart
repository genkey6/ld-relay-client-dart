import 'package:ld_relay_client/ld_relay_client.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

main() async {
  final client = LDRelayClient(
    LDRelayConfig(
      sdkKey: '<your-server-sdk-key>',
      ldRelayBaseUrl: 'http://localhost:8030',
    ),
    http.Client(),
    Logger(),
  );

  // with single context
  final evalResultWithSingleContext =
      await client.boolVariation('flag-key1', false, {
    'user': LaunchDarklyContextAttribute(key: 'user1'),
  });

  if (evalResultWithSingleContext) {
    // do something
  } else {
    // do something else
  }

  // with multi contexts
  final evalResultWithMultiContext =
      await client.boolVariation('flag-key2', false, {
    'user': LaunchDarklyContextAttribute(key: 'user2'),
    'tenant': LaunchDarklyContextAttribute(key: 'tenant2'),
  });

  if (evalResultWithMultiContext) {
    // do something
  } else {
    // do something else
  }
}
