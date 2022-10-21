// ignore_for_file: public_member_api_docs, sort_constructors_first
class ExpenseByLocalEntity {
  final int contador;
  final double soma;
  final int tpagamento;
  final String local;
  ExpenseByLocalEntity({
    required this.contador,
    required this.soma,
    required this.tpagamento,
    required this.local,
  });

  @override
  bool operator ==(covariant ExpenseByLocalEntity other) {
    if (identical(this, other)) return true;

    return other.contador == contador &&
        other.soma == soma &&
        other.tpagamento == tpagamento &&
        other.local == local;
  }

  @override
  int get hashCode {
    return contador.hashCode ^
        soma.hashCode ^
        tpagamento.hashCode ^
        local.hashCode;
  }
}
