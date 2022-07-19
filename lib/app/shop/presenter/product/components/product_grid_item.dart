import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shop_clean_arch/app/shop/presenter/product/bloc/product_bloc.dart';
import 'package:shop_clean_arch/app/shop/presenter/product/bloc/product_state.dart';
import 'package:shop_clean_arch/app/shop/presenter/product/components/product_detail_page.dart';
import 'package:shop_clean_arch/app/shop/presenter/products_list/bloc/bloc/products_list_bloc.dart';

import '../../../infra/models/product_result_model.dart';

class ProductGridItem extends StatelessWidget {
  final ProductResultModel product;

  const ProductGridItem({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: GestureDetector(
            child: Image.network(
              product.imageUrl!,
              fit: BoxFit.cover,
            ),
            onTap: () {
              Navigator.of(context).pushNamed(
                '/detail',
                arguments: product,
              );
            },
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: IconButton(
              icon: Icon(Icons.favorite),
              color: Colors.pink,
              onPressed: () {},
            ),
            title: Text(
              product.name!,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              color: Theme.of(context).accentColor,
              onPressed: () {},
              // onPressed: () {
              //   cart.addItem(product);
              //   ScaffoldMessenger.of(context).hideCurrentSnackBar();
              //   ScaffoldMessenger.of(context).showSnackBar(
              //     SnackBar(
              //       content: Text('Produto adicionado com sucesso!'),
              //       duration: Duration(seconds: 2),
              //       action: SnackBarAction(
              //         label: 'DESFAZER',
              //         onPressed: () {
              //           cart.removeSingleItem(state.product!.id);
              //         },
              //       ),
              //     ),
              //   );
              // },
            ),
          ),
        ),
      ),
    );
  }
}
