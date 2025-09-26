import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/services/get_category_services.dart';
import 'category_cubit_state.dart';

class CategoryCubit extends Cubit<CategoryCubitState> {
  CategoryCubit() : super(CategoryCubitInitial());

  void fetchCategories() async {
    emit(CategoryCubitLoading());

    try {
      final categories = await GetCategoryServices.getCategory();

      if (categories.isNotEmpty) {
        emit(CategoryCubitSuccess(categories));
      } else {
        emit(CategoryCubitFailure('No categories found'));
      }
    } catch (e) {
      emit(CategoryCubitFailure(e.toString()));
    }
  }
}
