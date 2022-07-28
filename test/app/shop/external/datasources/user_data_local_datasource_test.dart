import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/auth.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/user_data_exceptions.dart';
import 'package:shop_clean_arch/app/shop/external/datasources/user_data_local_datasource.dart';
import 'package:shop_clean_arch/app/shop/infra/models/auth_result_model.dart';

class SharedPreferencesMock extends Mock implements SharedPreferences {}

main() {
  final sharedPreferencesMock = SharedPreferencesMock();
  final userDataLocalDataSource =
      UserDataLocalDataSource(sharedPreferencesMock);

  test('should return an auth entity', () async {
    when(() => sharedPreferencesMock.getString('userData'))
        .thenAnswer((_) => '{}');
    final result = await userDataLocalDataSource.getUserLocalData();
    expect(result, isA<AuthResultModel>());
  });
  //aprender a testar o erro
  // test('should throw an exception', () async {
  //   when(() => sharedPreferencesMock.getString('userData'))
  //       .thenThrow(UserDataNotFoundException('User data not found'));
  //   final result = await userDataLocalDataSource.getUserLocalData();
  //   //  expect(result, isA<UserDataNotFoundException>());
  // });
}
