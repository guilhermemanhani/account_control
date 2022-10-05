import '../../../../core/database/database.dart';
import '../../domain/entities/entities.dart';
import '../../external/mappers/mappers.dart';
import '../../infra/datasource/datasource.dart';

class ReasonDatasourceImpl implements ReasonDatasource {
  final SqliteConnectionFactory _sqliteConnectionFactory;
  ReasonDatasourceImpl(
      {required SqliteConnectionFactory sqliteConnectionFactory})
      : _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<List<ReasonEntity>> getReason() async {
    final conn = await _sqliteConnectionFactory.openConnection();
    final result = await conn.rawQuery('''
      select * from motivo
    ''');
    return result.map((e) => ReasonEntityMapper.fromJson(e)).toList();
  }
}
