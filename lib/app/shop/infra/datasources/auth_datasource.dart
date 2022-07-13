import 'package:shop_clean_arch/app/shop/infra/models/auth_result_model.dart';

abstract class IAuthDataSource {
  Future<AuthResultModel> authWithEmail(String? email, String? password);
}
