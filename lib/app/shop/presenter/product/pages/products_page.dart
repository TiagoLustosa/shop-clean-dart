import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_clean_arch/app/shop/presenter/product/bloc/product_bloc.dart';
import '../../../domain/usecases/base_usecase/base_usecase.dart';
import '../../../utils/app_routes.dart';
import '../../components/app_drawer.dart';
import '../../products_list/bloc/bloc/products_list_bloc.dart';
import '../bloc/product_state.dart';
import '../components/product_item.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  Future<void> _refreshProducts(BuildContext context) {
    BlocProvider.of<ProductsListBloc>(context).add(GetProductsList());
    return Future.value(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Produtos'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.productForm,
              );
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: BlocBuilder<ProductsListBloc, ProductsListState>(
        bloc: BlocProvider.of(context)..add(GetProductsList()),
        builder: (context, state) {
          if (state is ProductsListLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ProductsListError) {
            return Center(
              child: Text('Erro ao carregar os produtos'),
            );
          }
          if (state is ProductsListSuccess) {
            return RefreshIndicator(
              onRefresh: () => _refreshProducts(context),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: ListView.builder(
                  itemCount: state.products.length,
                  itemBuilder: (ctx, i) => Column(
                    children: [
                      ProductItem(state.products[i]),
                      Divider(),
                    ],
                  ),
                ),
              ),
            );
          }
          return Center(
            child: Text('Nenhum produto cadastrado'),
          );
        },
      ),
    );
  }
}
