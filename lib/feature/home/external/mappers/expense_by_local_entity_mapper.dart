import '../../domain/entities/entities.dart';

class ExpenseByLocalEntityMapper {
  static ExpenseByLocalEntity fromJson(Map<String, dynamic> json) {
    return ExpenseByLocalEntity(
      contador: json['contador'],
      local: json['local'],
      soma: json['soma'],
      tpagamento: json['tpagamento'],
    );
  }
}
