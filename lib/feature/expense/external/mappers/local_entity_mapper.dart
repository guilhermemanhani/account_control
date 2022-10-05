import '../../domain/entities/entities.dart';

class LocalEntityMapper {
  static LocalEntity fromJson(Map<String, dynamic> json) {
    return LocalEntity(
      id: json['id'],
      local: json['local'],
    );
  }
}
