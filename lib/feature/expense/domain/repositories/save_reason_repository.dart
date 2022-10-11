import '../../domain/entities/entities.dart';

abstract class SaveReasonRepository {
  Future<bool> saveReason({required ReasonEntity reason});
}
