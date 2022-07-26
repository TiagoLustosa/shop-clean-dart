import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_clean_arch/app/injector.dart';
import 'package:shop_clean_arch/app/shop/infra/models/auth_result_model.dart';
import 'package:shop_clean_arch/app/shop/presenter/components/app_drawer.dart';
import 'package:shop_clean_arch/app/shop/presenter/order/bloc/order_bloc.dart';
import 'package:shop_clean_arch/app/shop/presenter/order/components/order_widget.dart';

class OrdersPage extends StatelessWidget {
  AuthResultModel getUserId() {
    final prefs = injector.get<SharedPreferences>();
    final authResult = prefs.getString('userLogged');
    final json = jsonDecode(authResult!);
    AuthResultModel auth = AuthResultModel(
        userId: json['userId'], token: json['token'], email: json['email']);
    return auth;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Pedidos'),
      ),
      drawer: AppDrawer(),
      body: BlocBuilder<OrderBloc, OrderState>(
        bloc: BlocProvider.of<OrderBloc>(context)
          ..add(GetOrders(getUserId().userId.toString())),
        builder: (context, state) {
          if (state is OrderLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is OrderError) {
            return Center(
              child: Text('Ocorreu um erro!'),
            );
          }
          if (state is OrderSuccess) {
            return ListView.builder(
              itemCount: state.orderList.length,
              itemBuilder: (context, index) {
                return OrderWidget(order: state.orderList[index]);
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
