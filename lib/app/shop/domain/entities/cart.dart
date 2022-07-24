import 'cart_item.dart';

class Cart {
  final String? userId;
  final List<CartItem>? cartItemList;
  final double? totalPrice;
  final int? totalItems;

  Cart({
    this.userId,
    this.cartItemList,
    this.totalPrice,
    this.totalItems,
  });

  // : totalPrice = _calculateTotalPrice(items),
  //                   totalItems = _calculateTotalItems(items);

  // factory Cart.empty() {
  //   return Cart(
  //     [],);
  // }

  // Cart addItem(CartItem item){
  //   final existedItem = items.firstWhere((i) => i?.id == item.id, orElse: () => null);
  //   if(existedItem != null){
  //     final newItems = items.map((oldItem) {
  //       if(oldItem?.id == item.id){
  //       return CartItem(
  //         id: oldItem?.id,
  //         productId: oldItem?.productId,
  //         name: oldItem?.name,
  //         quantity: (oldItem?.quantity == null) ? 0 : oldItem!.quantity! + 1,
  //         price: oldItem?.price,
  //       );

  //     }
  //     else
  //     {
  //       return oldItem;
  //     }}).toList();
  //   return Cart(newItems);
  //   } else {
  //     final newItems = List.of(items);
  //     newItems.add(item);
  //     return Cart(newItems);
  //   }
  // }

  // Cart editItem(CartItem item, int quantity){
  //   final newItems = items.map((oldItem) {
  //     if(oldItem?.id == item.id){
  //       return CartItem(
  //         id: oldItem?.id,
  //         productId: oldItem?.productId,
  //         name: oldItem?.name,
  //         quantity: quantity,
  //         price: oldItem?.price,
  //       );
  //     }
  //     else
  //     {
  //       return oldItem;
  //     }}).toList();
  //   return Cart(newItems);
  // }

  // static double _calculateTotalPrice(List<CartItem?> items){
  //   final double price = items.fold(0, (previousValue, item) => previousValue + (item!.quantity! * item.price!));

  //   return double.parse(price.toStringAsFixed(2));
  // }

  // static int _calculateTotalItems(List<CartItem?> items){
  //   final int itemsCount = items.fold(0, (previousValue, item) => previousValue + item!.quantity!);
  //   return itemsCount;
  // }
}
