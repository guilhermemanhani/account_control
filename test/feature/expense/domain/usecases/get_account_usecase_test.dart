import 'package:account_control/feature/expense/domain/entities/entities.dart';
import 'package:account_control/feature/expense/domain/repositories/repositories.dart';
import 'package:account_control/feature/expense/domain/usecases/usecases.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class AccountRepositoryMock extends Mock implements AccountRepository {}

void main() {
  late GetAccountUsecase usecase;
  late AccountRepository repository;

  setUp(() {
    repository = AccountRepositoryMock();
    usecase = GetAccountUsecaseImpl(accountRepository: repository);
  });

  test(
      'Deve retornar List<AccountEntity> quando a chamada para o repositório for sucedida',
      () async {
    //Arrange
    final response = <AccountEntity>[
      AccountEntity(
        conta: 1,
        saldo: 1000,
        id: 1,
        idbanco: 1,
        instituicao: "Banco do Brasil",
      ),
    ];

    when(() => repository.getAccount()).thenAnswer(
      (_) async => response,
    );

    //Act
    final result = await usecase.call();

    //Assert
    expect(result, response);
  });
}
