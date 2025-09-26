import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/models/cubits/category_cubit/category_cubit.dart';
import 'package:flutter_task/models/cubits/category_cubit/category_cubit_state.dart';
import 'package:flutter_task/models/model/category_model.dart';
import 'package:flutter_task/widgets/custom_category_card.dart';

class CustomListViewCard extends StatefulWidget {
  const CustomListViewCard({super.key});

  @override
  State<CustomListViewCard> createState() => _CustomListViewCardState();
}

class _CustomListViewCardState extends State<CustomListViewCard> {
  List<CategoryModel> categories = [];
  @override
  void initState() {
    context.read<CategoryCubit>().fetchCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryCubitState>(
      builder: (context, state) {
        if (state is CategoryCubitLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CategoryCubitSuccess) {
          categories = state.categories;
        } else if (state is CategoryCubitFailure) {
          return Center(child: Text(state.errorMessage));
        }

        return ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return CustomCategoryCard(categoryModel: categories[index]);
          },
        );
      },
    );
  }
}
