import 'package:cached_network_image/cached_network_image.dart';
import 'package:firestore_note/app/controller/cart_controller.dart';
import 'package:firestore_note/app/data/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/cart_icon_badge.dart';
import '../../widgets/loading_spinner.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // Find the already initialized CartController
    final CartController cartController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: const [
          CartIconBadge(),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: product.imageUrl,
                height: 300,
                fit: BoxFit.cover,
                placeholder: (context, url) => const LoadingSpinner(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(height: 24),

            // Product Name
            Text(product.name, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),

            // Rating
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 4),
                Text(
                  '${product.rating} (${product.reviewCount} Reviews)',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),

            // Description
            Text('Description', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              product.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),

            // Size Selector
            if (product.sizes.isNotEmpty) ...[
               Text('Size', style: Theme.of(context).textTheme.titleLarge),
               const SizedBox(height: 8),
               // Add size selection logic here if needed
               Wrap(
                 spacing: 8.0,
                 children: product.sizes.map((size) => Chip(label: Text(size))).toList(),
               ),
               const SizedBox(height: 24),
            ],
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                cartController.addToCart(product);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}