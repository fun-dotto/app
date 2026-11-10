import 'dart:io';

import 'package:dotto/domain/entity/occlusion_region.dart';
import 'package:dotto/domain/entity/screen_layout.dart';
import 'package:dotto/domain/entity/vertical_bar_edge.dart';
import 'package:dotto/domain/repository/screen_layout_repository.dart';
import 'package:dotto/foundation/log/logger.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'screen_layout_repository_impl.g.dart';

/// iOS 側 (`AppDelegate.swift`) と対応するチャンネル名。
const screenLayoutChannelName = 'jp.ac.fun.dotto/screen_layout';

@riverpod
MethodChannel screenLayoutChannel(Ref ref) =>
    const MethodChannel(screenLayoutChannelName);

@riverpod
ScreenLayoutRepository screenLayoutRepository(Ref ref) =>
    ScreenLayoutRepositoryImpl(
      ref.watch(screenLayoutChannelProvider),
      ref.watch(loggerProvider),
    );

final class ScreenLayoutRepositoryImpl implements ScreenLayoutRepository {
  const new(this._channel, this._logger);

  final MethodChannel _channel;
  final Logger _logger;

  @override
  Future<ScreenLayout> fetch() async {
    // 縦型バーを置く端末は iOS のみ。
    if (!Platform.isIOS) return ScreenLayout.standard;
    try {
      final result = await _channel.invokeMapMethod<String, Object?>(
        'getScreenLayout',
      );
      if (result == null) return ScreenLayout.standard;
      return _toScreenLayout(result);
    } on PlatformException catch (error, stackTrace) {
      // 取得できなくても下部タブで使えるため、記録して通常配置に戻す。
      await _logger.logError(error, stackTrace, reason: '画面レイアウトの取得に失敗');
      return ScreenLayout.standard;
    }
  }

  ScreenLayout _toScreenLayout(Map<String, Object?> map) {
    final edge = switch (map['verticalBarEdge']) {
      'leading' => VerticalBarEdge.leading,
      'trailing' => VerticalBarEdge.trailing,
      _ => null,
    };
    final occlusions = switch (map['occlusions']) {
      final List<Object?> list => list.whereType<Map<Object?, Object?>>().map(
        (region) => OcclusionRegion(
          left: _toDouble(region['x']),
          top: _toDouble(region['y']),
          width: _toDouble(region['width']),
          height: _toDouble(region['height']),
        ),
      ),
      _ => const <OcclusionRegion>[],
    };
    return ScreenLayout(
      verticalBarEdge: edge,
      occlusions: List.unmodifiable(occlusions),
      isPartialWindow: map['isPartialWindow'] == true,
    );
  }

  double _toDouble(Object? value) => value is num ? value.toDouble() : 0;
}
