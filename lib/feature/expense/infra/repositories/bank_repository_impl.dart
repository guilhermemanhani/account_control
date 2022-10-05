import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';
import '../datasource/datasource.dart';

class BankRepositoryImpl implements BankRepository {
  final BankDatasource _bankDatasource;
  BankRepositoryImpl({
    required BankDatasource bankDatasource,
  }) : _bankDatasource = bankDatasource;
  @override
  Future<List<BankEntity>> getBank() async {
    try {
      return await _bankDatasource.getBank();
    } catch (e) {
      throw Exception(e);
    }
  }
}
