import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'github_api_client.g.dart';

const _gitHubApiBaseUrl = 'https://api.github.com';

/// GitHub REST API へアクセスする HTTP クライアント。
@riverpod
Dio gitHubApiClient(Ref ref) => Dio(BaseOptions(baseUrl: _gitHubApiBaseUrl));
