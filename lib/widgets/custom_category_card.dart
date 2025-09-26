import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/models/cubits/favorit_category_cubit/favorit_category_cubit.dart';
import 'package:flutter_task/models/model/category_model.dart';
import 'package:flutter_task/screens/category_screen/category_screen.dart';

class CustomCategoryCard extends StatefulWidget {
  const CustomCategoryCard({super.key, required this.categoryModel});
  final CategoryModel categoryModel;

  @override
  State<CustomCategoryCard> createState() => _CustomCategoryCardState();
}

class _CustomCategoryCardState extends State<CustomCategoryCard> {
  Color iconColor = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ProductDetails(categoryModel: widget.categoryModel),
            ),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 6,
          shadowColor: Colors.black26,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.categoryModel.image ?? 'https://via.placeholder.com/150',
                height: 200,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.categoryModel.title ?? 'No Title',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.categoryModel.description ?? 'No Description',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              iconColor = iconColor == Colors.grey
                                  ? Colors.red
                                  : Colors.grey;
                            });
                            iconColor == Colors.red
                                ? context
                                      .read<FavoritCategoryCubit>()
                                      .addToFavorit(
                                        categoryModel: widget.categoryModel,
                                      )
                                : context
                                      .read<FavoritCategoryCubit>()
                                      .removeFromFavorit(
                                        categoryModel: widget.categoryModel,
                                      );
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: iconColor,
                            size: 30,
                          ),
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber.shade700,
                          size: 24,
                        ),

                        Text(
                          "Rating: ${widget.categoryModel.rating?.rate?.toStringAsFixed(1) ?? 'N/A'}",
                          style: const TextStyle(fontSize: 16),
                        ),

                        Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.grey[700],
                          size: 24,
                        ),

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
    );
  }
}
