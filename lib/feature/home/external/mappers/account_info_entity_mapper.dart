import '../../domain/entities/entities.dart';

class AccountInfoEntityMapper {
  static AccountInfoEntity fromJson(Map<String, dynamic> json) {
    return AccountInfoEntity(
      id: json['id'],
      conta: json['conta'],
      saldo: json['saldo'],
      idbanco: json['idbanco'],
      instituicao: json['instituicao'],
    );
  }
}
