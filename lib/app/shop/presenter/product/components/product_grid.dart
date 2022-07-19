import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_clean_arch/app/shop/presenter/product/components/product_grid_item.dart';
import '../../products_list/bloc/bloc/products_list_bloc.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsListBloc, ProductsListState>(
      // bloc: BlocProvider.of<ProductsListBloc>(context)..add(GetProductsList()),
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
          return GridView.builder(
            itemCount: state.products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return ProductGridItem(
                product: state.products[index],
              );
            },
          );
        }

        return const Center(
          child: Text('Nenhum produto cadastrado'),
        );
      },
    );
  }
}
