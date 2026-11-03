// This is a generated file - do not edit.
//
// Generated from app/v1/menu_item.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// メニューのカテゴリ。
class MenuItemCategory extends $pb.ProtobufEnum {
  /// 未指定。
  static const MenuItemCategory MENU_ITEM_CATEGORY_UNSPECIFIED =
      MenuItemCategory._(
          0, _omitEnumNames ? '' : 'MENU_ITEM_CATEGORY_UNSPECIFIED');

  /// 定食・単品。
  static const MenuItemCategory MENU_ITEM_CATEGORY_SET_AND_SINGLE =
      MenuItemCategory._(
          1, _omitEnumNames ? '' : 'MENU_ITEM_CATEGORY_SET_AND_SINGLE');

  /// 丼・カレー。
  static const MenuItemCategory MENU_ITEM_CATEGORY_BOWL_AND_CURRY =
      MenuItemCategory._(
          2, _omitEnumNames ? '' : 'MENU_ITEM_CATEGORY_BOWL_AND_CURRY');

  /// 麺類。
  static const MenuItemCategory MENU_ITEM_CATEGORY_NOODLE =
      MenuItemCategory._(3, _omitEnumNames ? '' : 'MENU_ITEM_CATEGORY_NOODLE');

  /// サイドメニュー。
  static const MenuItemCategory MENU_ITEM_CATEGORY_SIDE =
      MenuItemCategory._(4, _omitEnumNames ? '' : 'MENU_ITEM_CATEGORY_SIDE');

  /// デザート。
  static const MenuItemCategory MENU_ITEM_CATEGORY_DESSERT =
      MenuItemCategory._(5, _omitEnumNames ? '' : 'MENU_ITEM_CATEGORY_DESSERT');

  static const $core.List<MenuItemCategory> values = <MenuItemCategory>[
    MENU_ITEM_CATEGORY_UNSPECIFIED,
    MENU_ITEM_CATEGORY_SET_AND_SINGLE,
    MENU_ITEM_CATEGORY_BOWL_AND_CURRY,
    MENU_ITEM_CATEGORY_NOODLE,
    MENU_ITEM_CATEGORY_SIDE,
    MENU_ITEM_CATEGORY_DESSERT,
  ];

  static final $core.List<MenuItemCategory?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 5);
  static MenuItemCategory? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const MenuItemCategory._(super.value, super.name);
}

/// メニューのサイズ。
class MenuItemSize extends $pb.ProtobufEnum {
  /// 未指定。
  static const MenuItemSize MENU_ITEM_SIZE_UNSPECIFIED =
      MenuItemSize._(0, _omitEnumNames ? '' : 'MENU_ITEM_SIZE_UNSPECIFIED');

  /// 小。
  static const MenuItemSize MENU_ITEM_SIZE_SMALL =
      MenuItemSize._(1, _omitEnumNames ? '' : 'MENU_ITEM_SIZE_SMALL');

  /// 中。
  static const MenuItemSize MENU_ITEM_SIZE_MEDIUM =
      MenuItemSize._(2, _omitEnumNames ? '' : 'MENU_ITEM_SIZE_MEDIUM');

  /// 大。
  static const MenuItemSize MENU_ITEM_SIZE_LARGE =
      MenuItemSize._(3, _omitEnumNames ? '' : 'MENU_ITEM_SIZE_LARGE');

  static const $core.List<MenuItemSize> values = <MenuItemSize>[
    MENU_ITEM_SIZE_UNSPECIFIED,
    MENU_ITEM_SIZE_SMALL,
    MENU_ITEM_SIZE_MEDIUM,
    MENU_ITEM_SIZE_LARGE,
  ];

  static final $core.List<MenuItemSize?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static MenuItemSize? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const MenuItemSize._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
