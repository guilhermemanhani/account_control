import '../../../../core/database/database.dart';
import '../../domain/entities/entities.dart';
import '../../external/mappers/mappers.dart';
import '../../infra/datasource/datasource.dart';

class LocalDatasourceImpl implements LocalDatasource {
  final SqliteConnectionFactory _sqliteConnectionFactory;

  LocalDatasourceImpl({
    required SqliteConnectionFactory sqliteConnectionFactory,
  }) : _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<List<LocalEntity>> getLocal() async {
    final conn = await _sqliteConnectionFactory.openConnection();
    final result = await conn.rawQuery(
      '''
      select * from local      
    ''',
    );
    return result.map((e) => LocalEntityMapper.fromJson(e)).toList();
  }
}
