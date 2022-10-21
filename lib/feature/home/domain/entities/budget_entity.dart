// ignore_for_file: public_member_api_docs, sort_constructors_first

class BudgetEntity {
  final double entryD;
  final double exitD;
  final String entry;
  final String exit;
  final String budgetUse;
  final String entryxsaida;

  const BudgetEntity({
    required this.entryD,
    required this.exitD,
    required this.entry,
    required this.exit,
    required this.budgetUse,
    required this.entryxsaida,
  });

  @override
  bool operator ==(covariant BudgetEntity other) {
    if (identical(this, other)) return true;

    return other.entryD == entryD &&
        other.exitD == exitD &&
        other.entry == entry &&
        other.exit == exit &&
        other.budgetUse == budgetUse &&
        other.entryxsaida == entryxsaida;
  }

  @override
  int get hashCode {
    return entryD.hashCode ^
        exitD.hashCode ^
        entry.hashCode ^
        exit.hashCode ^
        budgetUse.hashCode ^
        entryxsaida.hashCode;
  }
}
