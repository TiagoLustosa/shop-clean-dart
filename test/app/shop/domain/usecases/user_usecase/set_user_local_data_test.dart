import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/auth.dart';
import 'package:shop_clean_arch/app/shop/domain/repositories/user_data_repository.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/user_usecase/set_user_local_data_usecase.dart';
import 'package:shop_clean_arch/app/shop/infra/models/auth_result_model.dart';

class UserDataRepositoryMock extends Mock implements IUserDataRepository {}

main() {
  final userDataRepositoryMock = UserDataRepositoryMock();
  final setUserLocalDataUseCase =
      SetUserLocalDataUseCase(userDataRepositoryMock);

  setUp(() {
    registerFallbackValue(Auth());
  });

  test('should return true when user data is set', () async {
    when(() => userDataRepositoryMock.setUserLocalData(any()))
        .thenAnswer((_) async => Right(true));

    final result = await setUserLocalDataUseCase(AuthResultModel());
    final actual = result.fold(id, id);
    expect(result.isRight(), true);
    expect(actual, isA<bool>());
  });
}
