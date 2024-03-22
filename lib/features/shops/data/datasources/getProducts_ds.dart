// ignore_for_file: file_names

import 'package:sheek/core/utils/app_logger.dart';

import '../../../../core/utils/http_helper.dart';

class GetProductsDS {
  final ApiBaseHelper apiHelper;

  GetProductsDS({required this.apiHelper});

  Future<Map<String, dynamic>?> getProducts(Map<String, String>? body) async {
    logger.i(body);
    Map<String, dynamic>? response =
        await apiHelper.post("/api/products.php", body: body, headers: {});
    return response;
  }
}
