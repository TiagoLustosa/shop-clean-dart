import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_clean_arch/app/shop/infra/dependency_injection/dependency_injection_config.dart';
import 'package:shop_clean_arch/app/shop/presenter/components/auth_form.dart';

import 'app/shop/presenter/auth/bloc/auth_bloc.dart';
import 'app/shop/presenter/auth/pages/auth_page.dart';

void main() async {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(create: (_) => getIt<AuthBloc>(), child: AuthForm()),
    );
  }
}
