import 'package:flutter_task/models/model/category_model.dart';

class CategoryCubitState {}

class CategoryCubitInitial extends CategoryCubitState {}

class CategoryCubitLoading extends CategoryCubitState {}

class CategoryCubitSuccess extends CategoryCubitState {
  final List<CategoryModel> categories;
  CategoryCubitSuccess(this.categories);
}

class CategoryCubitFailure extends CategoryCubitState {
  final String errorMessage;
  CategoryCubitFailure(this.errorMessage);
}
