import 'package:dio/dio.dart';
import 'package:flutter_task/models/model/category_model.dart';

class GetCategory {
  static Dio dio = Dio();

  static Future<List<CategoryModel>> getCategory() async {
    List<CategoryModel> categories = [];

    try {
      Response response = await dio.get('https://fakestoreapi.com/products');

      List<dynamic> listBody = response.data;

      for (var element in listBody) {
        categories.add(CategoryModel.fromJson(element));
      }
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      return [];
    }

    return categories;
  }
}
