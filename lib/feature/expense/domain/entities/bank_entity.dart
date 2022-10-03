class BankEntity {
  final int id;
  final String instituicao;

  BankEntity({
    required this.id,
    required this.instituicao,
  });

  @override
  bool operator ==(covariant BankEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.instituicao == instituicao;
  }

  @override
  int get hashCode => id.hashCode ^ instituicao.hashCode;
}
