// ignore_for_file: public_member_api_docs, sort_constructors_first

class ExpenseEntity {
  final int idlancamento;
  final double valor;
  final DateTime datahora;
  final String descricao;
  final int idconta;
  final int localid;
  final int tpagamento;
  final int motivoid;
  final String local;
  final String motivo;
  final String instituicao;

  ExpenseEntity({
    required this.idlancamento,
    required this.valor,
    required this.datahora,
    required this.descricao,
    required this.idconta,
    required this.localid,
    required this.tpagamento,
    required this.motivoid,
    required this.local,
    required this.motivo,
    required this.instituicao,
  });

  @override
  bool operator ==(covariant ExpenseEntity other) {
    if (identical(this, other)) return true;

    return other.idlancamento == idlancamento &&
        other.valor == valor &&
        other.datahora == datahora &&
        other.descricao == descricao &&
        other.idconta == idconta &&
        other.localid == localid &&
        other.tpagamento == tpagamento &&
        other.motivoid == motivoid &&
        other.local == local &&
        other.motivo == motivo &&
        other.instituicao == instituicao;
  }

  @override
  int get hashCode {
    return idlancamento.hashCode ^
        valor.hashCode ^
        datahora.hashCode ^
        descricao.hashCode ^
        idconta.hashCode ^
        localid.hashCode ^
        tpagamento.hashCode ^
        motivoid.hashCode ^
        local.hashCode ^
        motivo.hashCode ^
        instituicao.hashCode;
  }
}
