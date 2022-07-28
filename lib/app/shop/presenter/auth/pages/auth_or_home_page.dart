import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_clean_arch/app/shop/presenter/auth/bloc/auth_bloc.dart';
import 'package:shop_clean_arch/app/shop/presenter/auth/bloc/auth_state.dart';
import 'package:shop_clean_arch/app/shop/presenter/auth/pages/auth_page.dart';
import 'package:shop_clean_arch/app/shop/presenter/product/pages/products_overview_page.dart';

class AuthOrHomePage extends StatelessWidget {
  const AuthOrHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is AuthLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is AuthSuccess) {
        return const ProductOverViewPage();
      }
      if (state is AuthError) {
        return const Center(child: Text('Erro ao carregar o usuário'));
      }
      return const AuthPage();
    });
  }
}
