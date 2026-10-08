import 'package:freezed_annotation/freezed_annotation.dart';

part 'debug_tokens.freezed.dart';

/// 開発者向けに表示する各種トークン。取得できなかったものは `null` とする。
@freezed
abstract class DebugTokens with _$DebugTokens {
  const factory({String? appCheckToken, String? idToken, String? fcmToken}) =
      _DebugTokens;
}
