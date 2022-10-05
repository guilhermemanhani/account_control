import '../../domain/entities/entities.dart';

abstract class ReasonDatasource {
  Future<List<ReasonEntity>> getReason();
}
