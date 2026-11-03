// This is a generated file - do not edit.
//
// Generated from app/v1/common.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use gradeDescriptor instead')
const Grade$json = {
  '1': 'Grade',
  '2': [
    {'1': 'GRADE_UNSPECIFIED', '2': 0},
    {'1': 'GRADE_B1', '2': 1},
    {'1': 'GRADE_B2', '2': 2},
    {'1': 'GRADE_B3', '2': 3},
    {'1': 'GRADE_B4', '2': 4},
    {'1': 'GRADE_M1', '2': 5},
    {'1': 'GRADE_M2', '2': 6},
    {'1': 'GRADE_D1', '2': 7},
    {'1': 'GRADE_D2', '2': 8},
    {'1': 'GRADE_D3', '2': 9},
  ],
};

/// Descriptor for `Grade`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List gradeDescriptor = $convert.base64Decode(
    'CgVHcmFkZRIVChFHUkFERV9VTlNQRUNJRklFRBAAEgwKCEdSQURFX0IxEAESDAoIR1JBREVfQj'
    'IQAhIMCghHUkFERV9CMxADEgwKCEdSQURFX0I0EAQSDAoIR1JBREVfTTEQBRIMCghHUkFERV9N'
    'MhAGEgwKCEdSQURFX0QxEAcSDAoIR1JBREVfRDIQCBIMCghHUkFERV9EMxAJ');

@$core.Deprecated('Use courseDescriptor instead')
const Course$json = {
  '1': 'Course',
  '2': [
    {'1': 'COURSE_UNSPECIFIED', '2': 0},
    {'1': 'COURSE_INFORMATION_SYSTEM', '2': 1},
    {'1': 'COURSE_INFORMATION_DESIGN', '2': 2},
    {'1': 'COURSE_ADVANCED_ICT', '2': 3},
    {'1': 'COURSE_COMPLEX_SYSTEM', '2': 4},
    {'1': 'COURSE_INTELLIGENT_SYSTEM', '2': 5},
  ],
};

/// Descriptor for `Course`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List courseDescriptor = $convert.base64Decode(
    'CgZDb3Vyc2USFgoSQ09VUlNFX1VOU1BFQ0lGSUVEEAASHQoZQ09VUlNFX0lORk9STUFUSU9OX1'
    'NZU1RFTRABEh0KGUNPVVJTRV9JTkZPUk1BVElPTl9ERVNJR04QAhIXChNDT1VSU0VfQURWQU5D'
    'RURfSUNUEAMSGQoVQ09VUlNFX0NPTVBMRVhfU1lTVEVNEAQSHQoZQ09VUlNFX0lOVEVMTElHRU'
    '5UX1NZU1RFTRAF');

@$core.Deprecated('Use classDescriptor instead')
const Class$json = {
  '1': 'Class',
  '2': [
    {'1': 'CLASS_UNSPECIFIED', '2': 0},
    {'1': 'CLASS_A', '2': 1},
    {'1': 'CLASS_B', '2': 2},
    {'1': 'CLASS_C', '2': 3},
    {'1': 'CLASS_D', '2': 4},
    {'1': 'CLASS_E', '2': 5},
    {'1': 'CLASS_F', '2': 6},
    {'1': 'CLASS_G', '2': 7},
    {'1': 'CLASS_H', '2': 8},
    {'1': 'CLASS_I', '2': 9},
    {'1': 'CLASS_J', '2': 10},
    {'1': 'CLASS_K', '2': 11},
    {'1': 'CLASS_L', '2': 12},
  ],
};

/// Descriptor for `Class`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List classDescriptor = $convert.base64Decode(
    'CgVDbGFzcxIVChFDTEFTU19VTlNQRUNJRklFRBAAEgsKB0NMQVNTX0EQARILCgdDTEFTU19CEA'
    'ISCwoHQ0xBU1NfQxADEgsKB0NMQVNTX0QQBBILCgdDTEFTU19FEAUSCwoHQ0xBU1NfRhAGEgsK'
    'B0NMQVNTX0cQBxILCgdDTEFTU19IEAgSCwoHQ0xBU1NfSRAJEgsKB0NMQVNTX0oQChILCgdDTE'
    'FTU19LEAsSCwoHQ0xBU1NfTBAM');

@$core.Deprecated('Use periodDescriptor instead')
const Period$json = {
  '1': 'Period',
  '2': [
    {'1': 'PERIOD_UNSPECIFIED', '2': 0},
    {'1': 'PERIOD_1', '2': 1},
    {'1': 'PERIOD_2', '2': 2},
    {'1': 'PERIOD_3', '2': 3},
    {'1': 'PERIOD_4', '2': 4},
    {'1': 'PERIOD_5', '2': 5},
    {'1': 'PERIOD_6', '2': 6},
  ],
};

/// Descriptor for `Period`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List periodDescriptor = $convert.base64Decode(
    'CgZQZXJpb2QSFgoSUEVSSU9EX1VOU1BFQ0lGSUVEEAASDAoIUEVSSU9EXzEQARIMCghQRVJJT0'
    'RfMhACEgwKCFBFUklPRF8zEAMSDAoIUEVSSU9EXzQQBBIMCghQRVJJT0RfNRAFEgwKCFBFUklP'
    'RF82EAY=');
