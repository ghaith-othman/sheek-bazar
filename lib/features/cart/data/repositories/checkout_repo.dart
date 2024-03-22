// ignore_for_file: non_constant_identifier_names, file_names

import '../datasources/checkout_ds.dart';
import '../models/operations_model.dart';

class CheckoutRepo {
  final CheckOutDS dataSource;

  CheckoutRepo({required this.dataSource});

  Future<OperationsModel> checkout(Map<String, String>? body) async {
    OperationsModel MyOrdersResponse = OperationsModel.fromJson(
      await dataSource.checkout(body),
    );
    return MyOrdersResponse;
  }
}
