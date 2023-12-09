/// Configurations for Relay Proxy client
class LDRelayConfig {
  /// Server SDK Key
  String sdkKey;

  /// Base URL for Relay Proxy
  String ldRelayBaseUrl;

  /// constructor
  LDRelayConfig({
    required this.sdkKey,
    required this.ldRelayBaseUrl,
  });
}
