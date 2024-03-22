// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek/Locale/app_localization.dart';
import 'package:sheek/Locale/cubit/locale_cubit.dart';
import 'package:sheek/core/utils/app_colors.dart';
import 'package:sheek/core/utils/app_constants.dart';
import 'package:sheek/core/utils/cache_helper.dart';
import 'package:sheek/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:sheek/features/cart/presentation/pages/my_address.dart';

import '../widgets/check_out_widgets.dart';

class CheckOutScreen extends StatefulWidget {
  final bool fromLaundry;
  const CheckOutScreen({super.key, required this.fromLaundry});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  String? addressId = "-1";
  String? deliveryFees;
  Future setValueForAddressId() async {
    setState(() {
      addressId = CacheHelper.getData(key: "ADDRESS_ID");
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().getProvinces(context);
    context.read<CartCubit>().checkFromLaundry(widget.fromLaundry);
    setValueForAddressId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppConstant.customAppbar(
            context,
            Text(
              "check_out".tr(context),
              style: TextStyle(color: AppColors.primaryColor, fontSize: 50.sp),
            ),
            [],
            true),
        bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(50.0.sp),
              child: state.loadingCheckOut
                  ? AppConstant.customLoadingElvatedButton(context)
                  : AppConstant.customElvatedButton(context, "check_out", () {
                      widget.fromLaundry
                          ? context
                              .read<CartCubit>()
                              .ckeckoutForLaundry(context)
                          : context.read<CartCubit>().ckeckout(context);
                    }),
            );
          },
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 40.0.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: 0.75.sw,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Shipping_address".tr(context),
                            style: TextStyle(
                                fontSize: 50.sp, fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                              onTap: () {
                                AppConstant.customNavigation(
                                    context, MyAddressScreen(), -1, 0);
                              },
                              child: Text(
                                "change".tr(context),
                                style: TextStyle(fontSize: 35.sp),
                              ))
                        ],
                      ),
                    ),
                    AppConstant.customSizedBox(0, 20.0),
                    BlocBuilder<CartCubit, CartState>(
                      builder: (context, state) {
                        if (addressId == "-1") {
                          return Text("add_address".tr(context));
                        } else {
                          if (state.myAddress != null) if (state
                                  .myAddress!.customerAddresses !=
                              null) {
                            for (int i = 0;
                                i < state.myAddress!.customerAddresses!.length;
                                i++) {
                              if (state.myAddress!.customerAddresses![i]
                                      .addressId ==
                                  addressId) {
                                context.read<CartCubit>().onFeeschange(state
                                    .myAddress!
                                    .customerAddresses![i]
                                    .deliveryCost!);
                                return BlocBuilder<LocaleCubit,
                                    ChangeLocaleState>(
                                  builder: (context, value) {
                                    return Column(
                                      children: [
                                        AddressCard(
                                                provinceName: value.locale
                                                            .languageCode ==
                                                        "en"
                                                    ? state.myAddress!.customerAddresses![i].provinceNameEn ??
                                                        ""
                                                    : value.locale.languageCode ==
                                                            "ar"
                                                        ? state.myAddress!.customerAddresses![i].provinceNameAr ??
                                                            ""
                                                        : state.myAddress!.customerAddresses![i].provinceNameKu ??
                                                            "",
                                                addressTitle: state
                                                        .myAddress!
                                                        .customerAddresses![i]
                                                        .addressTitle ??
                                                    "",
                                                addressNotes: state
                                                        .myAddress!
                                                        .customerAddresses![i]
                                                        .addressNotes ??
                                                    "",
                                                addressPhone: state
                                                        .myAddress!
                                                        .customerAddresses![i]
                                                        .addressPhone ??
                                                    "",
                                                addressId: state
                                                    .myAddress!
                                                    .customerAddresses![i]
                                                    .addressId!,
                                                lat: state.myAddress!.customerAddresses![i].addressLatitude!,
                                                log: state.myAddress!.customerAddresses![i].addressLongitude!)
                                            .animate()
                                            .fade(duration: 500.ms)
                                            .scale(delay: 500.ms),
                                        AppConstant.customSizedBox(0, 30),
                                        state.myAddress!.customerAddresses![i]
                                                        .addressLatitude ==
                                                    null ||
                                                state
                                                        .myAddress!
                                                        .customerAddresses![i]
                                                        .addressLatitude ==
                                                    null
                                            ? const SizedBox()
                                            : MapCard(
                                                lat: state
                                                    .myAddress!
                                                    .customerAddresses![i]
                                                    .addressLatitude!,
                                                long: state
                                                    .myAddress!
                                                    .customerAddresses![i]
                                                    .addressLongitude!,
                                              )
                                                .animate()
                                                .fade(duration: 500.ms)
                                                .scale(delay: 500.ms),
                                      ],
                                    );
                                  },
                                );
                              }
                            }
                          }
                        }
                        return const SizedBox();
                      },
                    ),
                    AppConstant.customSizedBox(0, 50.0),
                    const Billwidget()
                        .animate()
                        .fade(duration: 500.ms)
                        .scale(delay: 500.ms),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
