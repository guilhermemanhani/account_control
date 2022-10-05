import '../../domain/entities/entities.dart';

class BankEntityMapper {
  static BankEntity fromJson(Map<String, dynamic> json) {
    return BankEntity(
      id: json['id'],
      instituicao: json['instituicao'],
    );
  }
}
