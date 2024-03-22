import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek/Locale/app_localization.dart';
import 'package:sheek/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:sheek/features/auth/presentation/pages/confirm_password_screen.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  void deactivate() {
    super.deactivate();
    context.read<AuthCubit>().clearForgetPasswordVar();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 25.h),
              child: Column(children: [
                Row(
                  children: [
                    Text(
                      "enter_number_for_send_message".tr(context),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 40.sp),
                    ),
                  ],
                ),
                AppConstant.customSizedBox(0, 30),
                TextFormField(
                  onChanged: (value) {
                    context
                        .read<AuthCubit>()
                        .onChangePhoneNumberForResetPassword(value);
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Enter_phone_number".tr(context),
                    labelStyle: const TextStyle(color: AppColors.primaryColor),
                    prefixIcon: const Icon(Icons.phone),
                  ),
                ),
                AppConstant.customSizedBox(0, 30),
                state.loading
                    ? AppConstant.customLoadingElvatedButton(context)
                    : AppConstant.customElvatedButton(context, "send", () {
                        context.read<AuthCubit>().sendSmS(context);
                      }),
                AppConstant.customSizedBox(0, 150),
                const Divider(),
                AppConstant.customSizedBox(0, 150),
                state.sendSMSSuccessfully!
                    ? Row(
                        children: [
                          Text(
                            "enter_pin".tr(context),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 40.sp),
                          ),
                        ],
                      )
                    : const SizedBox(),
                AppConstant.customSizedBox(0, 30),
                state.sendSMSSuccessfully!
                    ? PinCodeTextField(
                        keyboardType: TextInputType.number,
                        appContext: context,
                        length: 4,
                        onChanged: (value) {},
                        onCompleted: (value) {
                          if (state.validationCode == value) {
                            AppConstant.customNavigation(
                                context, const ConfirmPasswordScreen(), -1, 0);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: AppColors.primaryColor,
                                padding: EdgeInsets.only(
                                    bottom: 150.h,
                                    top: 50.h,
                                    left: 50.w,
                                    right: 50.w),
                                content: Text(
                                  'no_match_pin'.tr(context),
                                  style: const TextStyle(color: Colors.red),
                                ),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                        textStyle: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 75.sp,
                            fontWeight: FontWeight.bold),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        enableActiveFill: true,
                        pinTheme: PinTheme(
                            disabledColor: Colors.white,
                            selectedFillColor: Colors.white,
                            activeFillColor: Colors.white,
                            inactiveFillColor: Colors.white,
                            fieldHeight: 275.h,
                            fieldWidth: 200.w,
                            shape: PinCodeFieldShape.box,
                            activeColor: AppColors.primaryColor,
                            inactiveColor: AppColors.primaryColor,
                            selectedColor: const Color.fromARGB(153, 0, 0, 0),
                            borderRadius: BorderRadius.circular(8.sp)),
                      )
                    : const SizedBox(),
              ]),
            ),
          ),
        );
      },
    );
  }
}
