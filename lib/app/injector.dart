import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import 'injector.config.dart';

final injector = GetIt.instance;

@module
abstract class RegisterModule {
  @Named('BaseUrl')
  String get baseUrl => '-----';

  @singleton
  Dio dio(@Named('BaseUrl') String url, Logger logger) {
    final dio = Dio(BaseOptions(baseUrl: url));
    return dio;
  }

  @prod
  @dev
  @singleton
  Logger loggerProd() =>
      Logger(level: kDebugMode ? Level.debug : Level.warning);

  @test
  @singleton
  Logger loggerTest() => Logger(level: Level.debug);
}

@InjectableInit(
  preferRelativeImports: true,
  asExtension: false,
)
GetIt configureInjection([String environment = Environment.prod]) =>
    $initGetIt(injector, environment: environment);
