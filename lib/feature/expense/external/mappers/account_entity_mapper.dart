import '../../domain/entities/entities.dart';

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
