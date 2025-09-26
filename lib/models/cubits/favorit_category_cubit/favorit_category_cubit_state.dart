import 'package:flutter_task/models/model/category_model.dart';

class FavoritCategoryCubitState {}

class FavoritCategoryCubitInitial extends FavoritCategoryCubitState {}

class FavoritCategoryCubitLoading extends FavoritCategoryCubitState {}

class FavoritCategoryCubitSuccess extends FavoritCategoryCubitState {
  List<CategoryModel> favoritCategories = [];
  FavoritCategoryCubitSuccess({required this.favoritCategories});
}

class FavoritCategoryCubitFailure extends FavoritCategoryCubitState {
  final String? errorMessage;

  FavoritCategoryCubitFailure({required this.errorMessage});
}
