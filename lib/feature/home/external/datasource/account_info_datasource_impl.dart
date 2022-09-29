import 'package:account_control/feature/home/domain/entities/account_info_entity.dart';
import 'package:account_control/feature/home/infra/datasource/account_info_datasource.dart';

class AccountInfoDatasourceImpl implements AccountInfoDatasource {
  // SqliteConnectionFactory _sqliteConnectionFactory;
  @override
  Future<List<AccountInfoEntity>> getAccountInfo() {
    // TODO: implement getMovies
    throw UnimplementedError();
  }
}
