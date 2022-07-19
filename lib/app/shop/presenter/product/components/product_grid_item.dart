import 'package:flutter/material.dart';
import 'package:shop_clean_arch/app/shop/utils/app_routes.dart';
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
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: IconButton(
              icon: const Icon(Icons.favorite),
              color: Colors.pink,
              onPressed: () {},
            ),
            title: Text(
              product.name!,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.shopping_cart),
              color: Theme.of(context).colorScheme.surface,
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
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                AppRoutes.productDetail,
                arguments: product,
              );
            },
            child: Image.network(
              product.imageUrl!,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
