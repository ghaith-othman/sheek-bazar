// ignore_for_file: non_constant_identifier_names, file_names

import 'package:sheek/features/cart/data/models/operations_model.dart';
import 'package:sheek/features/profile/data/datasources/updateProfile_ds.dart';

class UpdateProfileRepo {
  final UpdateProfileDS dataSource;

  UpdateProfileRepo({required this.dataSource});

  Future<OperationsModel> updateProfile(Map<String, String>? body) async {
    OperationsModel MyOrdersResponse = OperationsModel.fromJson(
      await dataSource.updateProfile(body),
    );
    return MyOrdersResponse;
  }
}
