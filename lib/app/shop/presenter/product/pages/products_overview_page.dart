import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_clean_arch/app/shop/infra/models/product_result_model.dart';
import 'package:shop_clean_arch/app/shop/presenter/auth/bloc/auth_bloc.dart';
import 'package:shop_clean_arch/app/shop/presenter/product/components/product_grid.dart';
import '../../../domain/usecases/base_usecase/base_usecase.dart';
import '../../../utils/app_routes.dart';
import '../../components/app_drawer.dart';
import '../../products_list/bloc/bloc/products_list_bloc.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
import '../components/product_grid_item.dart';

class ProductOverViewPage extends StatefulWidget {
  const ProductOverViewPage({Key? key}) : super(key: key);

  @override
  State<ProductOverViewPage> createState() => _ProductOverViewPageState();
}

class _ProductOverViewPageState extends State<ProductOverViewPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Loja'),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text('Somente Favoritos'),
              ),
              const PopupMenuItem(
                child: Text('Todos'),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.cart);
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: BlocBuilder<ProductsListBloc, ProductsListState>(
          bloc: BlocProvider.of(context)..add(GetProductsList()),
          builder: (context, state) {
            if (state is ProductsListLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ProductsListError) {
              return const Center(child: Text('Erro ao carregar os produtos'));
            }
            if (state is ProductsListSuccess) {
              return const ProductGrid();
            }
            return const Center(child: Text('Nenhum produto cadastrado'));
          }),
      drawer: const AppDrawer(),
    );
  }
}
