import 'package:account_control/feature/expense/domain/entities/reason_entity.dart';

abstract class ReasonRepository {
  Future<List<ReasonEntity>> getReason();
}
