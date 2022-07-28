import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_clean_arch/app/injector.dart';
import 'package:shop_clean_arch/app/shop/infra/datasources/user_data_local_datasource.dart';
import 'package:shop_clean_arch/app/shop/presenter/components/app_drawer.dart';
import 'package:shop_clean_arch/app/shop/presenter/order/bloc/order_bloc.dart';
import 'package:shop_clean_arch/app/shop/presenter/order/components/order_widget.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
      ),
      drawer: const AppDrawer(),
      body: BlocBuilder<OrderBloc, OrderState>(
        bloc: BlocProvider.of<OrderBloc>(context)
          ..add(GetOrders(injector<IUserDataLocalDataSource>()
              .getUserLocalData()
              .localId!)),
        builder: (context, state) {
          if (state is OrderLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is OrderError) {
            return const Center(
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
