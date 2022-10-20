import '../../domain/entities/entities.dart';

class ExpenseEntityMapper {
  static ExpenseEntity fromJson(Map<String, dynamic> json) {
    return ExpenseEntity(
      datahora: DateTime.parse(json['datahora']),
      descricao: json['descricao'],
      idconta: json['idconta'],
      idlancamento: json['idlancamento'],
      instituicao: json['instituicao'],
      local: json['local'],
      localid: json['localid'],
      motivo: json['motivo'],
      motivoid: json['motivoid'],
      tpagamento: json['tpagamento'],
      valor: json['valor'],
    );
  }
}
