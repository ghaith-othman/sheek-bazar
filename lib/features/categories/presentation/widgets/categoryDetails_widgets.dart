// ignore_for_file: file_names, camel_case_types, must_be_immutable, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Locale/cubit/locale_cubit.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/cache_helper.dart';
import '../../../home/presentation/pages/product_details.dart';
import '../../../shops/data/models/products_model.dart';

// ignore: must_be_immutable
class productCard extends StatefulWidget {
  Products product;
  productCard({super.key, required this.product});

  @override
  State<productCard> createState() => _productCardState();
}

class _productCardState extends State<productCard> {
  String? userId;
  Future<void> fetchData() async {
    setState(() {
      userId = CacheHelper.getData(key: "USER_ID");
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    mathFunc(Match match) => '${match[1]},';
    return InkWell(
      onTap: () {
        AppConstant.customNavigation(context,
            ProductDetailsScreen(productId: widget.product.productId!), -1, 0);
      },
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0.w),
          child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey
                        .withOpacity(0.5), // Adjust color and opacity as needed
                    spreadRadius: 1, // Adjust the spread of the shadow
                    blurRadius: 5, // Adjust the blur of the shadow
                    offset:
                        const Offset(0, 3), // Adjust the offset of the shadow
                  ),
                ],
                borderRadius:
                    BorderRadius.circular(30.r), // Adjust radius as needed
                color: Colors.white, // Or any other desired background color
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.r),
                      topRight: Radius.circular(30.r),
                    ),
                    child: AppConstant.customNetworkImage(
                      height: 500.h,
                      width: 500.w,
                      fit: BoxFit.fill,
                      imagePath: widget.product.productImg!,
                      imageError: "assets/images/placeholder.png",
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 25.sp, right: 25.sp, top: 25.sp),
                        child: BlocBuilder<LocaleCubit, ChangeLocaleState>(
                          builder: (context, value) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width: 300.w,
                                    child: Description(
                                      product: widget.product,
                                    )),
                                AppConstant.customSizedBox(10, 0),
                                AppConstant.customAddFavoriteIcon(
                                    productId: widget.product.productId,
                                    userId: userId,
                                    fromFav: false)
                              ],
                            );
                          },
                        ),
                      ),
                      widget.product.productDiscount != "0"
                          ? Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25.sp),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${widget.product.productPrice!.toString().replaceAllMapped(reg, mathFunc)} د.ع",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40.sp,
                                      color: Colors.red,
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor: Colors.red,
                                    ),
                                  )
                                ],
                              ),
                            )
                          : const SizedBox(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.sp),
                        child: Row(
                          children: [
                            Text(
                              "${widget.product.productFinalPrice!.toString().replaceAllMapped(reg, mathFunc)} د.ع",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 40.sp),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ))),
    );
  }
}

class Description extends StatelessWidget {
  Products product;
  Description({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, ChangeLocaleState>(
      builder: (context, state) {
        return state.locale.languageCode == "en"
            ? product.productNameEn!.length <= 30
                ? Text(
                    product.productNameEn!,
                    style: TextStyle(fontSize: 30.sp, height: 1),
                  )
                : RichText(
                    text: TextSpan(
                      text: product.productNameEn!.substring(0, 30),
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 30.sp,
                          height: 1),
                      children: [
                        TextSpan(
                          text: " ...see more",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.sp,
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
            : state.locale.languageCode == "ar"
                ? product.productNameAr!.length <= 30
                    ? Text(
                        product.productNameAr!,
                        style: TextStyle(fontSize: 30.sp, height: 1),
                      )
                    : RichText(
                        text: TextSpan(
                          text: product.productNameAr!.substring(0, 30),
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 30.sp,
                              height: 1),
                          children: [
                            TextSpan(
                              text: " ...عرض المزيد",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30.sp,
                                height: 1,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      )
                : product.productNameKu!.length <= 30
                    ? Text(
                        product.productNameKu!,
                        style: TextStyle(fontSize: 30.sp, height: 1),
                      )
                    : RichText(
                        text: TextSpan(
                          text: product.productNameKu!.substring(0, 30),
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 30.sp,
                              height: 1),
                          children: [
                            TextSpan(
                              text: " ...see more",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30.sp,
                                height: 1,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
      },
    );
  }
}
