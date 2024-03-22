// ignore_for_file: empty_catches, use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:sheek/features/home/data/repositories/productDetails_repo.dart';

import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_logger.dart';
import '../../data/models/home_model.dart';
import '../../data/models/productDetails_model.dart';
import '../../data/repositories/home_repo.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo homeRepo;

  HomeCubit({required this.homeRepo}) : super(HomeState());

  Future<void> getProducts(BuildContext context) async {
    try {
      if (state.fetchData == false) {
        if (state.pageNumber == "1") {
          emit(state.copyWith(loadingData: true));
        }

        Map<String, String> body = {};
        body['fetch_home_page'] = state.fetchHome;
        body['page_number'] = state.pageNumber;
        HomeModel data = await homeRepo.getProducts(body);

        emit(state.copyWith(response: data));

        if (int.parse(state.pageNumber) == 1) {
          emit(state.copyWith(products: data.products));
        } else {
          List<Products> newProducts = state.products!;
          newProducts.addAll(data.products as List<Products>);
          emit(state.copyWith(products: newProducts));
        }
        emit(state.copyWith(
            pageNumber: (int.parse(state.pageNumber) + 1).toString()));
        emit(state.copyWith(orginalProoducts: state.products));
        emit(state.copyWith(fetchData: false));
        emit(state.copyWith(loadingData: false));
        emit(state.copyWith(fetchFromTab: false));
      }
    } catch (e) {
      emit(state.copyWith(loadingData: false));
      emit(state.copyWith(fetchFromTab: false));

      emit(state.copyWith(fetchData: false));
      logger.e(e);
      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }

  Future<void> changeFetchDataStauts() async {
    emit(state.copyWith(fetchData: true));
  }

  Future<void> changeIsVideoToFalse() async {
    emit(state.copyWith(isVideo: false));
  }

  Future<void> changeIsVideoToTrue() async {
    emit(state.copyWith(isVideo: true));
  }

  Future<void> changefetchFromTabStatus() async {
    emit(state.copyWith(fetchFromTab: true));
  }

  Future<void> clearData() async {
    emit(state.copyWith(
        pageNumber: "1",
        products: [],
        response: HomeModel(banners: [], categories: [], products: [])));
  }

  Future<void> searchProducts(var newProducts) async {
    emit(state.copyWith(products: newProducts));
  }

  Future<void> changeplayVideoStatus(bool value) async {
    emit(state.copyWith(playVideo: value));
  }

  Future<void> changemuteVideoStatus(bool value) async {
    emit(state.copyWith(muteVideo: value));
  }
}

//////////////___________________ PRODUCT DETAILS ___________________//////////////

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final ProductDetailsRepo productDetailsRepo;

  ProductDetailsCubit({required this.productDetailsRepo})
      : super(CartInitial());

  Future<void> getProductDetails(BuildContext context, String productId) async {
    try {
      Map<String, String> body = {};
      body['product_id'] = productId;
      body['fetch_product'] = "1";
      ProductDetailsModel data =
          await productDetailsRepo.getProductDetails(body);
      emit(state.copyWith(productDetails: data));
    } catch (e) {
      logger.e(e);
      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }

  Future<void> clearProductDetails() async {
    emit(state.copyWith(
        productDetails: ProductDetailsModel(
            mainInfo: [],
            productAttachments: [],
            productColors: [],
            productSizes: [],
            similarProducts: [])));
  }
}
