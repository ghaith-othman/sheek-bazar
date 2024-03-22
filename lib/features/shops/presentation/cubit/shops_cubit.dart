// ignore_for_file: unrelated_type_equality_checks, use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sheek/features/shops/data/models/products_model.dart';
import 'package:sheek/features/shops/data/repositories/shops_repo.dart';

import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_logger.dart';
import '../../data/models/shops_model.dart';
import '../../data/repositories/getProducts_repo.dart';

part 'shops_state.dart';

class ShopsCubit extends Cubit<ShopsState> {
  final ShopsRepo shopsRepo;
  final GetProductsRepo getProductsRepo;

  ShopsCubit({required this.shopsRepo, required this.getProductsRepo})
      : super(ShopsInitial());

  Future<void> getShops(BuildContext context) async {
    try {
      Map<String, String> body = {};
      body['fetch_shops'] = "1";
      ShopModel data = await shopsRepo.getShops(body);
      emit(state.copyWith(shops: data));
      emit(state.copyWith(shopsFilter: data));
      logger.i(data);
    } catch (e) {
      logger.e(e);
      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }

  changeFilter(List<Suppliers> value) =>
      emit(state.copyWith(shopsFilter: ShopModel(suppliers: value)));

  Future<void> getProducts(BuildContext context, String supplierID,
      String categoryId, String subcategoryId) async {
    try {
      Map<String, String> body = {};
      emit(state.copyWith(loadingProducts: true));
      body['fetch_products'] = "1";
      if (supplierID != "-1") {
        body['supplier_id'] = supplierID;
      }
      if (categoryId != "-1") {
        body['category_id'] = categoryId;
      }
      if (subcategoryId != "-1") {
        body['sub_category'] = subcategoryId;
      }
      ProductsModel data = await getProductsRepo.getProducts(body);
      emit(state.copyWith(products: data));
      emit(state.copyWith(defaultproducts: data));
      emit(state.copyWith(loadingProducts: false));

      logger.i(data);
    } catch (e) {
      emit(state.copyWith(loadingProducts: false));

      logger.e(e);
      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }

  changeSearch(List<Products> value) => emit(state.copyWith(
      products: ProductsModel(
          products: value,
          supplierAttachments: state.products!.supplierAttachments,
          supplierInfo: state.products!.supplierInfo)));

  Future<void> clearproducts() async {
    emit(state.copyWith(
        products: ProductsModel(
            products: [], supplierAttachments: [], supplierInfo: [])));
  }

  Future<void> filterProducts(BuildContext context, double startPrice,
      double endPrice, String? radioValue) async {
    if (radioValue == null) {
      List<Products> filteredProducts =
          state.defaultproducts!.products!.where((product) {
        String priceString = product.productPrice!;
        int price = int.parse(priceString);

        return price >= startPrice && price <= endPrice;
      }).toList();
      emit(state.copyWith(
          products: ProductsModel(
              products: filteredProducts,
              supplierAttachments: state.products!.supplierAttachments,
              supplierInfo: state.products!.supplierInfo)));
      Navigator.pop(context);
    } else {
      List<Products> filteredProducts =
          state.defaultproducts!.products!.where((product) {
        String priceString = product.productFinalPrice!;
        int price = int.parse(priceString);

        return price >= startPrice && price <= endPrice;
      }).toList();
      if (radioValue == "from cheapest") {
        filteredProducts.sort((a, b) => int.parse(a.productFinalPrice!)
            .compareTo(int.parse(b.productFinalPrice!)));
        emit(state.copyWith(
            products: ProductsModel(
                products: filteredProducts,
                supplierAttachments: state.products!.supplierAttachments,
                supplierInfo: state.products!.supplierInfo)));
        Navigator.pop(context);
      } else if (radioValue == "from expansive") {
        filteredProducts.sort((a, b) => int.parse(b.productFinalPrice!)
            .compareTo(int.parse(a.productFinalPrice!)));
        emit(state.copyWith(
            products: ProductsModel(
                products: filteredProducts,
                supplierAttachments: state.products!.supplierAttachments,
                supplierInfo: state.products!.supplierInfo)));
        Navigator.pop(context);
      } else if (radioValue == "from newest") {
        filteredProducts.sort((a, b) => DateTime.parse(a.createdAt!)
            .compareTo(DateTime.parse(b.createdAt!)));
        emit(state.copyWith(
            products: ProductsModel(
                products: filteredProducts,
                supplierAttachments: state.products!.supplierAttachments,
                supplierInfo: state.products!.supplierInfo)));
        Navigator.pop(context);
      } else if (radioValue == "from oldest") {
        filteredProducts.sort((a, b) => DateTime.parse(b.createdAt!)
            .compareTo(DateTime.parse(a.createdAt!)));
        emit(state.copyWith(
            products: ProductsModel(
                products: filteredProducts,
                supplierAttachments: state.products!.supplierAttachments,
                supplierInfo: state.products!.supplierInfo)));
        Navigator.pop(context);
      } else if (radioValue == "with discount") {
        List<Products> sortedFilteredProducts = filteredProducts
            .where((product) => product.productDiscount != "0")
            .toList();
        emit(state.copyWith(
            products: ProductsModel(
                products: sortedFilteredProducts,
                supplierAttachments: state.products!.supplierAttachments,
                supplierInfo: state.products!.supplierInfo)));
        Navigator.pop(context);
      } else if (radioValue == "without discount") {
        List<Products> sortedFilteredProducts = filteredProducts
            .where((product) => product.productDiscount == "0")
            .toList();
        emit(state.copyWith(
            products: ProductsModel(
                products: sortedFilteredProducts,
                supplierAttachments: state.products!.supplierAttachments,
                supplierInfo: state.products!.supplierInfo)));
        Navigator.pop(context);
      } else if (radioValue == "new") {
        List<Products> sortedFilteredProducts =
            filteredProducts.where((product) => product.isUsed == "0").toList();
        emit(state.copyWith(
            products: ProductsModel(
                products: sortedFilteredProducts,
                supplierAttachments: state.products!.supplierAttachments,
                supplierInfo: state.products!.supplierInfo)));
        Navigator.pop(context);
      } else if (radioValue == "old") {
        List<Products> sortedFilteredProducts =
            filteredProducts.where((product) => product.isUsed != "0").toList();
        emit(state.copyWith(
            products: ProductsModel(
                products: sortedFilteredProducts,
                supplierAttachments: state.products!.supplierAttachments,
                supplierInfo: state.products!.supplierInfo)));
        Navigator.pop(context);
      } else if (radioValue == "all products") {
        emit(state.copyWith(
          products: state.defaultproducts,
        ));
        Navigator.pop(context);
      }
    }
  }
}
