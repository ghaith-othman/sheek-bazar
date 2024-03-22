// ignore_for_file: must_be_immutable

part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  ProfileState(
      {this.userId,
      this.myFavorite,
      this.loadingFavorite = false,
      this.userName,
      this.phoneNumber,
      this.customerId,
      this.clothesOrders,
      this.orderDetails,
      this.laundryOrders,
      this.loadingOrders = false,
      this.loadingOrdersDetails = false,
      this.password});
  String? userId;
  FavoriteModel? myFavorite;
  OrdersModel? clothesOrders;
  OrderDetailsModel? orderDetails;
  OrdersModel? laundryOrders;
  bool loadingFavorite;
  bool loadingOrders;
  bool loadingOrdersDetails;
  String? userName;
  String? phoneNumber;
  String? customerId;
  String? password;

  @override
  List<Object?> get props => [
        userId,
        myFavorite,
        loadingFavorite,
        clothesOrders,
        laundryOrders,
        customerId,
        userName,
        phoneNumber,
        loadingOrders,
        loadingOrdersDetails,
        password,
        orderDetails,
      ];
  ProfileState copyWith({
    String? userId,
    String? userName,
    String? phoneNumber,
    String? password,
    String? customerId,
    FavoriteModel? myFavorite,
    OrdersModel? clothesOrders,
    OrdersModel? laundryOrders,
    OrderDetailsModel? orderDetails,
    bool? loadingFavorite,
    bool? loadingOrdersDetails,
    bool? loadingOrders,
  }) =>
      ProfileState(
          userId: userId ?? this.userId,
          userName: userName ?? this.userName,
          clothesOrders: clothesOrders ?? this.clothesOrders,
          laundryOrders: laundryOrders ?? this.laundryOrders,
          customerId: customerId ?? this.customerId,
          password: password ?? this.password,
          loadingOrders: loadingOrders ?? this.loadingOrders,
          orderDetails: orderDetails ?? this.orderDetails,
          loadingOrdersDetails:
              loadingOrdersDetails ?? this.loadingOrdersDetails,
          phoneNumber: phoneNumber ?? this.phoneNumber,
          myFavorite: myFavorite ?? this.myFavorite,
          loadingFavorite: loadingFavorite ?? this.loadingFavorite);
}

class ProfileInitial extends ProfileState {}
