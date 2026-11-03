// This is a generated file - do not edit.
//
// Generated from app/v1/subject.proto.

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

import 'faculty.pbjson.dart' as $0;

@$core.Deprecated('Use subjectSemesterDescriptor instead')
const SubjectSemester$json = {
  '1': 'SubjectSemester',
  '2': [
    {'1': 'SUBJECT_SEMESTER_UNSPECIFIED', '2': 0},
    {'1': 'SUBJECT_SEMESTER_ALL_YEAR', '2': 1},
    {'1': 'SUBJECT_SEMESTER_H1', '2': 2},
    {'1': 'SUBJECT_SEMESTER_H2', '2': 3},
    {'1': 'SUBJECT_SEMESTER_Q1', '2': 4},
    {'1': 'SUBJECT_SEMESTER_Q2', '2': 5},
    {'1': 'SUBJECT_SEMESTER_Q3', '2': 6},
    {'1': 'SUBJECT_SEMESTER_Q4', '2': 7},
    {'1': 'SUBJECT_SEMESTER_SUMMER_INTENSIVE', '2': 8},
    {'1': 'SUBJECT_SEMESTER_WINTER_INTENSIVE', '2': 9},
  ],
};

/// Descriptor for `SubjectSemester`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List subjectSemesterDescriptor = $convert.base64Decode(
    'Cg9TdWJqZWN0U2VtZXN0ZXISIAocU1VCSkVDVF9TRU1FU1RFUl9VTlNQRUNJRklFRBAAEh0KGV'
    'NVQkpFQ1RfU0VNRVNURVJfQUxMX1lFQVIQARIXChNTVUJKRUNUX1NFTUVTVEVSX0gxEAISFwoT'
    'U1VCSkVDVF9TRU1FU1RFUl9IMhADEhcKE1NVQkpFQ1RfU0VNRVNURVJfUTEQBBIXChNTVUJKRU'
    'NUX1NFTUVTVEVSX1EyEAUSFwoTU1VCSkVDVF9TRU1FU1RFUl9RMxAGEhcKE1NVQkpFQ1RfU0VN'
    'RVNURVJfUTQQBxIlCiFTVUJKRUNUX1NFTUVTVEVSX1NVTU1FUl9JTlRFTlNJVkUQCBIlCiFTVU'
    'JKRUNUX1NFTUVTVEVSX1dJTlRFUl9JTlRFTlNJVkUQCQ==');

@$core.Deprecated('Use subjectClassificationDescriptor instead')
const SubjectClassification$json = {
  '1': 'SubjectClassification',
  '2': [
    {'1': 'SUBJECT_CLASSIFICATION_UNSPECIFIED', '2': 0},
    {'1': 'SUBJECT_CLASSIFICATION_SPECIALIZED', '2': 1},
    {'1': 'SUBJECT_CLASSIFICATION_CULTURAL', '2': 2},
    {'1': 'SUBJECT_CLASSIFICATION_RESEARCH_INSTRUCTION', '2': 3},
  ],
};

/// Descriptor for `SubjectClassification`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List subjectClassificationDescriptor = $convert.base64Decode(
    'ChVTdWJqZWN0Q2xhc3NpZmljYXRpb24SJgoiU1VCSkVDVF9DTEFTU0lGSUNBVElPTl9VTlNQRU'
    'NJRklFRBAAEiYKIlNVQkpFQ1RfQ0xBU1NJRklDQVRJT05fU1BFQ0lBTElaRUQQARIjCh9TVUJK'
    'RUNUX0NMQVNTSUZJQ0FUSU9OX0NVTFRVUkFMEAISLworU1VCSkVDVF9DTEFTU0lGSUNBVElPTl'
    '9SRVNFQVJDSF9JTlNUUlVDVElPThAD');

@$core.Deprecated('Use subjectCulturalSubjectCategoryDescriptor instead')
const SubjectCulturalSubjectCategory$json = {
  '1': 'SubjectCulturalSubjectCategory',
  '2': [
    {'1': 'SUBJECT_CULTURAL_SUBJECT_CATEGORY_UNSPECIFIED', '2': 0},
    {'1': 'SUBJECT_CULTURAL_SUBJECT_CATEGORY_SOCIETY', '2': 1},
    {'1': 'SUBJECT_CULTURAL_SUBJECT_CATEGORY_HUMAN', '2': 2},
    {'1': 'SUBJECT_CULTURAL_SUBJECT_CATEGORY_SCIENCE', '2': 3},
    {'1': 'SUBJECT_CULTURAL_SUBJECT_CATEGORY_HEALTH', '2': 4},
    {'1': 'SUBJECT_CULTURAL_SUBJECT_CATEGORY_COMMUNICATION', '2': 5},
  ],
};

/// Descriptor for `SubjectCulturalSubjectCategory`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List subjectCulturalSubjectCategoryDescriptor = $convert.base64Decode(
    'Ch5TdWJqZWN0Q3VsdHVyYWxTdWJqZWN0Q2F0ZWdvcnkSMQotU1VCSkVDVF9DVUxUVVJBTF9TVU'
    'JKRUNUX0NBVEVHT1JZX1VOU1BFQ0lGSUVEEAASLQopU1VCSkVDVF9DVUxUVVJBTF9TVUJKRUNU'
    'X0NBVEVHT1JZX1NPQ0lFVFkQARIrCidTVUJKRUNUX0NVTFRVUkFMX1NVQkpFQ1RfQ0FURUdPUl'
    'lfSFVNQU4QAhItCilTVUJKRUNUX0NVTFRVUkFMX1NVQkpFQ1RfQ0FURUdPUllfU0NJRU5DRRAD'
    'EiwKKFNVQkpFQ1RfQ1VMVFVSQUxfU1VCSkVDVF9DQVRFR09SWV9IRUFMVEgQBBIzCi9TVUJKRU'
    'NUX0NVTFRVUkFMX1NVQkpFQ1RfQ0FURUdPUllfQ09NTVVOSUNBVElPThAF');

@$core.Deprecated('Use subjectRequirementTypeDescriptor instead')
const SubjectRequirementType$json = {
  '1': 'SubjectRequirementType',
  '2': [
    {'1': 'SUBJECT_REQUIREMENT_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'SUBJECT_REQUIREMENT_TYPE_REQUIRED', '2': 1},
    {'1': 'SUBJECT_REQUIREMENT_TYPE_OPTIONAL', '2': 2},
    {'1': 'SUBJECT_REQUIREMENT_TYPE_OPTIONAL_REQUIRED', '2': 3},
  ],
};

/// Descriptor for `SubjectRequirementType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List subjectRequirementTypeDescriptor = $convert.base64Decode(
    'ChZTdWJqZWN0UmVxdWlyZW1lbnRUeXBlEigKJFNVQkpFQ1RfUkVRVUlSRU1FTlRfVFlQRV9VTl'
    'NQRUNJRklFRBAAEiUKIVNVQkpFQ1RfUkVRVUlSRU1FTlRfVFlQRV9SRVFVSVJFRBABEiUKIVNV'
    'QkpFQ1RfUkVRVUlSRU1FTlRfVFlQRV9PUFRJT05BTBACEi4KKlNVQkpFQ1RfUkVRVUlSRU1FTl'
    'RfVFlQRV9PUFRJT05BTF9SRVFVSVJFRBAD');

@$core.Deprecated('Use subjectFacultyDescriptor instead')
const SubjectFaculty$json = {
  '1': 'SubjectFaculty',
  '2': [
    {
      '1': 'faculty',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.app.v1.Faculty',
      '8': {},
      '10': 'faculty'
    },
    {'1': 'is_primary', '3': 2, '4': 1, '5': 8, '8': {}, '10': 'isPrimary'},
  ],
};

/// Descriptor for `SubjectFaculty`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subjectFacultyDescriptor = $convert.base64Decode(
    'Cg5TdWJqZWN0RmFjdWx0eRIuCgdmYWN1bHR5GAEgASgLMg8uYXBwLnYxLkZhY3VsdHlCA+BBA1'
    'IHZmFjdWx0eRIiCgppc19wcmltYXJ5GAIgASgIQgPgQQNSCWlzUHJpbWFyeQ==');

@$core.Deprecated('Use subjectEligibleAttributeDescriptor instead')
const SubjectEligibleAttribute$json = {
  '1': 'SubjectEligibleAttribute',
  '2': [
    {
      '1': 'grade',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.app.v1.Grade',
      '8': {},
      '10': 'grade'
    },
    {
      '1': 'class',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.app.v1.Class',
      '8': {},
      '9': 0,
      '10': 'class',
      '17': true
    },
  ],
  '8': [
    {'1': '_class'},
  ],
};

/// Descriptor for `SubjectEligibleAttribute`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subjectEligibleAttributeDescriptor = $convert.base64Decode(
    'ChhTdWJqZWN0RWxpZ2libGVBdHRyaWJ1dGUSKAoFZ3JhZGUYASABKA4yDS5hcHAudjEuR3JhZG'
    'VCA+BBA1IFZ3JhZGUSLQoFY2xhc3MYAiABKA4yDS5hcHAudjEuQ2xhc3NCA+BBA0gAUgVjbGFz'
    'c4gBAUIICgZfY2xhc3M=');

@$core.Deprecated('Use subjectRequirementDescriptor instead')
const SubjectRequirement$json = {
  '1': 'SubjectRequirement',
  '2': [
    {
      '1': 'course',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.app.v1.Course',
      '8': {},
      '10': 'course'
    },
    {
      '1': 'requirement_type',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.app.v1.SubjectRequirementType',
      '8': {},
      '10': 'requirementType'
    },
  ],
};

/// Descriptor for `SubjectRequirement`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subjectRequirementDescriptor = $convert.base64Decode(
    'ChJTdWJqZWN0UmVxdWlyZW1lbnQSKwoGY291cnNlGAEgASgOMg4uYXBwLnYxLkNvdXJzZUID4E'
    'EDUgZjb3Vyc2USTgoQcmVxdWlyZW1lbnRfdHlwZRgCIAEoDjIeLmFwcC52MS5TdWJqZWN0UmVx'
    'dWlyZW1lbnRUeXBlQgPgQQNSD3JlcXVpcmVtZW50VHlwZQ==');

@$core.Deprecated('Use subjectSyllabusDescriptor instead')
const SubjectSyllabus$json = {
  '1': 'SubjectSyllabus',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'name'},
    {'1': 'en_name', '3': 3, '4': 1, '5': 9, '8': {}, '10': 'enName'},
    {'1': 'grades', '3': 4, '4': 1, '5': 9, '8': {}, '10': 'grades'},
    {'1': 'credit', '3': 5, '4': 1, '5': 5, '8': {}, '10': 'credit'},
    {
      '1': 'faculty_names',
      '3': 6,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'facultyNames'
    },
    {
      '1': 'practical_home_faculty_category',
      '3': 7,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'practicalHomeFacultyCategory'
    },
    {
      '1': 'multiple_person_teaching_form',
      '3': 8,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'multiplePersonTeachingForm'
    },
    {
      '1': 'teaching_form',
      '3': 9,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'teachingForm'
    },
    {'1': 'summary', '3': 10, '4': 1, '5': 9, '8': {}, '10': 'summary'},
    {
      '1': 'learning_outcomes',
      '3': 11,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'learningOutcomes'
    },
    {'1': 'assignments', '3': 12, '4': 1, '5': 9, '8': {}, '10': 'assignments'},
    {
      '1': 'evaluation_method',
      '3': 13,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'evaluationMethod'
    },
    {'1': 'textbooks', '3': 14, '4': 1, '5': 9, '8': {}, '10': 'textbooks'},
    {
      '1': 'reference_books',
      '3': 15,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'referenceBooks'
    },
    {
      '1': 'prerequisites',
      '3': 16,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'prerequisites'
    },
    {
      '1': 'pre_learning',
      '3': 17,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'preLearning'
    },
    {
      '1': 'post_learning',
      '3': 18,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'postLearning'
    },
    {'1': 'notes', '3': 19, '4': 1, '5': 9, '8': {}, '10': 'notes'},
    {'1': 'keywords', '3': 20, '4': 1, '5': 9, '8': {}, '10': 'keywords'},
    {
      '1': 'target_courses',
      '3': 21,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'targetCourses'
    },
    {
      '1': 'target_areas',
      '3': 22,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'targetAreas'
    },
    {
      '1': 'classifications',
      '3': 23,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'classifications'
    },
    {
      '1': 'teaching_language',
      '3': 24,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'teachingLanguage'
    },
    {
      '1': 'contents_and_schedule',
      '3': 25,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'contentsAndSchedule'
    },
    {
      '1': 'teaching_and_exam_form',
      '3': 26,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'teachingAndExamForm'
    },
    {
      '1': 'dsop_subject',
      '3': 27,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'dsopSubject'
    },
  ],
};

/// Descriptor for `SubjectSyllabus`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subjectSyllabusDescriptor = $convert.base64Decode(
    'Cg9TdWJqZWN0U3lsbGFidXMSEwoCaWQYASABKAlCA+BBA1ICaWQSFwoEbmFtZRgCIAEoCUID4E'
    'EDUgRuYW1lEhwKB2VuX25hbWUYAyABKAlCA+BBA1IGZW5OYW1lEhsKBmdyYWRlcxgEIAEoCUID'
    '4EEDUgZncmFkZXMSGwoGY3JlZGl0GAUgASgFQgPgQQNSBmNyZWRpdBIoCg1mYWN1bHR5X25hbW'
    'VzGAYgASgJQgPgQQNSDGZhY3VsdHlOYW1lcxJKCh9wcmFjdGljYWxfaG9tZV9mYWN1bHR5X2Nh'
    'dGVnb3J5GAcgASgJQgPgQQNSHHByYWN0aWNhbEhvbWVGYWN1bHR5Q2F0ZWdvcnkSRgodbXVsdG'
    'lwbGVfcGVyc29uX3RlYWNoaW5nX2Zvcm0YCCABKAlCA+BBA1IabXVsdGlwbGVQZXJzb25UZWFj'
    'aGluZ0Zvcm0SKAoNdGVhY2hpbmdfZm9ybRgJIAEoCUID4EEDUgx0ZWFjaGluZ0Zvcm0SHQoHc3'
    'VtbWFyeRgKIAEoCUID4EEDUgdzdW1tYXJ5EjAKEWxlYXJuaW5nX291dGNvbWVzGAsgASgJQgPg'
    'QQNSEGxlYXJuaW5nT3V0Y29tZXMSJQoLYXNzaWdubWVudHMYDCABKAlCA+BBA1ILYXNzaWdubW'
    'VudHMSMAoRZXZhbHVhdGlvbl9tZXRob2QYDSABKAlCA+BBA1IQZXZhbHVhdGlvbk1ldGhvZBIh'
    'Cgl0ZXh0Ym9va3MYDiABKAlCA+BBA1IJdGV4dGJvb2tzEiwKD3JlZmVyZW5jZV9ib29rcxgPIA'
    'EoCUID4EEDUg5yZWZlcmVuY2VCb29rcxIpCg1wcmVyZXF1aXNpdGVzGBAgASgJQgPgQQNSDXBy'
    'ZXJlcXVpc2l0ZXMSJgoMcHJlX2xlYXJuaW5nGBEgASgJQgPgQQNSC3ByZUxlYXJuaW5nEigKDX'
    'Bvc3RfbGVhcm5pbmcYEiABKAlCA+BBA1IMcG9zdExlYXJuaW5nEhkKBW5vdGVzGBMgASgJQgPg'
    'QQNSBW5vdGVzEh8KCGtleXdvcmRzGBQgASgJQgPgQQNSCGtleXdvcmRzEioKDnRhcmdldF9jb3'
    'Vyc2VzGBUgASgJQgPgQQNSDXRhcmdldENvdXJzZXMSJgoMdGFyZ2V0X2FyZWFzGBYgASgJQgPg'
    'QQNSC3RhcmdldEFyZWFzEi0KD2NsYXNzaWZpY2F0aW9ucxgXIAEoCUID4EEDUg9jbGFzc2lmaW'
    'NhdGlvbnMSMAoRdGVhY2hpbmdfbGFuZ3VhZ2UYGCABKAlCA+BBA1IQdGVhY2hpbmdMYW5ndWFn'
    'ZRI3ChVjb250ZW50c19hbmRfc2NoZWR1bGUYGSABKAlCA+BBA1ITY29udGVudHNBbmRTY2hlZH'
    'VsZRI4ChZ0ZWFjaGluZ19hbmRfZXhhbV9mb3JtGBogASgJQgPgQQNSE3RlYWNoaW5nQW5kRXhh'
    'bUZvcm0SJgoMZHNvcF9zdWJqZWN0GBsgASgJQgPgQQNSC2Rzb3BTdWJqZWN0');

@$core.Deprecated('Use subjectDescriptor instead')
const Subject$json = {
  '1': 'Subject',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'name'},
    {
      '1': 'faculties',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.app.v1.SubjectFaculty',
      '8': {},
      '10': 'faculties'
    },
    {'1': 'year', '3': 4, '4': 1, '5': 5, '8': {}, '10': 'year'},
    {
      '1': 'semester',
      '3': 5,
      '4': 1,
      '5': 14,
      '6': '.app.v1.SubjectSemester',
      '8': {},
      '10': 'semester'
    },
    {'1': 'credit', '3': 6, '4': 1, '5': 5, '8': {}, '10': 'credit'},
    {
      '1': 'eligible_attributes',
      '3': 7,
      '4': 3,
      '5': 11,
      '6': '.app.v1.SubjectEligibleAttribute',
      '8': {},
      '10': 'eligibleAttributes'
    },
    {
      '1': 'requirements',
      '3': 8,
      '4': 3,
      '5': 11,
      '6': '.app.v1.SubjectRequirement',
      '8': {},
      '10': 'requirements'
    },
    {
      '1': 'syllabus',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.app.v1.SubjectSyllabus',
      '8': {},
      '9': 0,
      '10': 'syllabus',
      '17': true
    },
  ],
  '8': [
    {'1': '_syllabus'},
  ],
};

/// Descriptor for `Subject`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subjectDescriptor = $convert.base64Decode(
    'CgdTdWJqZWN0EhMKAmlkGAEgASgJQgPgQQNSAmlkEhcKBG5hbWUYAiABKAlCA+BBA1IEbmFtZR'
    'I5CglmYWN1bHRpZXMYAyADKAsyFi5hcHAudjEuU3ViamVjdEZhY3VsdHlCA+BBA1IJZmFjdWx0'
    'aWVzEhcKBHllYXIYBCABKAVCA+BBA1IEeWVhchI4CghzZW1lc3RlchgFIAEoDjIXLmFwcC52MS'
    '5TdWJqZWN0U2VtZXN0ZXJCA+BBA1IIc2VtZXN0ZXISGwoGY3JlZGl0GAYgASgFQgPgQQNSBmNy'
    'ZWRpdBJWChNlbGlnaWJsZV9hdHRyaWJ1dGVzGAcgAygLMiAuYXBwLnYxLlN1YmplY3RFbGlnaW'
    'JsZUF0dHJpYnV0ZUID4EEDUhJlbGlnaWJsZUF0dHJpYnV0ZXMSQwoMcmVxdWlyZW1lbnRzGAgg'
    'AygLMhouYXBwLnYxLlN1YmplY3RSZXF1aXJlbWVudEID4EEDUgxyZXF1aXJlbWVudHMSPQoIc3'
    'lsbGFidXMYCSABKAsyFy5hcHAudjEuU3ViamVjdFN5bGxhYnVzQgPgQQNIAFIIc3lsbGFidXOI'
    'AQFCCwoJX3N5bGxhYnVz');

@$core.Deprecated('Use listSubjectsRequestDescriptor instead')
const ListSubjectsRequest$json = {
  '1': 'ListSubjectsRequest',
  '2': [
    {'1': 'query', '3': 3, '4': 1, '5': 9, '8': {}, '10': 'query'},
    {
      '1': 'grades',
      '3': 4,
      '4': 3,
      '5': 14,
      '6': '.app.v1.Grade',
      '8': {},
      '10': 'grades'
    },
    {
      '1': 'courses',
      '3': 5,
      '4': 3,
      '5': 14,
      '6': '.app.v1.Course',
      '8': {},
      '10': 'courses'
    },
    {
      '1': 'classes',
      '3': 6,
      '4': 3,
      '5': 14,
      '6': '.app.v1.Class',
      '8': {},
      '10': 'classes'
    },
    {
      '1': 'classifications',
      '3': 7,
      '4': 3,
      '5': 14,
      '6': '.app.v1.SubjectClassification',
      '8': {},
      '10': 'classifications'
    },
    {
      '1': 'semesters',
      '3': 8,
      '4': 3,
      '5': 14,
      '6': '.app.v1.SubjectSemester',
      '8': {},
      '10': 'semesters'
    },
    {
      '1': 'requirement_types',
      '3': 9,
      '4': 3,
      '5': 14,
      '6': '.app.v1.SubjectRequirementType',
      '8': {},
      '10': 'requirementTypes'
    },
    {
      '1': 'cultural_subject_categories',
      '3': 10,
      '4': 3,
      '5': 14,
      '6': '.app.v1.SubjectCulturalSubjectCategory',
      '8': {},
      '10': 'culturalSubjectCategories'
    },
  ],
  '9': [
    {'1': 1, '2': 2},
    {'1': 2, '2': 3},
  ],
  '10': ['page_size', 'page_token'],
};

/// Descriptor for `ListSubjectsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listSubjectsRequestDescriptor = $convert.base64Decode(
    'ChNMaXN0U3ViamVjdHNSZXF1ZXN0EhkKBXF1ZXJ5GAMgASgJQgPgQQFSBXF1ZXJ5EioKBmdyYW'
    'RlcxgEIAMoDjINLmFwcC52MS5HcmFkZUID4EEBUgZncmFkZXMSLQoHY291cnNlcxgFIAMoDjIO'
    'LmFwcC52MS5Db3Vyc2VCA+BBAVIHY291cnNlcxIsCgdjbGFzc2VzGAYgAygOMg0uYXBwLnYxLk'
    'NsYXNzQgPgQQFSB2NsYXNzZXMSTAoPY2xhc3NpZmljYXRpb25zGAcgAygOMh0uYXBwLnYxLlN1'
    'YmplY3RDbGFzc2lmaWNhdGlvbkID4EEBUg9jbGFzc2lmaWNhdGlvbnMSOgoJc2VtZXN0ZXJzGA'
    'ggAygOMhcuYXBwLnYxLlN1YmplY3RTZW1lc3RlckID4EEBUglzZW1lc3RlcnMSUAoRcmVxdWly'
    'ZW1lbnRfdHlwZXMYCSADKA4yHi5hcHAudjEuU3ViamVjdFJlcXVpcmVtZW50VHlwZUID4EEBUh'
    'ByZXF1aXJlbWVudFR5cGVzEmsKG2N1bHR1cmFsX3N1YmplY3RfY2F0ZWdvcmllcxgKIAMoDjIm'
    'LmFwcC52MS5TdWJqZWN0Q3VsdHVyYWxTdWJqZWN0Q2F0ZWdvcnlCA+BBAVIZY3VsdHVyYWxTdW'
    'JqZWN0Q2F0ZWdvcmllc0oECAEQAkoECAIQA1IJcGFnZV9zaXplUgpwYWdlX3Rva2Vu');

@$core.Deprecated('Use listSubjectsResponseDescriptor instead')
const ListSubjectsResponse$json = {
  '1': 'ListSubjectsResponse',
  '2': [
    {
      '1': 'subjects',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.app.v1.Subject',
      '10': 'subjects'
    },
  ],
  '9': [
    {'1': 2, '2': 3},
  ],
  '10': ['next_page_token'],
};

/// Descriptor for `ListSubjectsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listSubjectsResponseDescriptor = $convert.base64Decode(
    'ChRMaXN0U3ViamVjdHNSZXNwb25zZRIrCghzdWJqZWN0cxgBIAMoCzIPLmFwcC52MS5TdWJqZW'
    'N0UghzdWJqZWN0c0oECAIQA1IPbmV4dF9wYWdlX3Rva2Vu');

@$core.Deprecated('Use getSubjectRequestDescriptor instead')
const GetSubjectRequest$json = {
  '1': 'GetSubjectRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'id'},
  ],
};

/// Descriptor for `GetSubjectRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSubjectRequestDescriptor = $convert
    .base64Decode('ChFHZXRTdWJqZWN0UmVxdWVzdBITCgJpZBgBIAEoCUID4EECUgJpZA==');

@$core.Deprecated('Use getSubjectResponseDescriptor instead')
const GetSubjectResponse$json = {
  '1': 'GetSubjectResponse',
  '2': [
    {
      '1': 'subject',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.app.v1.Subject',
      '10': 'subject'
    },
  ],
};

/// Descriptor for `GetSubjectResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSubjectResponseDescriptor = $convert.base64Decode(
    'ChJHZXRTdWJqZWN0UmVzcG9uc2USKQoHc3ViamVjdBgBIAEoCzIPLmFwcC52MS5TdWJqZWN0Ug'
    'dzdWJqZWN0');

const $core.Map<$core.String, $core.dynamic> SubjectServiceBase$json = {
  '1': 'SubjectService',
  '2': [
    {
      '1': 'ListSubjects',
      '2': '.app.v1.ListSubjectsRequest',
      '3': '.app.v1.ListSubjectsResponse'
    },
    {
      '1': 'GetSubject',
      '2': '.app.v1.GetSubjectRequest',
      '3': '.app.v1.GetSubjectResponse'
    },
  ],
};

@$core.Deprecated('Use subjectServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    SubjectServiceBase$messageJson = {
  '.app.v1.ListSubjectsRequest': ListSubjectsRequest$json,
  '.app.v1.ListSubjectsResponse': ListSubjectsResponse$json,
  '.app.v1.Subject': Subject$json,
  '.app.v1.SubjectFaculty': SubjectFaculty$json,
  '.app.v1.Faculty': $0.Faculty$json,
  '.app.v1.SubjectEligibleAttribute': SubjectEligibleAttribute$json,
  '.app.v1.SubjectRequirement': SubjectRequirement$json,
  '.app.v1.SubjectSyllabus': SubjectSyllabus$json,
  '.app.v1.GetSubjectRequest': GetSubjectRequest$json,
  '.app.v1.GetSubjectResponse': GetSubjectResponse$json,
};

/// Descriptor for `SubjectService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List subjectServiceDescriptor = $convert.base64Decode(
    'Cg5TdWJqZWN0U2VydmljZRJJCgxMaXN0U3ViamVjdHMSGy5hcHAudjEuTGlzdFN1YmplY3RzUm'
    'VxdWVzdBocLmFwcC52MS5MaXN0U3ViamVjdHNSZXNwb25zZRJDCgpHZXRTdWJqZWN0EhkuYXBw'
    'LnYxLkdldFN1YmplY3RSZXF1ZXN0GhouYXBwLnYxLkdldFN1YmplY3RSZXNwb25zZQ==');
