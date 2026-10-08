import 'package:dotto/firebase_options.dart' as default_options;
import 'package:dotto/firebase_options_dev.dart' as dev_options;
import 'package:dotto/firebase_options_prd.dart' as prd_options;
import 'package:dotto/firebase_options_stg.dart' as stg_options;
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/services.dart' show appFlavor;

/// flavor に応じた [FirebaseOptions] を解決する。
///
/// `flutter run --flavor dev` 等で起動すると [appFlavor] に flavor 名が入る。
/// ストア版は `store` flavor でビルドし、`jp.ac.fun.dotto` のデフォルト設定
/// （[default_options]）を使用する。flavor 指定なし（`null`）の場合も同様とする。
class FlavoredFirebaseOptions {
  const new _();

  static FirebaseOptions get currentPlatform => switch (appFlavor) {
    'dev' => dev_options.DefaultFirebaseOptions.currentPlatform,
    'stg' => stg_options.DefaultFirebaseOptions.currentPlatform,
    'prd' => prd_options.DefaultFirebaseOptions.currentPlatform,
    'store' || _ => default_options.DefaultFirebaseOptions.currentPlatform,
  };
}
