import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_note/app/data/model/product_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RxList<ProductModel> products = <ProductModel>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      final snapshot = await _firestore.collection('prodata').get();
      final productList = snapshot.docs
          .map((doc) => ProductModel.fromMap(doc.id, doc.data()))
          .toList();
      products.assignAll(productList);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch products: $e');
    } finally {
      isLoading(false);
    }
  }
}