import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_clean_arch/app/shop/infra/models/product_result_model.dart';
import 'package:shop_clean_arch/app/shop/presenter/product/components/product_grid.dart';
import '../../../domain/usecases/base_usecase/base_usecase.dart';
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
    return BlocBuilder<ProductsListBloc, ProductsListState>(
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
            return ProductGrid();
          }

          return Center(child: Text('Não há produtos'));
        });
  }
}
