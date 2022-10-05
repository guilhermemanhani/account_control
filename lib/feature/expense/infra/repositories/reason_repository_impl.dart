import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';
import '../datasource/datasource.dart';

class ReasonRepositoryImpl implements ReasonRepository {
  final ReasonDatasource _reasonDatasource;
  ReasonRepositoryImpl({
    required ReasonDatasource reasonDatasource,
  }) : _reasonDatasource = reasonDatasource;
  @override
  Future<List<ReasonEntity>> getReason() async {
    try {
      return await _reasonDatasource.getReason();
    } catch (e) {
      throw Exception(e);
    }
  }
}
