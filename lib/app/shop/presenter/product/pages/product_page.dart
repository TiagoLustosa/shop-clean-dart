// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:provider/provider.dart';
// import 'package:shop_clean_arch/app/shop/presenter/product/bloc/product_bloc.dart';

// import '../../../domain/usecases/base_usecase/base_usecase.dart';
// import '../bloc/product_state.dart';

// class ProductsPage extends StatelessWidget {
//   const ProductsPage({Key? key}) : super(key: key);

//   Future<void> _refreshProducts(BuildContext context) {
//     return context.read<ProductBloc>().productUseCase(NoParams());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Lista de Produtos'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.add),
//             onPressed: () {
//               // Navigator.of(context).pushNamed(
//               //   AppRoutes.PRODUCT_FORM,
//               // );
//             },
//           ),
//         ],
//       ),
//       //  drawer: AppDrawer(),
//       body: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
//         if(state is ProductLoading) {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//         if(state is ProductError) {
//           return Center(
//             child: Text('Erro ao carregar os produtos'),
//           );
//         }
//         if(state is ProductSuccess)
//        { return RefreshIndicator(
//           onRefresh: () => _refreshProducts(context),
//           child: Padding(
//             padding: const EdgeInsets.all(8),
//             child: ListView.builder(
//               itemCount: state.products!.length,
//               itemBuilder: (ctx, i) => Column(
//                 children: [
//                   ProductItem(state.products![i]),
//                   Divider(),
//                 ],
//               ),
//             ),
//           ),
//         );}
//       }),
//     );
//   }
// }
