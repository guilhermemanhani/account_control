import '../../domain/entities/entities.dart';

abstract class SaveReasonDatasource {
  Future<bool> saveReason({required ReasonEntity reason});
}
