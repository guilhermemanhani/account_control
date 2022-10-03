class LocalEntity {
  final int id;
  final String local;
  LocalEntity({
    required this.id,
    required this.local,
  });

  @override
  bool operator ==(covariant LocalEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.local == local;
  }

  @override
  int get hashCode => id.hashCode ^ local.hashCode;
}
