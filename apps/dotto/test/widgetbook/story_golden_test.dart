@Tags(['golden'])
library;

import 'dart:io';

import 'package:dotto_design_system/style/theme.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgetbook/main.directories.g.dart';
import '../../widgetbook/story_app_builder.dart';

/// VRT で撮影する端末。
///
/// 折りたたみ端末は、内側と外側でディスプレイの縦横比が大きく異なる場合、両方を撮影する。
enum _Device {
  iPhone18Pro('iphone_18_pro', Size(1206, 2622), 3),
  // 内側ディスプレイは物理解像度 (1878 × 2670) がポイントの整数倍にならないため、
  // Simulator の描画解像度を用いる。
  iPhoneDuoInner('iphone_duo_inner', Size(2853, 2007), 3),
  iPhoneDuoOuter('iphone_duo_outer', Size(1398, 2034), 3),
  iPadPro11M5('ipad_pro_11_m5', Size(1668, 2420), 2),
  pixel11Pro('pixel_11_pro', Size(1280, 2856), 3.125),
  pixelFoldInner('pixel_fold_inner', Size(2208, 1840), 2.625),
  pixelFoldOuter('pixel_fold_outer', Size(1080, 2092), 2.625);

  new(this.id, this.physicalSize, this.devicePixelRatio);

  final String id;
  final Size physicalSize;
  final double devicePixelRatio;
}

void main() {
  for (final useCase in _collectUseCases(directories)) {
    for (final device in _Device.values) {
      _testStory(useCase, device);
    }
  }
}

void _testStory(WidgetbookUseCase useCase, _Device device) {
  testWidgets(
    '${device.id} で ${_goldenPath(useCase)} の見た目が変わっていない',
    // フォントのラスタライズが OS ごとに異なるため、基準画像は Linux でのみ比較・更新する。
    skip: !Platform.isLinux,
    (tester) async {
      tester.view
        ..physicalSize = device.physicalSize
        ..devicePixelRatio = device.devicePixelRatio;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        Builder(
          builder: (context) => storyAppBuilder(
            context,
            Theme(
              data: DottoTheme.v2,
              child: Builder(builder: useCase.builder),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/${device.id}/${_goldenPath(useCase)}.png'),
      );
    },
  );
}

Iterable<WidgetbookUseCase> _collectUseCases(List<WidgetbookNode> nodes) sync* {
  for (final node in nodes) {
    switch (node) {
      case final WidgetbookUseCase useCase:
        yield useCase;
      case WidgetbookNode(:final children?):
        yield* _collectUseCases(children);
      case _:
        break;
    }
  }
}

// WidgetbookNode.path はルート直下の区切りを除去してしまう
// (presentation/common が presentationcommon になる) ため、自前で組み立てる。
String _goldenPath(WidgetbookUseCase useCase) => useCase.nodesPath
    .map((node) => node.name.replaceAll(' ', '-').toLowerCase())
    .join('/');
