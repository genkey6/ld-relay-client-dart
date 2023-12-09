# ld-relay-client-dart
[![GitHub Actions](https://github.com/genkey6/ld-relay-client-dart/actions/workflows/ci.yaml/badge.svg)](https://github.com/genkey6/ld-relay-client-dart/actions/workflows/ci.yaml)
[![Pub](https://img.shields.io/pub/v/ld_relay_client.svg)](https://pub.dev/packages/ld_relay_client)

A client implementation for [Relay Proxy](https://docs.launchdarkly.com/home/relay-proxy) of [LaunchDarkly](https://launchdarkly.com/) in Dart.

## How to use
### Step 1: Installation
```
dart pub add ld_relay_client
```

### Step 2: Initialize the client
```dart
import 'package:ld_relay_client/ld_relay_client.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

final client = LDRelayClient(
  LDRelayConfig(
    sdkKey: '<your-server-sdk-key>', // your LaunchDarkly server-side SDK key (caution: The SDK key should be kept a secret)
    ldRelayBaseUrl: 'http://localhost:8030', // the base URL for Relay Proxy
  ),
  http.Client(),
  Logger(),
);
```

### Step 3: Evaluate the flag value and switch the logic
```dart
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
```
