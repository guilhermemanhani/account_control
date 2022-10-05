import '../../domain/entities/entities.dart';

abstract class LocalDatasource {
  Future<List<LocalEntity>> getLocal();
}
