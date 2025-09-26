import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/models/cubits/favorit_category_cubit/favorit_category_cubit_state.dart';
import 'package:flutter_task/models/model/category_model.dart';

class FavoritCategoryCubit extends Cubit<FavoritCategoryCubitState> {
  FavoritCategoryCubit() : super(FavoritCategoryCubitInitial());
  List<CategoryModel> favoritCategories = [];
  void addToFavorit({required CategoryModel categoryModel}) {
    emit(FavoritCategoryCubitLoading());
    try {
      favoritCategories.add(categoryModel);
      emit(FavoritCategoryCubitSuccess(favoritCategories: favoritCategories));
    } catch (e) {
      emit(FavoritCategoryCubitFailure(errorMessage: e.toString()));
    }
  }

  void removeFromFavorit({required CategoryModel categoryModel}) {
    emit(FavoritCategoryCubitLoading());
    try {
      favoritCategories.remove(categoryModel);
      emit(FavoritCategoryCubitSuccess(favoritCategories: favoritCategories));
    } catch (e) {
      emit(FavoritCategoryCubitFailure(errorMessage: e.toString()));
    }
  }
}
