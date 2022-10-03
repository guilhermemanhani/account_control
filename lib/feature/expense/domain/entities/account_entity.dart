class AccountEntity {
  final int id;
  final int conta;
  final double saldo;
  final int idbanco;
  final String? instituicao;

  AccountEntity({
    required this.id,
    required this.conta,
    required this.saldo,
    required this.idbanco,
    this.instituicao,
  });

  @override
  bool operator ==(covariant AccountEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.conta == conta &&
        other.saldo == saldo &&
        other.idbanco == idbanco &&
        other.instituicao == instituicao;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        conta.hashCode ^
        saldo.hashCode ^
        idbanco.hashCode ^
        instituicao.hashCode;
  }
}
