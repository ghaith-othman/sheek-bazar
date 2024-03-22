// ignore_for_file: must_be_immutable, non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek/Locale/app_localization.dart';
import 'package:sheek/core/utils/app_constants.dart';
import 'package:sheek/features/categories/presentation/widgets/categoryDetails_widgets.dart';
import 'package:sheek/features/shops/presentation/cubit/shops_cubit.dart';

import '../../../../core/utils/app_colors.dart';
import '../widgets/shopDetails_widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ShopDetailsScreen extends StatefulWidget {
  String supplierId;
  ShopDetailsScreen({
    super.key,
    required this.supplierId,
  });

  @override
  State<ShopDetailsScreen> createState() => _ShopDetailsScreenState();
}

class _ShopDetailsScreenState extends State<ShopDetailsScreen> {
  @override
  void initState() {
    super.initState();

    context
        .read<ShopsCubit>()
        .getProducts(context, widget.supplierId, "-1", "-1");
  }

  @override
  void deactivate() {
    super.deactivate();
    context.read<ShopsCubit>().clearproducts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopsCubit, ShopsState>(
      builder: (context, state) {
        return Scaffold(
            appBar: state.products == null
                ? null
                : state.products!.supplierInfo!.isEmpty
                    ? null
                    : state.products!.supplierAttachments == null
                        ? CustomAppBar(
                            state.products!.supplierInfo![0].supplierName!,
                            state.products!.supplierInfo![0].supplierLogo)
                        : state.products!.supplierAttachments!.isEmpty
                            ? CustomAppBar(
                                state.products!.supplierInfo![0].supplierName!,
                                state.products!.supplierInfo![0].supplierLogo)
                            : null,
            body: state.loadingProducts
                ? const Center(
                    child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ))
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        state.products!.supplierAttachments == null
                            ? const SizedBox()
                            : state.products!.supplierAttachments!.isEmpty
                                ? const SizedBox()
                                : SizedBox(
                                    height: 1000.h,
                                    child: Stack(children: [
                                      Container(
                                        height: 800.h,
                                        width: 1.sw,
                                        color: AppColors.greyColor,
                                        child: BannersForCover(
                                          items: state
                                              .products!.supplierAttachments,
                                        ),
                                      ),
                                      ShopInfo(
                                          title: state.products!
                                              .supplierInfo![0].supplierName!,
                                          logo: state.products!.supplierInfo![0]
                                              .supplierLogo),
                                      const ArrowForBack(),
                                    ]),
                                  ),
                        AppConstant.customSizedBox(0, 40),
                        state.products!.supplierInfo![0].supplierDescription ==
                                null
                            ? const SizedBox()
                            : Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Column(
                                  children: [
                                    Text(
                                      "description".tr(context),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 50.sp,
                                          color: AppColors.primaryColor),
                                    ),
                                    Text(
                                      state.products!.supplierInfo![0]
                                          .supplierDescription!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 40.sp,
                                          color: AppColors.primaryColor),
                                    ),
                                  ],
                                ),
                              ),
                        const Divider(),
                        const SearchBox(),
                        state.products!.products!.isEmpty
                            ? SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/empty.png"),
                                    Center(
                                      child: Text(
                                        "no_products".tr(context),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : BlocBuilder<ShopsCubit, ShopsState>(
                                builder: (context, state) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        top: 25.h, right: 40.0.w, left: 40.0.w),
                                    child: GridView.count(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      crossAxisCount: 2,
                                      childAspectRatio: (250 / 400),
                                      mainAxisSpacing: 20,
                                      children: List.generate(
                                        state.products!.products!.length,
                                        (index) {
                                          return productCard(
                                            product: state
                                                .products!.products![index],
                                          )
                                              .animate()
                                              .fade(duration: 500.ms)
                                              .scale(delay: 500.ms);
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                        AppConstant.customSizedBox(0, 50)
                      ],
                    ),
                  ));
      },
    );
  }
}
