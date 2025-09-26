import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/models/cubits/favorit_category_cubit/favorit_category_cubit.dart';
import 'package:flutter_task/models/cubits/favorit_category_cubit/favorit_category_cubit_state.dart';
import 'package:flutter_task/utils/app_color.dart';

class FavoritScreen extends StatelessWidget {
  const FavoritScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoritCategoryCubit, FavoritCategoryCubitState>(
      listener: (context, state) {
        if (state is FavoritCategoryCubitFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColor.backgroundColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text(
              'Favorit Categories',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: ListView.builder(
            itemCount: context
                .watch<FavoritCategoryCubit>()
                .favoritCategories
                .length,
            itemBuilder: (context, index) {
              final category = context
                  .watch<FavoritCategoryCubit>()
                  .favoritCategories[index];
              return Card(
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            context
                                .read<FavoritCategoryCubit>()
                                .removeFromFavorit(categoryModel: category);
                          },
                          icon: Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                    Image.network(
                      category.image ?? 'https://via.placeholder.com/150',
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
                            category.title ?? 'No Title',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            category.description ?? 'No Description',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
