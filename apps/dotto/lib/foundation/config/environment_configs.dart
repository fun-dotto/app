abstract final class EnvironmentConfigs {
  static const appApiGatewayBaseUrl = String.fromEnvironment(
    'APP_API_GATEWAY_BASE_URL',
  );
  static const cloudflareR2Endpoint = String.fromEnvironment(
    'CLOUDFLARE_R2_ENDPOINT',
  );
  static const cloudflareR2AccessKeyId = String.fromEnvironment(
    'CLOUDFLARE_R2_ACCESS_KEY_ID',
  );
  static const cloudflareR2SecretAccessKey = String.fromEnvironment(
    'CLOUDFLARE_R2_SECRET_ACCESS_KEY',
  );
  static const cloudflareR2BucketName = String.fromEnvironment(
    'CLOUDFLARE_R2_BUCKET_NAME',
  );
}
