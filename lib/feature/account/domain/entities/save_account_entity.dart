class SaveAccountEntity {
  final int id;
  final int conta;
  final double saldo;
  final int idbanco;

  SaveAccountEntity({
    required this.id,
    required this.conta,
    required this.saldo,
    required this.idbanco,
  });

  @override
  bool operator ==(covariant SaveAccountEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.conta == conta &&
        other.saldo == saldo &&
        other.idbanco == idbanco;
  }

  @override
  int get hashCode {
    return id.hashCode ^ conta.hashCode ^ saldo.hashCode ^ idbanco.hashCode;
  }
}
