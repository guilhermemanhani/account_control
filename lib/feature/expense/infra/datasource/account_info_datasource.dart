import 'package:account_control/feature/home/domain/entities/account_info_entity.dart';

abstract class AccountInfoDatasource {
  Future<List<AccountInfoEntity>> getAccountInfo();
}
