// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:equatable/equatable.dart';

import '../../data/models/home_model.dart';
import '../../data/models/productDetails_model.dart';

class HomeState extends Equatable {
  HomeState(
      {this.fetchHome = "1",
      this.pageNumber = "1",
      this.loadingData = false,
      this.fetchFromTab = false,
      this.isVideo = true,
      this.response,
      this.products,
      this.playVideo = true,
      this.muteVideo = true,
      this.productsold,
      this.orginalProoducts,
      this.fetchData = false});

  String fetchHome, pageNumber;
  HomeModel? response;
  bool? loadingData;
  bool? fetchFromTab;
  bool? playVideo;
  bool? muteVideo;
  bool? isVideo;
  List<Products>? products;
  List<Products>? productsold;
  List<Products>? orginalProoducts;
  bool fetchData;
  @override
  List<Object?> get props => [
        fetchHome,
        pageNumber,
        loadingData,
        isVideo,
        response,
        playVideo,
        products,
        muteVideo,
        fetchFromTab,
        productsold,
        orginalProoducts,
        fetchData
      ];
  HomeState copyWith(
          {String? fetchHome,
          String? pageNumber,
          bool? loadingData,
          bool? isVideo,
          bool? playVideo,
          bool? muteVideo,
          List<Products>? products,
          List<Products>? productsold,
          List<Products>? orginalProoducts,
          bool? fetchData,
          bool? fetchFromTab,
          HomeModel? response}) =>
      HomeState(
        fetchHome: fetchHome ?? this.fetchHome,
        muteVideo: muteVideo ?? this.muteVideo,
        isVideo: isVideo ?? this.isVideo,
        playVideo: playVideo ?? this.playVideo,
        orginalProoducts: orginalProoducts ?? this.orginalProoducts,
        loadingData: loadingData ?? this.loadingData,
        pageNumber: pageNumber ?? this.pageNumber,
        fetchFromTab: fetchFromTab ?? this.fetchFromTab,
        products: products ?? this.products,
        productsold: productsold ?? this.productsold,
        response: response ?? this.response,
        fetchData: fetchData ?? this.fetchData,
      );
}

class ProductDetailsState extends Equatable {
  ProductDetailsState({this.productDetails});

  ProductDetailsModel? productDetails;

  @override
  List<Object?> get props => [productDetails];

  ProductDetailsState copyWith({ProductDetailsModel? productDetails}) =>
      ProductDetailsState(
        productDetails: productDetails ?? this.productDetails,
      );
}

class CartInitial extends ProductDetailsState {}
