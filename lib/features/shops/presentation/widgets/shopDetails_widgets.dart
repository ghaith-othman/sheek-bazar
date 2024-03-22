// ignore_for_file: file_names, non_constant_identifier_names

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek/Locale/app_localization.dart';

import '../../../../Locale/cubit/locale_cubit.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../categories/presentation/widgets/categories_widgets.dart';
import '../../data/models/products_model.dart';
import '../cubit/shops_cubit.dart';

class BannersForCover extends StatefulWidget {
  final List<SupplierAttachments>? items;
  const BannersForCover({super.key, required this.items});

  @override
  State<BannersForCover> createState() => _BannersForCoverState();
}

class _BannersForCoverState extends State<BannersForCover> {
  List items = [];

  @override
  void initState() {
    super.initState();
    addToItems();
  }

  Future addToItems<List>() async {
    for (int i = 0; i < widget.items!.length; i++) {
      items.add(AppConstant.customNetworkImage(
        width: 1.sw,
        fit: BoxFit.fill,
        imagePath: widget.items![i].attachmentName!,
      ));
    }
  }

  String initialPage = "1";

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = items.cast<Widget>();

    return Container(
      color: Colors.white,
      child: CarouselSlider(
        options: CarouselOptions(
          initialPage: 0,
          viewportFraction: 1,
          aspectRatio: 1,
          enableInfiniteScroll: true,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 2),
          autoPlayAnimationDuration: const Duration(seconds: 1),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
          onPageChanged: (index, reason) {},
        ),
        items: widgets,
      ),
    );
  }
}

class ShopInfo extends StatelessWidget {
  final String? title, logo;
  final bool withCoverImages;
  const ShopInfo(
      {super.key,
      required this.title,
      required this.logo,
      this.withCoverImages = true});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0.h,
      left: withCoverImages ? 125.w : 25.w,
      right: withCoverImages ? 125.w : 25.w,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 50.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 5.0,
              spreadRadius: 0.0,
              offset: const Offset(2.0, 5.0),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                title == null
                    ? const SizedBox()
                    : Text(
                        title!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 75.sp,
                            color: AppColors.primaryColor),
                      ),
              ],
            ),
            AppConstant.customSizedBox(20, 0),
            ClipOval(
              child: Container(
                  width: 250.w,
                  height: 250.w,
                  color: Colors.black,
                  child: ClipOval(
                    child: AppConstant.customNetworkImage(
                      fit: BoxFit.cover,
                      imagePath: logo ?? '',
                      imageError: "assets/images/placeholder.png",
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    List<Products> newProducts = [];

    return Padding(
      padding: EdgeInsets.only(top: 50.0.sp, right: 50.0.sp, left: 50.0.sp),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: BlocBuilder<ShopsCubit, ShopsState>(
                  builder: (context, state) {
                    return BlocBuilder<LocaleCubit, ChangeLocaleState>(
                      builder: (context, value) {
                        return TextFormField(
                          onChanged: (searchTerm) {
                            newProducts = value.locale.languageCode == "en"
                                ? state.defaultproducts!.products!
                                    .where(
                                      (Product) => Product.productNameEn!
                                          .toLowerCase()
                                          .contains(searchTerm.toLowerCase()),
                                    )
                                    .toList()
                                : value.locale.languageCode == "ar"
                                    ? state.defaultproducts!.products!
                                        .where(
                                          (Product) => Product.productNameAr!
                                              .toLowerCase()
                                              .contains(
                                                  searchTerm.toLowerCase()),
                                        )
                                        .toList()
                                    : state.defaultproducts!.products!
                                        .where(
                                          (Product) => Product.productNameKu!
                                              .toLowerCase()
                                              .contains(
                                                  searchTerm.toLowerCase()),
                                        )
                                        .toList();
                            context
                                .read<ShopsCubit>()
                                .changeSearch(newProducts);
                          },
                          decoration: InputDecoration(
                            hintText: 'Search'.tr(context),
                            border: const OutlineInputBorder(),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => const FilterBottomSheet(),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ArrowForBack extends StatelessWidget {
  const ArrowForBack({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, ChangeLocaleState>(
      builder: (context, state) {
        return Positioned(
            top: 125.h,
            left: state.locale.languageCode == "en" ? 50.w : null,
            right: state.locale.languageCode == "en" ? null : 50.w,
            child: CircleAvatar(
              backgroundColor: AppColors.primaryColor,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: AppColors.whiteColor,
                ),
              ),
            ));
      },
    );
  }
}

PreferredSizeWidget? CustomAppBar(String? title, String? logo) {
  return AppBar(
    toolbarHeight: 200.h,
    centerTitle: true,
    title: Text(
      title ?? "",
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 75.sp,
          color: AppColors.primaryColor),
    ),
    actions: [
      Padding(
        padding: EdgeInsets.all(20.0.sp),
        child: ClipOval(
          child: Container(
              width: 150.sp,
              height: 150.sp,
              color: Colors.black,
              child: ClipOval(
                child: AppConstant.customNetworkImage(
                  fit: BoxFit.cover,
                  imagePath: logo ?? '',
                  imageError: "assets/images/placeholder.png",
                ),
              )),
        ),
      ),
    ],
  );
}
