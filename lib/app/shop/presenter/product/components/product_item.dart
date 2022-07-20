import 'package:flutter/material.dart';
import 'package:shop_clean_arch/app/shop/infra/models/product_result_model.dart';

import '../../../utils/app_routes.dart';

class ProductItem extends StatelessWidget {
  final ProductResultModel product;
  const ProductItem(
    this.product, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final msg = ScaffoldMessenger.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl!),
      ),
      title: Text(product.name!),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.productForm,
                  arguments: product,
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () {
                showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Excluir Produto'),
                    content: Text('Tem certeza?'),
                    actions: [
                      TextButton(
                        child: Text('Não'),
                        onPressed: () => Navigator.of(ctx).pop(false),
                      ),
                      TextButton(
                        child: Text('Sim'),
                        onPressed: () => Navigator.of(ctx).pop(true),
                      ),
                    ],
                  ),
                ).then((value) async {
                  if (value ?? false) {
                    // try {
                    //   await BlocProvider.of<ProductBloc>(
                    //     context,
                    //     listen: false,
                    //   ).removeProduct(product);
                    // } on HttpException catch (error) {
                    //   msg.showSnackBar(
                    //     SnackBar(
                    //       content: Text(error.toString()),
                    //     ),
                    //   );
                    // }
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
