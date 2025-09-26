import 'package:flutter/material.dart';
import 'package:flutter_task/models/model/category_model.dart';
import 'package:flutter_task/utils/app_color.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.categoryModel});
  final CategoryModel categoryModel;

  @override
  State<ProductDetails> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Product Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: Image.network(
                    widget.categoryModel.image ??
                        'https://via.placeholder.com/150',
                    height: 250,
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.categoryModel.title ?? 'No Title',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        widget.categoryModel.description ?? 'No Description',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber.shade700,
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Rating: ${widget.categoryModel.rating?.rate?.toStringAsFixed(1) ?? 'N/A'}",
                            style: const TextStyle(fontSize: 16),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.grey[700],
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Sold: ${widget.categoryModel.rating?.count ?? 'N/A'}",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
