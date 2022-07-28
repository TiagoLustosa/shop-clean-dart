import 'package:shop_clean_arch/app/shop/domain/entities/auth.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/base_usecase/base_usecase.dart';

abstract class IGetUserLocalDataUsecaseContract
    implements UseCase<Auth, NoParams> {}
