import 'package:account_control/core/database/migration/migration.dart';
import 'package:sqflite_common/sqlite_api.dart';

class MigrationV2 implements Migration {
  @override
  void create(Batch batch) {
    // batch.execute('''
    // create table teste(id integer)
    // ''');
  }

  @override
  void update(Batch batch) {
    // batch.execute('''
    // create table teste(id integer)
    // ''');
  }
}
