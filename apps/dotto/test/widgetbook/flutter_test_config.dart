import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

// 再現性のため、タグで固定した版を取得する。
const _notoSansJpBaseUrl =
    'https://github.com/notofonts/noto-cjk/raw/Sans2.004/Sans/SubsetOTF/JP';
const _notoSansJpFiles = ['NotoSansJP-Regular.otf', 'NotoSansJP-Bold.otf'];

// テーマで fontFamily を指定していないため、テスト環境 (Android 扱い) の既定である Roboto として登録する。
const _defaultFontFamily = 'Roboto';

/// VRT の基準画像で文字やアイコンが四角 (テスト用フォント) にならないよう、実フォントを読み込む。
///
/// 日本語フォントはリポジトリに含めず、実行時に Web から取得する。
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  // 基準画像は Linux でのみ比較するため、他の OS では取得を省く。
  if (!Platform.isLinux) {
    await testMain();
    return;
  }

  // TestWidgetsFlutterBinding は HTTP 通信を無効化するため、初期化より前に取得する。
  final notoSansJpFonts = await Future.wait(
    _notoSansJpFiles.map((file) => _download('$_notoSansJpBaseUrl/$file')),
  );

  TestWidgetsFlutterBinding.ensureInitialized();

  final defaultFontLoader = FontLoader(_defaultFontFamily);
  for (final font in notoSansJpFonts) {
    defaultFontLoader.addFont(Future.value(ByteData.sublistView(font)));
  }
  await defaultFontLoader.load();
  await _loadBundledFonts();

  await testMain();
}

// GitHub は一時的に 5xx を返すことがあるため、間隔を空けて再試行する。
const _maxDownloadAttempts = 3;
const _retryInterval = Duration(seconds: 2);

Future<Uint8List> _download(String url) async {
  for (var attempt = 1; ; attempt++) {
    try {
      return await _downloadOnce(Uri.parse(url));
    } on HttpException {
      if (attempt >= _maxDownloadAttempts) rethrow;
      await Future<void>.delayed(_retryInterval * attempt);
    }
  }
}

Future<Uint8List> _downloadOnce(Uri uri) async {
  final client = HttpClient();
  try {
    final request = await client.getUrl(uri);
    final response = await request.close();
    if (response.statusCode != HttpStatus.ok) {
      throw HttpException('フォントを取得できませんでした (${response.statusCode})', uri: uri);
    }
    final builder = BytesBuilder(copy: false);
    await response.forEach(builder.add);
    return builder.takeBytes();
  } finally {
    client.close();
  }
}

/// アプリに同梱されるフォント (Material Icons など) を、FontManifest.json に従って読み込む。
Future<void> _loadBundledFonts() async {
  final manifest = await rootBundle.loadString('FontManifest.json');
  final families = (jsonDecode(manifest) as List<dynamic>)
      .cast<Map<String, dynamic>>();

  for (final family in families) {
    final loader = FontLoader(family['family'] as String);
    for (final font
        in (family['fonts'] as List<dynamic>).cast<Map<String, dynamic>>()) {
      loader.addFont(rootBundle.load(font['asset'] as String));
    }
    await loader.load();
  }
}
