import '../../domain/entities/entities.dart';

class AccountEntityMapper {
  static AccountEntity fromJson(Map<String, dynamic> json) {
    return AccountEntity(
      id: json['id'],
      conta: json['conta'],
      saldo: json['saldo'],
      idbanco: json['idbanco'],
      instituicao: json['instituicao'],
    );
  }
}
