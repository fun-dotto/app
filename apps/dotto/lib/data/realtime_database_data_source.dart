import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'realtime_database_data_source.g.dart';

@Riverpod(keepAlive: true)
FirebaseDatabase realtimeDatabaseClient(Ref ref) =>
    FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: 'https://swift2023groupc-default-rtdb.asia-southeast1.firebasedatabase.app',
    );
@riverpod
RealtimeDatabaseDataSource realtimeDatabaseDataSource(Ref ref) =>
    RealtimeDatabaseDataSource(ref.watch(realtimeDatabaseClientProvider));

final class RealtimeDatabaseDataSource {
  const new(this._database);
  final FirebaseDatabase _database;

  Future<DataSnapshot> getData(String path) async {
    return await _database.ref().child(path).get();
  }
}
