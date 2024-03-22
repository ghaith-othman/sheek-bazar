// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek/Locale/app_localization.dart';
import 'package:sheek/features/auth/presentation/pages/sign_in.dart';
import 'package:sheek/features/profile/data/models/orderDetails_model.dart';
import 'package:sheek/features/profile/data/repositories/favorite_repo.dart';
import 'package:sheek/features/profile/data/repositories/updateProfile_repo.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_logger.dart';
import '../../../../core/utils/cache_helper.dart';
import '../../../cart/data/models/operations_model.dart';
import '../../data/models/favorite_model.dart';
import '../../data/models/orders_model.dart';
import '../../data/repositories/orderDetails_repo.dart';
import '../../data/repositories/orders_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final FavoriteRepo favoriteRepo;
  final UpdateProfileRepo updateProfileRepo;
  final OrdersRepo ordersRepo;
  final OrderDetailsRepo orderDetailsRepo;

  ProfileCubit(
      {required this.favoriteRepo,
      required this.updateProfileRepo,
      required this.orderDetailsRepo,
      required this.ordersRepo})
      : super(ProfileInitial());

  //////__________GET MY FAVORITE __________////////////////

  Future<void> getMyFavorite(BuildContext context) async {
    try {
      emit(state.copyWith(loadingFavorite: true));

      await cacheDataForFav();
      Map<String, String> body = {};
      body['customer_id'] = state.customerId!;
      body['fetch_wishlist'] = "1";

      FavoriteModel data = await favoriteRepo.getMyFavorite(body);
      logger.i(data);
      emit(state.copyWith(myFavorite: data));
      emit(state.copyWith(loadingFavorite: false));
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(loadingFavorite: false));

      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }
  //////__________INSERT TO MY FAVORITE __________////////////////

  Future<void> insertToMyFavorite(
      BuildContext context, String productID) async {
    try {
      await cacheDataForFav();
      Map<String, String> body = {};
      body['customer_id'] = state.customerId!;
      body['insert_to_wishlist'] = "1";
      body['product_id'] = productID;

      OperationsModel data =
          await favoriteRepo.insertOrDeleteToMyFavorite(body);
      // List<WishlistItems> wishlistItems = state.myFavorite!.wishlistItems!;

      await getMyFavorite(context);
      // AppConstant.customNavigation(context, const FavoriteScreen(), -1, 0);
      logger.i(data);
    } catch (e) {
      logger.e(e);
      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }
////// DELETE FROM MY FAVORITE __________////////////////

  Future<void> deleteFromMyFavorite(
      BuildContext context, String productID) async {
    try {
      await cacheDataForFav();
      Map<String, String> body = {};
      body['delete_from_wishlist'] = "1";
      body['id'] = productID;
      body['customer_id'] = state.customerId!;

      OperationsModel data =
          await favoriteRepo.insertOrDeleteToMyFavorite(body);
      List<WishlistItems> wishlistItems = state.myFavorite!.wishlistItems!;
      wishlistItems.removeWhere((item) => item.id == productID);
      emit(state.copyWith(
          myFavorite: FavoriteModel(wishlistItems: wishlistItems)));
      logger.i(data);
    } catch (e) {
      logger.e(e);
      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }

  Future<void> cacheData() async {
    String userId = await CacheHelper.getData(key: "USER_ID");
    emit(state.copyWith(userId: userId));
  }

  Future<void> cacheDataForFav() async {
    String customerId = await CacheHelper.getData(key: "CUSTOMER_ID");
    emit(state.copyWith(customerId: customerId));
  }

  Future<void> clearMyFavorite() async {
    emit(state.copyWith(myFavorite: FavoriteModel(wishlistItems: [])));
  }

  /////////////////////////_________________UPDATE PROFILE_________________________________/////////////////////////////
  onUserNameChange(String value) => emit(state.copyWith(userName: value));
  onPhoneNumberChange(String value) => emit(state.copyWith(phoneNumber: value));
  onPasswordChange(String value) => emit(state.copyWith(password: value));

  Future<void> updateProfile(BuildContext context, String name, String password,
      String phoneNumber) async {
    try {
      await cacheData();
      if (state.userName == null) {
        emit(state.copyWith(userName: name));
      }
      if (state.password == null) {
        emit(state.copyWith(password: password));
      }
      if (state.phoneNumber == null) {
        emit(state.copyWith(phoneNumber: phoneNumber));
      }
      Map<String, String> body = {};
      body['update_profile'] = "1";
      body['user_id'] = state.userId!;
      body['user_name'] = state.userName!;
      body['user_phone'] = state.phoneNumber!;
      body['user_password'] = state.password!;

      OperationsModel data = await updateProfileRepo.updateProfile(body);
      if (data.errorMsg == "false") {
        cacheDataForUpdate(
            state.userName!, state.password!, state.phoneNumber!);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.primaryColor,
            padding: EdgeInsets.only(
                bottom: 150.h, top: 50.h, left: 50.w, right: 50.w),
            content: Text(
              'save_changes'.tr(context),
              style: const TextStyle(color: Colors.green),
            ),
            duration: const Duration(seconds: 2), // Optional duration
          ),
        );
        // await AppConstant.customAlert(context, "save_changes",
        //     withTranslate: true, witherror: false);
        logger.i(data);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.primaryColor,
            padding: EdgeInsets.only(
                bottom: 150.h, top: 50.h, left: 50.w, right: 50.w),
            content: Text(
              '${data.status}',
              style: const TextStyle(color: Colors.red),
            ),
            duration: const Duration(seconds: 2), // Optional duration
          ),
        );
        // await AppConstant.customAlert(context, "${data.status}",
        //     withTranslate: false, witherror: true);
      }
    } catch (e) {
      logger.e(e);
      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }

  cacheDataForUpdate(
      String userName, String password, String phonenumber) async {
    await CacheHelper.saveData(key: "USER_NAME", value: userName);
    await CacheHelper.saveData(key: "USER_PASSWORD", value: password);
    await CacheHelper.saveData(key: "USER_PHONENUMBER", value: phonenumber);
  }

  Future<void> deletePRofile(BuildContext context) async {
    try {
      await cacheData();

      Map<String, String> body = {};
      body['delete_profile'] = "1";
      body['user_id'] = state.userId!;

      OperationsModel data = await updateProfileRepo.updateProfile(body);
      await CacheHelper.clearData(
        key: "USER_NAME",
      );
      await CacheHelper.clearData(
        key: "USER_ID",
      );
      await CacheHelper.clearData(
        key: "CUSTOMER_ID",
      );
      await CacheHelper.clearData(
        key: "SUPPLIER_ID",
      );
      await CacheHelper.clearData(
        key: "USER_PASSWORD",
      );
      await CacheHelper.clearData(
        key: "USER_PHONENUMBER",
      );
      clearMyFavorite();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const SigninScreen()),
        (Route route) => false,
      );
      logger.i(data);
    } catch (e) {
      logger.e(e);
      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }

  ////////////////////////////////////////////// Orders Sections //////////////////////////////////
  Future<void> getOrders(BuildContext context) async {
    try {
      emit(state.copyWith(loadingOrders: true));
      await cacheDataForFav();

      Map<String, String> body = {};
      body['customer_id'] = state.customerId!;
      body['fetch_orders'] = "1";
      OrdersModel data = await ordersRepo.getOrders(body);
      emit(state.copyWith(clothesOrders: data));

      // Map<String, String> body2 = {};
      // body2['customer_id'] = state.customerId!;
      // body2['fetch_laundry_orders'] = "1";
      // OrdersModel data2 = await ordersRepo.getOrders(body2);
      // emit(state.copyWith(laundryOrders: data2));

      logger.i(data);
      // logger.i(data2);
      emit(state.copyWith(loadingOrders: false));
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(loadingOrders: false));
      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }

  Future<void> getLaundryOrders(BuildContext context) async {
    try {
      emit(state.copyWith(loadingOrders: true));
      await cacheDataForFav();

      Map<String, String> body = {};
      body['customer_id'] = state.customerId!;
      body['fetch_laundry_orders'] = "1";
      OrdersModel data = await ordersRepo.getOrders(body);
      emit(state.copyWith(laundryOrders: data));

      // Map<String, String> body2 = {};
      // body2['customer_id'] = state.customerId!;
      // body2['fetch_laundry_orders'] = "1";
      // OrdersModel data2 = await ordersRepo.getOrders(body2);
      // emit(state.copyWith(laundryOrders: data2));

      logger.i(data);
      // logger.i(data2);
      emit(state.copyWith(loadingOrders: false));
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(loadingOrders: false));
      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }

  Future<void> getOrdersDetails(BuildContext context, String orderId) async {
    try {
      emit(state.copyWith(loadingOrdersDetails: true));
      await cacheDataForFav();

      Map<String, String> body = {};
      body['customer_id'] = state.customerId!;
      body['fetch_order_details'] = "1";
      body['order_id'] = orderId;
      OrderDetailsModel data = await orderDetailsRepo.getOrderDetails(body);
      emit(state.copyWith(orderDetails: data));
      logger.i(data);
      // logger.i(data2);
      emit(state.copyWith(loadingOrdersDetails: false));
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(loadingOrdersDetails: false));
      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }
}
