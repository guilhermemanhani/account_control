import '../../domain/entities/entities.dart';

class ExpenseEntityMapper {
  static ExpenseEntity fromJson(Map<String, dynamic> json) {
    return ExpenseEntity(
      idlancamento: json['idlancamento'],
      datahora: DateTime.parse(json['datahora']),
      valor: json['valor'],
      descricao: json['descricao'],
      idconta: json['idconta'],
      localid: json['localid'],
      tpagamento: json['tpagamento'],
      motivoid: json['motivoid'],
      local: json['local'],
      instituicao: json['instituicao'],
      motivo: json['motivo'] ?? '',
    );
  }
}
