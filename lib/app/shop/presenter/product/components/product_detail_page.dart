import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_clean_arch/app/shop/presenter/product/bloc/product_event.dart';
import 'package:shop_clean_arch/app/shop/presenter/products_list/bloc/bloc/products_list_bloc.dart';
import '../../../infra/models/product_result_model.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_state.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductResultModel productResultModel =
        ModalRoute.of(context)!.settings.arguments as ProductResultModel;

    return Scaffold(
      appBar: AppBar(
        title: Text(productResultModel.name!),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                productResultModel.imageUrl!,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'R\$ ${productResultModel.price}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                productResultModel.description!,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
