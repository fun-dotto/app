import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences_data_source.g.dart';

@riverpod
Future<SharedPreferences> sharedPreferencesDataSource(Ref ref) =>
    SharedPreferences.getInstance();
