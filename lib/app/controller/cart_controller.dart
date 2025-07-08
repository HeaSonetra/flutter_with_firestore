import 'package:firestore_note/app/data/model/product_model.dart';
import 'package:get/get.dart';

class CartItem {
  final ProductModel product;
  final RxInt quantity;

  CartItem({required this.product, int quantity = 1}) : quantity = quantity.obs;

  double get totalPrice => product.price * quantity.value;
}

class CartController extends GetxController {
  final RxMap<String, CartItem> _cartItems = <String, CartItem>{}.obs;

  Map<String, CartItem> get cartItems => _cartItems;

  // Getter for total price
  double get totalPrice => _cartItems.values
      .fold(0, (sum, item) => sum + item.totalPrice);

  // Getter for total number of items in cart
  int get totalItems => _cartItems.values
      .fold(0, (sum, item) => sum + item.quantity.value);


  void addToCart(ProductModel product) {
    if (_cartItems.containsKey(product.id)) {
      _cartItems[product.id]!.quantity.value++;
    } else {
      _cartItems[product.id] = CartItem(product: product);
    }
    Get.snackbar(
      'Product Added',
      '${product.name} was added to your cart.',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  void removeFromCart(String productId) {
    _cartItems.remove(productId);
  }

  void incrementQuantity(String productId) {
    if (_cartItems.containsKey(productId)) {
      _cartItems[productId]!.quantity.value++;
    }
  }

  void decrementQuantity(String productId) {
    if (_cartItems.containsKey(productId) &&
        _cartItems[productId]!.quantity.value > 1) {
      _cartItems[productId]!.quantity.value--;
    } else {
      // Remove if quantity becomes 0
      _cartItems.remove(productId);
    }
  }
}