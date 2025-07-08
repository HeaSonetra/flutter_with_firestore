import 'package:firestore_note/app/controller/cart_controller.dart';
import 'package:get/get.dart';
import '../ui/pages/cart/cart_screen.dart';
import '../ui/pages/home/home_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.HOME,
      page: () => const HomeScreen(),
      // Use a binding to initialize controllers when the route is loaded
      binding: BindingsBuilder(() {
        Get.put(CartController()); // CartController is global
      }),
    ),
    GetPage(
      name: AppRoutes.CART,
      page: () => const CartScreen(),
    ),
  ];
}