// ignore_for_file: must_be_immutable

part of 'shops_cubit.dart';

class ShopsState extends Equatable {
  ShopsState(
      {this.shops,
      this.shopsFilter,
      this.products,
      this.defaultproducts,
      this.loadingProducts = false});
  ShopModel? shops;
  ShopModel? shopsFilter;
  ProductsModel? products;
  ProductsModel? defaultproducts;
  bool loadingProducts;

  @override
  List<Object?> get props =>
      [shops, shopsFilter, products, defaultproducts, loadingProducts];
  ShopsState copyWith(
          {ShopModel? shops,
          ShopModel? shopsFilter,
          ProductsModel? products,
          ProductsModel? defaultproducts,
          bool? loadingProducts}) =>
      ShopsState(
          shops: shops ?? this.shops,
          loadingProducts: loadingProducts ?? this.loadingProducts,
          shopsFilter: shopsFilter ?? this.shopsFilter,
          defaultproducts: defaultproducts ?? this.defaultproducts,
          products: products ?? this.products);
}

class ShopsInitial extends ShopsState {}
