import 'package:account_control/feature/expense/domain/entities/local_entity.dart';

abstract class LocalRepository {
  Future<List<LocalEntity>> getLocal();
}
