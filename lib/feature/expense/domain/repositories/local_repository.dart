import '../../domain/entities/entities.dart';

abstract class LocalRepository {
  Future<List<LocalEntity>> getLocal();
}
