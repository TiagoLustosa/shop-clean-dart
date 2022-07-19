import 'package:shop_clean_arch/app/shop/infra/models/auth_result_model.dart';
import '../../domain/entities/auth_credentials.dart';

abstract class IAuthDataSource {
  Future<AuthResultModel> authWithEmail(AuthCredentials credentials);
}
