import 'package:flutter/material.dart';
import "package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek/Locale/app_localization.dart';
import 'package:sheek/core/utils/app_colors.dart';

class CategorySelectionForSizesAndColors extends StatefulWidget {
  const CategorySelectionForSizesAndColors({
    super.key,
  });

  @override
  State<CategorySelectionForSizesAndColors> createState() =>
      _CategorySelectionForSizesAndColorsState();
}

class _CategorySelectionForSizesAndColorsState
    extends State<CategorySelectionForSizesAndColors> {
  bool isSelecteds = false;
  bool isSelectedm = false;
  bool isSelectedl = false;
  bool isSelectedxl = false;
  bool isSelectedxxl = false;
  bool isSelectedxxxl = false;

  void handleCheckboxChange(bool value, String option) {
    setState(() {
      if (option == 's') {
        isSelecteds = !isSelecteds;
      } else if (option == 'm') {
        isSelectedm = !isSelectedm;
      } else if (option == 'l') {
        isSelectedl = !isSelectedl;
      } else if (option == 'xl') {
        isSelectedxl = !isSelectedxl;
      } else if (option == 'xxl') {
        isSelectedxxl = !isSelectedxxl;
      } else if (option == 'xxxl') {
        isSelectedxxxl = !isSelectedxxxl;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: isSelecteds,
                      onChanged: (value) => handleCheckboxChange(value!, 's'),
                    ),
                    const Text('s'),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: isSelectedm,
                      onChanged: (value) => handleCheckboxChange(value!, 'm'),
                    ),
                    const Text('m'),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: isSelectedl,
                      onChanged: (value) => handleCheckboxChange(value!, 'l'),
                    ),
                    const Text('l'),
                  ],
                ),
              ],
            ),
            ////////////////////////////////////////////////////
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: isSelectedxl,
                      onChanged: (value) => handleCheckboxChange(value!, 'xl'),
                    ),
                    const Text('xl'),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: isSelectedxxl,
                      onChanged: (value) => handleCheckboxChange(value!, 'xxl'),
                    ),
                    const Text('xxl'),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: isSelectedxxxl,
                      onChanged: (value) =>
                          handleCheckboxChange(value!, 'xxxl'),
                    ),
                    const Text('xxl'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class ColorPickerWidget extends StatefulWidget {
  const ColorPickerWidget({super.key});

  @override
  State<ColorPickerWidget> createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  bool showColorPicker = false;
  List<Color> colorsArray = [];
  Color? selectedClolor = Colors.black;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: !showColorPicker,
            child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    showColorPicker = true;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.all(20.sp),
                  child: Text("add_color".tr(context)),
                )),
          ),
          Visibility(
            visible: showColorPicker,
            child: ColorPicker(
              color: Colors.black,
              onChanged: (value) {
                setState(() {
                  selectedClolor = value;
                });
              },
              initialPicker: Picker.paletteHue,
            ),
          ),
          Visibility(visible: showColorPicker, child: const Divider()),
          Visibility(
            visible: showColorPicker,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showColorPicker = false;
                      colorsArray.add(selectedClolor!);
                      selectedClolor = Colors.black;
                    });
                  },
                  child: Text(
                    "confirm".tr(context),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showColorPicker = false;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.all(20.sp),
                      child: Text("cancel".tr(context)),
                    )),
              ],
            ),
          ),
          Visibility(visible: showColorPicker, child: const Divider()),
          SizedBox(
            width: 1.sw,
            height: 200.h,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: colorsArray.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: Stack(children: [
                    Container(
                      width: 200.sp,
                      height: 200.sp,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorsArray[index],
                        border: Border.all(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          colorsArray.removeAt(index);
                        });
                      },
                      child: Container(
                        width: 75.sp,
                        height: 75.sp,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.whiteColor,
                          border: Border.all(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.close,
                            size: 50.sp,
                          ),
                        ),
                      ),
                    ),
                  ]),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
