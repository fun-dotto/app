#!/usr/bin/env dart

// CLIスクリプトのため、printによるコンソール出力を許可する。
// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

/// Firebase の設定ファイル (google-services.json / GoogleService-Info.plist /
/// firebase_options*.dart) を Firebase CLI から取得・生成する。
///
/// 事前に `firebase login` (ローカル) もしくは Application Default Credentials
/// (CI) で認証しておくこと。
const projectId = 'swift2023groupc';
const appDir = 'apps/dotto';

class FirebaseTarget {
  const FirebaseTarget({
    required this.name,
    required this.androidAppId,
    required this.iosAppId,
    required this.androidOutput,
    required this.iosOutput,
    required this.dartOutput,
  });

  final String name;
  final String androidAppId;
  final String iosAppId;
  final String androidOutput;
  final String iosOutput;
  final String dartOutput;
}

const targets = [
  FirebaseTarget(
    name: 'default',
    androidAppId: '1:107577467292:android:bf5758604cdceb8506e859',
    iosAppId: '1:107577467292:ios:f2e02b1b0cf3bdea06e859',
    androidOutput: 'android/app/google-services.json',
    iosOutput: 'ios/firebase/default/GoogleService-Info.plist',
    dartOutput: 'lib/firebase_options.dart',
  ),
  FirebaseTarget(
    name: 'dev',
    androidAppId: '1:107577467292:android:e07ef0167a67daf106e859',
    iosAppId: '1:107577467292:ios:af2df46aff3df68506e859',
    androidOutput: 'android/app/src/dev/google-services.json',
    iosOutput: 'ios/firebase/dev/GoogleService-Info.plist',
    dartOutput: 'lib/firebase_options_dev.dart',
  ),
  FirebaseTarget(
    name: 'stg',
    androidAppId: '1:107577467292:android:99fa38c96f4496aa06e859',
    iosAppId: '1:107577467292:ios:b60af28764a55b0a06e859',
    androidOutput: 'android/app/src/stg/google-services.json',
    iosOutput: 'ios/firebase/stg/GoogleService-Info.plist',
    dartOutput: 'lib/firebase_options_stg.dart',
  ),
  FirebaseTarget(
    name: 'prd',
    androidAppId: '1:107577467292:android:fbc3e8fc5e706c0906e859',
    iosAppId: '1:107577467292:ios:db9fcaa9ded4130706e859',
    androidOutput: 'android/app/src/prd/google-services.json',
    iosOutput: 'ios/firebase/prd/GoogleService-Info.plist',
    dartOutput: 'lib/firebase_options_prd.dart',
  ),
];

Future<void> main() async {
  for (final target in targets) {
    print('Fetching Firebase config for ${target.name}...');
    final androidConfig = await fetchSdkConfig('ANDROID', target.androidAppId);
    final iosConfig = await fetchSdkConfig('IOS', target.iosAppId);

    writeFile(target.androidOutput, androidConfig);
    writeFile(target.iosOutput, iosConfig);
    writeFile(
      target.dartOutput,
      buildDartOptions(
        android: parseAndroidConfig(androidConfig, target.androidAppId),
        ios: parseIosConfig(iosConfig),
      ),
    );
  }
  print('Done.');
}

Future<String> fetchSdkConfig(String platform, String appId) async {
  final tempDir = await Directory.systemTemp.createTemp('firebase_sdkconfig');
  try {
    final outFile = File('${tempDir.path}/config');
    final result = await Process.run('firebase', [
      'apps:sdkconfig',
      platform,
      appId,
      '--project',
      projectId,
      '--out',
      outFile.path,
      '--non-interactive',
    ], runInShell: true);
    if (result.exitCode != 0 || !outFile.existsSync()) {
      stderr
        ..writeln('Failed to fetch $platform config for $appId')
        ..writeln(result.stdout)
        ..writeln(result.stderr);
      exit(1);
    }
    return outFile.readAsStringSync();
  } finally {
    await tempDir.delete(recursive: true);
  }
}

void writeFile(String relativePath, String content) {
  File('$appDir/$relativePath')
    ..createSync(recursive: true)
    ..writeAsStringSync(content);
}

Map<String, String> parseAndroidConfig(String json, String appId) {
  final config = jsonDecode(json) as Map<String, dynamic>;
  final projectInfo = config['project_info'] as Map<String, dynamic>;
  final clients = (config['client'] as List).cast<Map<String, dynamic>>();
  final client = clients.firstWhere(
    (c) => (c['client_info'] as Map)['mobilesdk_app_id'] == appId,
    orElse: () => throw StateError('$appId not found in google-services.json'),
  );
  final apiKey = ((client['api_key'] as List).first as Map)['current_key'];
  return {
    'apiKey': apiKey as String,
    'appId': appId,
    'messagingSenderId': projectInfo['project_number'] as String,
    'projectId': projectInfo['project_id'] as String,
    if (projectInfo['firebase_url'] case final String url) 'databaseURL': url,
    if (projectInfo['storage_bucket'] case final String bucket)
      'storageBucket': bucket,
  };
}

Map<String, String> parseIosConfig(String plist) {
  final values = <String, String>{
    for (final m in RegExp(
      r'<key>([^<]+)</key>\s*<string>([^<]*)</string>',
    ).allMatches(plist))
      m.group(1)!: m.group(2)!,
  };
  return {
    'apiKey': values['API_KEY']!,
    'appId': values['GOOGLE_APP_ID']!,
    'messagingSenderId': values['GCM_SENDER_ID']!,
    'projectId': values['PROJECT_ID']!,
    if (values['DATABASE_URL'] case final String url) 'databaseURL': url,
    if (values['STORAGE_BUCKET'] case final String bucket)
      'storageBucket': bucket,
    if (values['ANDROID_CLIENT_ID'] case final String id) 'androidClientId': id,
    if (values['CLIENT_ID'] case final String id) 'iosClientId': id,
    if (values['BUNDLE_ID'] case final String id) 'iosBundleId': id,
  };
}

String buildDartOptions({
  required Map<String, String> android,
  required Map<String, String> ios,
}) {
  String fields(Map<String, String> values) =>
      values.entries.map((e) => "    ${e.key}: '${e.value}',\n").join();

  String unsupported(String platform) =>
      '''
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for $platform.',
        );''';

  return '''
// File generated by scripts/fetch_firebase_config.dart. Do not edit.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
${unsupported('web').replaceAll('        ', '      ')}
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
${unsupported('this platform')}
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
${fields(android)}  );

  static const FirebaseOptions ios = FirebaseOptions(
${fields(ios)}  );
}
''';
}
