import '../../domain/entities/entities.dart';

abstract class ReasonRepository {
  Future<List<ReasonEntity>> getReason();
}
