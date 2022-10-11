import '../../domain/entities/entities.dart';

abstract class SaveLocalDatasource {
  Future<bool> saveLocal({required LocalEntity local});
}
