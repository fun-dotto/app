abstract final class Config {
  static const String appApiGatewayBaseUrl = String.fromEnvironment(
    'APP_API_GATEWAY_BASE_URL',
  );
  static const String cloudflareR2Endpoint = String.fromEnvironment(
    'CLOUDFLARE_R2_ENDPOINT',
  );
  static const String cloudflareR2AccessKeyId = String.fromEnvironment(
    'CLOUDFLARE_R2_ACCESS_KEY_ID',
  );
  static const String cloudflareR2SecretAccessKey = String.fromEnvironment(
    'CLOUDFLARE_R2_SECRET_ACCESS_KEY',
  );
  static const String cloudflareR2BucketName = String.fromEnvironment(
    'CLOUDFLARE_R2_BUCKET_NAME',
  );
}
