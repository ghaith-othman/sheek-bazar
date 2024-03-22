import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek/Locale/app_localization.dart';
import 'package:sheek/Locale/cubit/locale_cubit.dart';
import 'package:sheek/features/add_product/presentation/pages/attachment_screen.dart';
import 'package:sheek/features/add_product/presentation/pages/sizes_colors_screen.dart';

import 'basic_info_screen.dart';
import 'categories_screen.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  int currentStep = 0;
  continueStep() {
    if (currentStep < 3) {
      setState(() {
        currentStep = currentStep + 1; //currentStep+=1;
      });
    }
  }

  cancelStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep = currentStep - 1; //currentStep-=1;
      });
    }
  }

  onStepTapped(int value) {
    setState(() {
      currentStep = value;
    });
  }

  Widget controlBuilders(context, details) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          currentStep == 0
              ? const SizedBox()
              : OutlinedButton(
                  onPressed: details.onStepCancel,
                  child: const Text('Back'),
                ),
          ElevatedButton(
            onPressed: details.onStepContinue,
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocaleCubit, ChangeLocaleState>(
        builder: (context, state) {
          return SafeArea(
            child: Stepper(
              // elevation: 0, //Horizontal Impact
              // margin: const EdgeInsets.all(0), //vertical impact
              controlsBuilder: controlBuilders,
              type: StepperType.horizontal,
              physics: const ScrollPhysics(),
              onStepTapped: onStepTapped,
              onStepContinue: continueStep,
              onStepCancel: cancelStep,
              currentStep: currentStep,
              steps: [
                Step(
                    title: Icon(
                      state.locale.languageCode == "en"
                          ? Icons.keyboard_double_arrow_right_sharp
                          : Icons.keyboard_double_arrow_left_sharp,
                      size: 50.sp,
                    ),
                    label: Text(
                      'basic_info'.tr(context),
                      style: TextStyle(
                          fontSize: state.locale.languageCode == "en"
                              ? 30.sp
                              : 25.sp),
                    ),
                    content: const BasicInfoWidget(),
                    isActive: currentStep >= 0,
                    state: currentStep >= 0
                        ? StepState.complete
                        : StepState.disabled),
                Step(
                  title: Icon(
                    state.locale.languageCode == "en"
                        ? Icons.keyboard_double_arrow_right_sharp
                        : Icons.keyboard_double_arrow_left_sharp,
                    size: 50.sp,
                  ),
                  label: Text('Categories'.tr(context),
                      style: TextStyle(
                          fontSize: state.locale.languageCode == "en"
                              ? 30.sp
                              : 25.sp)),
                  content: const CategoriesScreen(),
                  isActive: currentStep >= 0,
                  state: currentStep >= 1
                      ? StepState.complete
                      : StepState.disabled,
                ),
                Step(
                  title: Icon(
                    state.locale.languageCode == "en"
                        ? Icons.keyboard_double_arrow_right_sharp
                        : Icons.keyboard_double_arrow_left_sharp,
                    size: 50.sp,
                  ),
                  label: Text('Colors_Sizes'.tr(context),
                      style: TextStyle(
                          fontSize: state.locale.languageCode == "en"
                              ? 30.sp
                              : 25.sp)),
                  content: const SizesAndColorsScreen(),
                  isActive: currentStep >= 0,
                  state: currentStep >= 2
                      ? StepState.complete
                      : StepState.disabled,
                ),
                Step(
                  title: const Text(""),
                  label: Text('attachment'.tr(context),
                      style: TextStyle(
                          fontSize: state.locale.languageCode == "en"
                              ? 30.sp
                              : 25.sp)),
                  content: const VideoSelector(),
                  isActive: currentStep >= 0,
                  state: currentStep >= 3
                      ? StepState.complete
                      : StepState.disabled,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
