import '../../domain/entities/entities.dart';

class ReasonEntityMapper {
  static ReasonEntity fromJson(Map<String, dynamic> json) {
    return ReasonEntity(
      id: json['id'],
      motivo: json['motivo'],
    );
  }
}
