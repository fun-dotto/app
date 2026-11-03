// This is a generated file - do not edit.
//
// Generated from app/v1/menu_item.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../google/type/date.pb.dart' as $0;
import 'menu_item.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'menu_item.pbenum.dart';

/// サイズごとの価格。
class MenuItemPrice extends $pb.GeneratedMessage {
  factory MenuItemPrice({
    MenuItemSize? size,
    $core.int? price,
  }) {
    final result = MenuItemPrice._();
    if (size != null) result.size = size;
    if (price != null) result.price = price;
    return result;
  }

  MenuItemPrice._();

  factory MenuItemPrice.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MenuItemPrice()..mergeFromBuffer(data, registry);
  factory MenuItemPrice.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MenuItemPrice()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MenuItemPrice',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: MenuItemPrice.$_createMessage)
    ..aE<MenuItemSize>(1, _omitFieldNames ? '' : 'size',
        enumValues: MenuItemSize.values)
    ..aI(2, _omitFieldNames ? '' : 'price')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MenuItemPrice clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MenuItemPrice copyWith(void Function(MenuItemPrice) updates) =>
      super.copyWith((message) => updates(message as MenuItemPrice))
          as MenuItemPrice;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use MenuItemPrice() / MenuItemPrice.new instead')
  static MenuItemPrice create() => MenuItemPrice._();
  static $pb.GeneratedMessage $_createMessage() => MenuItemPrice._();
  @$core.override
  MenuItemPrice createEmptyInstance() => MenuItemPrice._();
  @$core.pragma('dart2js:noInline')
  static MenuItemPrice getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MenuItemPrice>(
          MenuItemPrice.$_createMessage);
  static MenuItemPrice? _defaultInstance;

  /// サイズ。
  @$pb.TagNumber(1)
  MenuItemSize get size => $_getN(0);
  @$pb.TagNumber(1)
  set size(MenuItemSize value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSize() => $_has(0);
  @$pb.TagNumber(1)
  void clearSize() => $_clearField(1);

  /// 価格（円）。
  @$pb.TagNumber(2)
  $core.int get price => $_getIZ(1);
  @$pb.TagNumber(2)
  set price($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPrice() => $_has(1);
  @$pb.TagNumber(2)
  void clearPrice() => $_clearField(2);
}

/// メニュー。
class MenuItem extends $pb.GeneratedMessage {
  factory MenuItem({
    $core.String? id,
    $0.Date? date,
    $core.String? name,
    $core.String? imageUrl,
    MenuItemCategory? category,
    $core.Iterable<MenuItemPrice>? prices,
  }) {
    final result = MenuItem._();
    if (id != null) result.id = id;
    if (date != null) result.date = date;
    if (name != null) result.name = name;
    if (imageUrl != null) result.imageUrl = imageUrl;
    if (category != null) result.category = category;
    if (prices != null) result.prices.addAll(prices);
    return result;
  }

  MenuItem._();

  factory MenuItem.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MenuItem()..mergeFromBuffer(data, registry);
  factory MenuItem.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MenuItem()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MenuItem',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: MenuItem.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOM<$0.Date>(2, _omitFieldNames ? '' : 'date',
        subBuilder: $0.Date.$_createMessage)
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..aOS(4, _omitFieldNames ? '' : 'imageUrl')
    ..aE<MenuItemCategory>(5, _omitFieldNames ? '' : 'category',
        enumValues: MenuItemCategory.values)
    ..pPM<MenuItemPrice>(6, _omitFieldNames ? '' : 'prices',
        subBuilder: MenuItemPrice.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MenuItem clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MenuItem copyWith(void Function(MenuItem) updates) =>
      super.copyWith((message) => updates(message as MenuItem)) as MenuItem;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use MenuItem() / MenuItem.new instead')
  static MenuItem create() => MenuItem._();
  static $pb.GeneratedMessage $_createMessage() => MenuItem._();
  @$core.override
  MenuItem createEmptyInstance() => MenuItem._();
  @$core.pragma('dart2js:noInline')
  static MenuItem getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MenuItem>(MenuItem.$_createMessage);
  static MenuItem? _defaultInstance;

  /// ID。
  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  /// 提供日。
  @$pb.TagNumber(2)
  $0.Date get date => $_getN(1);
  @$pb.TagNumber(2)
  set date($0.Date value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearDate() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.Date ensureDate() => $_ensure(1);

  /// メニュー名。
  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);

  /// 画像の URL。
  @$pb.TagNumber(4)
  $core.String get imageUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set imageUrl($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasImageUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearImageUrl() => $_clearField(4);

  /// カテゴリ。
  @$pb.TagNumber(5)
  MenuItemCategory get category => $_getN(4);
  @$pb.TagNumber(5)
  set category(MenuItemCategory value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasCategory() => $_has(4);
  @$pb.TagNumber(5)
  void clearCategory() => $_clearField(5);

  /// サイズごとの価格。
  @$pb.TagNumber(6)
  $pb.PbList<MenuItemPrice> get prices => $_getList(5);
}

/// ListMenuItems の Request。
class ListMenuItemsRequest extends $pb.GeneratedMessage {
  factory ListMenuItemsRequest({
    $0.Date? date,
  }) {
    final result = ListMenuItemsRequest._();
    if (date != null) result.date = date;
    return result;
  }

  ListMenuItemsRequest._();

  factory ListMenuItemsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListMenuItemsRequest()..mergeFromBuffer(data, registry);
  factory ListMenuItemsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListMenuItemsRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListMenuItemsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: ListMenuItemsRequest.$_createMessage)
    ..aOM<$0.Date>(3, _omitFieldNames ? '' : 'date',
        subBuilder: $0.Date.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListMenuItemsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListMenuItemsRequest copyWith(void Function(ListMenuItemsRequest) updates) =>
      super.copyWith((message) => updates(message as ListMenuItemsRequest))
          as ListMenuItemsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ListMenuItemsRequest() / ListMenuItemsRequest.new instead')
  static ListMenuItemsRequest create() => ListMenuItemsRequest._();
  static $pb.GeneratedMessage $_createMessage() => ListMenuItemsRequest._();
  @$core.override
  ListMenuItemsRequest createEmptyInstance() => ListMenuItemsRequest._();
  @$core.pragma('dart2js:noInline')
  static ListMenuItemsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListMenuItemsRequest>(
          ListMenuItemsRequest.$_createMessage);
  static ListMenuItemsRequest? _defaultInstance;

  /// メニューを取得する日付。
  @$pb.TagNumber(3)
  $0.Date get date => $_getN(0);
  @$pb.TagNumber(3)
  set date($0.Date value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasDate() => $_has(0);
  @$pb.TagNumber(3)
  void clearDate() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.Date ensureDate() => $_ensure(0);
}

/// ListMenuItems の Response。
class ListMenuItemsResponse extends $pb.GeneratedMessage {
  factory ListMenuItemsResponse({
    $core.Iterable<MenuItem>? menuItems,
  }) {
    final result = ListMenuItemsResponse._();
    if (menuItems != null) result.menuItems.addAll(menuItems);
    return result;
  }

  ListMenuItemsResponse._();

  factory ListMenuItemsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListMenuItemsResponse()..mergeFromBuffer(data, registry);
  factory ListMenuItemsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListMenuItemsResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListMenuItemsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: ListMenuItemsResponse.$_createMessage)
    ..pPM<MenuItem>(1, _omitFieldNames ? '' : 'menuItems',
        subBuilder: MenuItem.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListMenuItemsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListMenuItemsResponse copyWith(
          void Function(ListMenuItemsResponse) updates) =>
      super.copyWith((message) => updates(message as ListMenuItemsResponse))
          as ListMenuItemsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ListMenuItemsResponse() / ListMenuItemsResponse.new instead')
  static ListMenuItemsResponse create() => ListMenuItemsResponse._();
  static $pb.GeneratedMessage $_createMessage() => ListMenuItemsResponse._();
  @$core.override
  ListMenuItemsResponse createEmptyInstance() => ListMenuItemsResponse._();
  @$core.pragma('dart2js:noInline')
  static ListMenuItemsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListMenuItemsResponse>(
          ListMenuItemsResponse.$_createMessage);
  static ListMenuItemsResponse? _defaultInstance;

  /// メニューの一覧。
  @$pb.TagNumber(1)
  $pb.PbList<MenuItem> get menuItems => $_getList(0);
}

/// 学食のメニューを提供する。
class MenuItemServiceApi {
  final $pb.RpcClient _client;

  MenuItemServiceApi(this._client);

  /// メニューの一覧を取得する。
  $async.Future<ListMenuItemsResponse> listMenuItems(
          $pb.ClientContext? ctx, ListMenuItemsRequest request) =>
      _client.invoke<ListMenuItemsResponse>(ctx, 'MenuItemService',
          'ListMenuItems', request, ListMenuItemsResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
