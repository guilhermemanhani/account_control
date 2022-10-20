import '../../domain/entities/entities.dart';

abstract class AccountInfoDatasource {
  Future<List<AccountInfoEntity>> getAccountInfo();
}
