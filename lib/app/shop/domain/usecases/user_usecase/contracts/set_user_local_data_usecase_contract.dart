import 'package:shop_clean_arch/app/shop/domain/entities/auth.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/base_usecase/base_usecase.dart';
import 'package:shop_clean_arch/app/shop/infra/models/auth_result_model.dart';

abstract class ISetUserLocalDataUsecaseContract
    implements UseCase<bool, AuthResultModel> {}
