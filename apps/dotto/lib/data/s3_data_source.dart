import 'package:dotto/foundation/config/environment_configs.dart';
import 'package:minio/minio.dart';
import 'package:minio/models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 's3_data_source.g.dart';

@Riverpod(keepAlive: true)
Minio s3Client(Ref ref) => Minio(
  endPoint: EnvironmentConfigs.cloudflareR2Endpoint,
  accessKey: EnvironmentConfigs.cloudflareR2AccessKeyId,
  secretKey: EnvironmentConfigs.cloudflareR2SecretAccessKey,
);
@riverpod
S3DataSource s3DataSource(Ref ref) => S3DataSource(
  ref.watch(s3ClientProvider),
  EnvironmentConfigs.cloudflareR2BucketName,
);

final class S3DataSource {
  const new(this._s3, this._bucketName);
  final Minio _s3;
  final String _bucketName;

  Future<List<String>> getListObjectsKey({required String url}) async {
    final returnStr = <String>[];
    await for (final value in _s3.listObjectsV2(
      _bucketName,
      prefix: url,
      recursive: true,
    )) {
      for (final obj in value.objects) {
        if (obj.key case final String key) returnStr.add(key);
      }
    }
    return List.unmodifiable(returnStr);
  }

  Future<MinioByteStream> getObject({required String url}) async {
    return await _s3.getObject(_bucketName, url);
  }

  Stream<ListObjectsResult> listObjectsV2({
    String prefix = '',
    String? startAfter,
  }) async* {
    MinioInvalidBucketNameError.check(_bucketName);
    MinioInvalidPrefixError.check(prefix);
    const delimiter = '';

    bool? isTruncated = false;
    String? continuationToken;

    do {
      final resp = await _s3.listObjectsV2Query(
        _bucketName,
        prefix,
        continuationToken,
        delimiter,
        null,
        startAfter,
      );
      isTruncated = resp.isTruncated;
      continuationToken = resp.nextContinuationToken;
      yield ListObjectsResult(
        objects: resp.contents!,
        prefixes: resp.commonPrefixes.map((e) => e.prefix!).toList(),
      );
    } while (isTruncated!);
  }
}
