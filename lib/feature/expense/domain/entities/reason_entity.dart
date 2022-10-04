class ReasonEntity {
  final int id;
  final String motivo;
  ReasonEntity({
    required this.id,
    required this.motivo,
  });

  @override
  bool operator ==(covariant ReasonEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.motivo == motivo;
  }

  @override
  int get hashCode => id.hashCode ^ motivo.hashCode;
}
