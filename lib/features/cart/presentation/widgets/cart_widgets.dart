// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sheek/Locale/app_localization.dart';
import 'package:sheek/Locale/cubit/locale_cubit.dart';
import 'package:sheek/core/utils/app_colors.dart';
import 'package:sheek/features/cart/presentation/cubit/cart_cubit.dart';

import '../../../../core/utils/app_constants.dart';
import '../../data/models/cart_model.dart';
import '../pages/check_out.dart';

class CartItem extends StatefulWidget {
  CartItems? item;
  CartItem({super.key, required this.item});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  String countity = "1";
  int totalPrice = 0;
  int priceForOneItem = 0;
  @override
  void initState() {
    super.initState();

    setState(() {
      countity = widget.item!.productQuantity!;
      totalPrice = widget.item!.productGrandTotal!;

      priceForOneItem =
          int.parse(countity) != 0 ? totalPrice ~/ int.parse(countity) : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    mathFunc(Match match) => '${match[1]},';
    return Padding(
      padding: EdgeInsets.only(bottom: 35.0.h),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              flex: 2,
              onPressed: (context) {
                context
                    .read<CartCubit>()
                    .deleteItemFromCart(context, widget.item!.id!);
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'delete'.tr(context),
            ),
          ],
        ),
        child: BlocBuilder<LocaleCubit, ChangeLocaleState>(
          builder: (context, state) {
            return Row(
              children: [
                Expanded(
                  flex: 9,
                  child: Container(
                    height: 400.h,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: state.locale.languageCode == 'en'
                          ? BorderRadius.only(
                              bottomLeft: Radius.circular(30.0.r),
                              topLeft: Radius.circular(30.0.r),
                            )
                          : BorderRadius.only(
                              bottomRight: Radius.circular(30.0.r),
                              topRight: Radius.circular(30.0.r),
                            ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 5.0,
                          offset: const Offset(2.0, 4.0),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(30.sp),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 250.w,
                            height: 325.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.r),
                                color: AppColors.primaryColor),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30.r),
                              child: AppConstant.customNetworkImage(
                                fit: BoxFit.contain,
                                imagePath: widget.item!.productImg!,
                                imageError: "assets/images/placeholder.png",
                              ),
                            ),
                          ),
                          AppConstant.customSizedBox(10, 0),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BlocBuilder<LocaleCubit, ChangeLocaleState>(
                                  builder: (context, value) {
                                    return Text(
                                      value.locale.languageCode == 'en'
                                          ? widget.item!.productNameEn!
                                          : value.locale.languageCode == 'ar'
                                              ? widget.item!.productNameAr!
                                              : widget.item!.productNameKu!,
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
                                    BlocBuilder<CartCubit, CartState>(
                                      builder: (context, state) {
                                        return Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  countity =
                                                      (int.parse(countity) + 1)
                                                          .toString();
                                                  totalPrice = totalPrice +
                                                      priceForOneItem;
                                                });
                                                context
                                                    .read<CartCubit>()
                                                    .updateSubTotal(
                                                        state.subTotal! +
                                                            priceForOneItem);
                                                context
                                                    .read<CartCubit>()
                                                    .updateItemCart(
                                                        context,
                                                        widget.item!.id!,
                                                        countity);
                                              },
                                              child: CircleAvatar(
                                                  backgroundColor:
                                                      AppColors.primaryColor,
                                                  radius: 40.sp,
                                                  child: Icon(
                                                    Icons.add,
                                                    size: 50.sp,
                                                  )),
                                            ),
                                            AppConstant.customSizedBox(10, 0),
                                            Text(
                                              countity,
                                              style: TextStyle(
                                                  fontSize: 50.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            AppConstant.customSizedBox(10, 0),
                                            InkWell(
                                              onTap: () {
                                                if (countity != "1") {
                                                  setState(() {
                                                    totalPrice = totalPrice -
                                                        priceForOneItem;
                                                    countity =
                                                        (int.parse(countity) -
                                                                1)
                                                            .toString();
                                                  });
                                                  context
                                                      .read<CartCubit>()
                                                      .updateSubTotal(
                                                          state.subTotal! -
                                                              priceForOneItem);
                                                  context
                                                      .read<CartCubit>()
                                                      .updateItemCart(
                                                          context,
                                                          widget.item!.id!,
                                                          countity);
                                                }
                                              },
                                              child: CircleAvatar(
                                                  backgroundColor:
                                                      AppColors.primaryColor,
                                                  radius: 40.sp,
                                                  child: Icon(
                                                    Icons.remove,
                                                    size: 50.sp,
                                                  )),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                    Text(
                                      "${totalPrice.toString().replaceAllMapped(reg, mathFunc)} د.ع",
                                      style: TextStyle(
                                          color: AppColors.primaryColor,
                                          fontSize: 50.0.sp,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
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
                                                  widget.item!.productColor!),
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
                                          widget.item!.productSize!,
                                          style: TextStyle(
                                              fontSize: 50.sp,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 400.h,
                    padding: EdgeInsets.all(10.sp),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), // Shadow color
                          blurRadius: 5, // Blur intensity
                          spreadRadius: 2, // Spread of shadow
                          offset: const Offset(2, 2), // Offset from container
                        )
                      ],
                      borderRadius: state.locale.languageCode == 'en'
                          ? const BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10))
                          : const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft:
                                  Radius.circular(10)), // Rounded corners
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_back,
                          color: AppColors.whiteColor,
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class CutsomBottomNavForCart extends StatelessWidget {
  const CutsomBottomNavForCart({super.key});

  @override
  Widget build(BuildContext context) {
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    mathFunc(Match match) => '${match[1]},';
    return SizedBox(
      height: 350.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "sub_total".tr(context),
                  style:
                      TextStyle(fontSize: 50.sp, fontWeight: FontWeight.bold),
                ),
                BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    return Text(
                      "${state.subTotal!.toString().replaceAllMapped(reg, mathFunc)} د.ع",
                      style: TextStyle(
                          fontSize: 50.sp, fontWeight: FontWeight.bold),
                    );
                  },
                ),
              ],
            ),
            AppConstant.customSizedBox(0, 20),
            AppConstant.customElvatedButton(context, "check_out", () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const CheckOutScreen(
                          fromLaundry: false,
                        )),
              );
              // AppConstant.customNavigation(
              //     context, const CheckOutScreen(), 1, 0);
            })
          ],
        ),
      ),
    );
  }
}
