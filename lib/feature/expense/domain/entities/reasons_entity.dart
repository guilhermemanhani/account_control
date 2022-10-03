class ReasonsEntity {
  final int id;
  final String motivo;
  ReasonsEntity({
    required this.id,
    required this.motivo,
  });

  @override
  bool operator ==(covariant ReasonsEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.motivo == motivo;
  }

  @override
  int get hashCode => id.hashCode ^ motivo.hashCode;
}
