import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek/Locale/app_localization.dart';

import '../../../../core/utils/app_constants.dart';
import '../widgets/categories_widgets.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "determine_the_target_group".tr(context),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.sp),
        ),
        AppConstant.customSizedBox(0, 20),
        const CategorySelection(
          firstTitle: "men",
          secondTitle: "women",
          thirdTitle: "kids",
        ),
        //////////////////////////////////////////////////////////////////////////////////////////////
        AppConstant.customSizedBox(0, 50),
        const Divider(),
        AppConstant.customSizedBox(0, 50),
        //////////////////////////////////////////////////////////////////////////////////////////////
        Text(
          "select_the_product_category".tr(context),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.sp),
        ),
        AppConstant.customSizedBox(0, 20),
        const CategorySelection(
          firstTitle: "pants",
          secondTitle: "t-shirst",
          thirdTitle: "shoes",
        ),
      ],
    );
  }
}
