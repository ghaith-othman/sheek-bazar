import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek/Locale/app_localization.dart';
import 'package:sheek/features/add_product/presentation/widgets/sizes_colors_widgets.dart';

import '../../../../core/utils/app_constants.dart';

class SizesAndColorsScreen extends StatelessWidget {
  const SizesAndColorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "choose_the_available_sizes".tr(context),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.sp),
        ),
        AppConstant.customSizedBox(0, 20),
        const CategorySelectionForSizesAndColors(),
        //////////////////////////////////////////////////////////////////////////////////////////////
        AppConstant.customSizedBox(0, 50),
        const Divider(),
        AppConstant.customSizedBox(0, 50),
        //////////////////////////////////////////////////////////////////////////////////////////////
        Text(
          "choose_the_available_colors".tr(context),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.sp),
        ),
        const ColorPickerWidget()
      ],
    );
  }
}
