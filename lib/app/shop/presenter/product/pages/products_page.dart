import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/app_routes.dart';
import '../../components/app_drawer.dart';
import '../../products_list/bloc/bloc/products_list_bloc.dart';
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
        title: const Text('Lista de Produtos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.productForm,
              );
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: BlocBuilder<ProductsListBloc, ProductsListState>(
        builder: (context, state) {
          if (state is ProductsListLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ProductsListError) {
            return const Center(
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
                      const Divider(),
                    ],
                  ),
                ),
              ),
            );
          }
          return const Center(
            child: Text('Nenhum produto cadastrado'),
          );
        },
      ),
    );
  }
}
