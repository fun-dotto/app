import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_links.freezed.dart';

/// アプリから案内する外部ページの URL。
@freezed
abstract class AppLinks with _$AppLinks {
  const factory({
    required String feedbackFormUrl,
    required String termsOfServiceUrl,
    required String privacyPolicyUrl,
  }) = _AppLinks;
}
