import '../../domain/entities/entities.dart';

abstract class SaveLocalRepository {
  Future<bool> saveLocal({required LocalEntity local});
}
