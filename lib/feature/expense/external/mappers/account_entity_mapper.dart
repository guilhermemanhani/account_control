import 'package:account_control/feature/expense/domain/entities/account_entity.dart';

class AccountEntityMapper {
  static AccountEntity fromJson(Map<String, dynamic> json) {
    return AccountEntity(
      id: json['id'],
      conta: json['conta'],
      saldo: json['balance'],
      idbanco: json['currency'],
      instituicao: json['instituicao'],
    );
  }
}
