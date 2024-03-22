// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek/Locale/app_localization.dart';
import 'package:sheek/core/utils/app_colors.dart';
import 'package:sheek/core/utils/app_constants.dart';
import 'package:sheek/features/profile/presentation/cubit/profile_cubit.dart';

import '../../../../Locale/cubit/locale_cubit.dart';

class OrderDetails extends StatefulWidget {
  String orderId;
  OrderDetails({super.key, required this.orderId});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getOrdersDetails(context, widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    mathFunc(Match match) => '${match[1]},';
    return Scaffold(
      appBar: AppConstant.customAppbar(
          context,
          Text(
            "order_details".tr(context),
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: AppColors.primaryColor),
          ),
          [],
          true),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return state.loadingOrdersDetails
              ? const Center(
                  child:
                      CircularProgressIndicator(color: AppColors.primaryColor),
                )
              : ListView.builder(
                  itemCount: state.orderDetails == null
                      ? 0
                      : state.orderDetails!.orderItems!.isEmpty
                          ? 0
                          : state.orderDetails!.orderItems!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(35.sp),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.greyColor,
                              offset: Offset(4, 4),
                              blurRadius: 10.0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(35.0.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 350.h,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30.r),
                                  child: AppConstant.customNetworkImage(
                                    fit: BoxFit.contain,
                                    imagePath: state.orderDetails!
                                        .orderItems![index].productImg!,
                                    imageError: "assets/images/placeholder.png",
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(25.sp),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      BlocBuilder<LocaleCubit,
                                          ChangeLocaleState>(
                                        builder: (context, value) {
                                          return Text(
                                            value.locale.languageCode == 'en'
                                                ? state
                                                    .orderDetails!
                                                    .orderItems![index]
                                                    .productNameEn!
                                                : value.locale.languageCode ==
                                                        'ar'
                                                    ? state
                                                        .orderDetails!
                                                        .orderItems![index]
                                                        .productNameAr!
                                                    : state
                                                        .orderDetails!
                                                        .orderItems![index]
                                                        .productNameKu!,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 40.sp),
                                          );
                                        },
                                      ),
                                      const Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "color".tr(context),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              AppConstant.customSizedBox(10, 0),
                                              CircleAvatar(
                                                radius: 40.sp,
                                                backgroundColor:
                                                    AppConstant.getColorFromHex(
                                                        state
                                                            .orderDetails!
                                                            .orderItems![index]
                                                            .productColor!),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "size".tr(context),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              AppConstant.customSizedBox(20, 0),
                                              Text(
                                                state
                                                    .orderDetails!
                                                    .orderItems![index]
                                                    .productSize!,
                                                style: TextStyle(
                                                    fontSize: 50.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      AppConstant.customSizedBox(0, 40),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${"quantity".tr(context)} : ${state.orderDetails!.orderItems![index].productQuantity!} ",
                                            style: TextStyle(
                                                fontSize: 45.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      AppConstant.customSizedBox(0, 40),
                                      state.orderDetails!.orderItems![index]
                                                  .productDiscountValue ==
                                              "0"
                                          ? Text(
                                              "${"total".tr(context)}  ${state.orderDetails!.orderItems![index].productTotalBeforeDiscount.toString().replaceAllMapped(reg, mathFunc)} د.ع",
                                              style: TextStyle(
                                                  color: AppColors.primaryColor,
                                                  fontSize: 35.0.sp,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${"before_discount".tr(context)} : ${state.orderDetails!.orderItems![index].productTotalBeforeDiscount.toString().replaceAllMapped(reg, mathFunc)} د.ع",
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .primaryColor,
                                                      fontSize: 35.0.sp,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  "${"after_discount".tr(context)} : ${state.orderDetails!.orderItems![index].productTotalAfterDiscount.toString().replaceAllMapped(reg, mathFunc)} د.ع",
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .primaryColor,
                                                      fontSize: 35.0.sp,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ).animate().fade(duration: 500.ms).scale(delay: 500.ms);
                  },
                );
        },
      ),
    );
  }
}
