import 'package:account_control/feature/expense/domain/entities/account_entity.dart';
import 'package:account_control/feature/expense/external/mappers/account_entity_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('fromMap', () {
    test(
        '''Deve retornar um MovieEntity com o parâmetro posterImageUrl = map["poster_path"] concatenada com url base do IMDB,
         convertendo o Map<String, dynamic> com todos os campos não nulos''',
        () {
      //Arrange
      final map = {
        'id': 1,
        'conta': 3,
        'saldo': 1000.0,
        'idbanco': 2,
        'instituicao': 'teste',
      };

      //Act
      final result = AccountEntityMapper.fromJson(map);

      //Assert
      expect(
        result,
        AccountEntity(
          id: 1,
          conta: 3,
          saldo: 1000.0,
          idbanco: 2,
          instituicao: "teste",
        ),
      );
    });

    test(
        '''Deve retornar um AccountEntity com o parâmetro posterImageUrl = map["poster_path"] concatenada com url base do IMDB,
         convertendo o Map<String, dynamic> com a chave "instituicao" igual a vazia''',
        () {
      //Arrange
      final map = {
        'id': 1,
        'conta': 3,
        'saldo': 1000.0,
        'idbanco': 2,
        'instituicao': '',
      };

      //Act
      final result = AccountEntityMapper.fromJson(map);

      //Assert
      expect(
        result,
        AccountEntity(
          id: 1,
          conta: 3,
          saldo: 1000.0,
          idbanco: 2,
          instituicao: "",
        ),
      );
    });

    // todo testar com double
    // todo testar com null
  });
}
