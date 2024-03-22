import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek/Locale/app_localization.dart';
import 'package:sheek/core/utils/app_constants.dart';
import 'package:sheek/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:sheek/features/auth/presentation/pages/sign_in.dart';
import 'package:sheek/features/auth/presentation/pages/sign_up.dart';
import 'package:sheek/sections_screen.dart';

import '../../../../core/utils/app_colors.dart';
import '../pages/forget_password_screen.dart';

class FloationgIcon extends StatelessWidget {
  const FloationgIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.27,
      right: MediaQuery.of(context).size.width * 0.4,
      child: CircleAvatar(
        radius: 100.0.r,
        backgroundColor: AppColors.whiteColor,
        child: Padding(
          padding: EdgeInsets.all(8.0.sp),
          child: CircleAvatar(
            backgroundColor: AppColors.primaryColor,
            radius: 75.0.r,
            child: Padding(
              padding: EdgeInsets.all(15.0.sp),
              child: Image.asset(
                'assets/images/icon.png',
                color: AppColors.whiteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FormContainerForSignIn extends StatelessWidget {
  const FormContainerForSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.3,
      left: 0,
      right: 0,
      child: SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(75.0.r),
            ),
            child: Padding(
              padding:
                  EdgeInsets.only(top: 120.0.h, left: 80.0.w, right: 80.0.w),
              child: Column(
                children: [
                  Text(
                    "Welcome_Dakota".tr(context),
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 100.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  AppConstant.customSizedBox(0, 100),
                  TextFormFieldForSignin(
                    hint: "Enter_phone_number",
                    icon: const Icon(
                      Icons.person_outline,
                      color: AppColors.primaryColor,
                    ),
                    onChange: (value) {
                      context.read<AuthCubit>().changeUserPhone(value);
                    },
                  ),
                  AppConstant.customSizedBox(0, 50),
                  TextFormFieldForSignin(
                    hint: "password",
                    icon: const Icon(
                      Icons.lock_outline,
                      color: AppColors.primaryColor,
                    ),
                    onChange: (value) {
                      context.read<AuthCubit>().changeUserPassword(value);
                    },
                  ),
                  AppConstant.customSizedBox(0, 25),
                  Row(
                    children: [
                      AppConstant.customSizedBox(25, 0),
                      Text(
                        "forget_password".tr(context),
                        style: TextStyle(fontSize: 40.sp),
                      ),
                      AppConstant.customSizedBox(25, 0),
                      InkWell(
                        onTap: () {
                          AppConstant.customNavigation(
                              context, const ForgetPasswordScreen(), -1, 0);
                        },
                        child: Text(
                          "click_here".tr(context),
                          style: TextStyle(
                              fontSize: 40.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  AppConstant.customSizedBox(0, 100),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return state.loading == true
                          ? AppConstant.customLoadingElvatedButton(context)
                          : AppConstant.customElvatedButton(context, "sign_in",
                              () {
                              context.read<AuthCubit>().logIn(context);
                            });
                    },
                  ),
                  AppConstant.customSizedBox(0, 50),
                  AppConstant.customElvatedButton(context, "skip", () {
                    // AppConstant.customNavigation(
                    //     context, const AddProductScreen(), 0, -1);
                    AppConstant.customNavigation(
                        context, const SectionsScreen(), 0, -1);
                  }),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 50.0.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("have_account".tr(context)),
                            InkWell(
                              onTap: () {
                                AppConstant.customNavigation(
                                    context, const SignupScreen(), -1, 0);
                              },
                              child: Text(
                                "creat_account".tr(context),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ))
                ],
              ),
            )),
      ),
    );
  }
}

// ignore: must_be_immutable
class TextFormFieldForSignin extends StatelessWidget {
  String hint;
  Icon icon;
  Function onChange;
  TextFormFieldForSignin(
      {super.key,
      required this.hint,
      required this.icon,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return TextFormField(
          keyboardType:
              hint == "Enter_phone_number" ? TextInputType.number : null,
          obscureText: hint == "password"
              ? state.show
              : hint == "confirm_pass"
                  ? state.showconfirmpass
                  : false,
          decoration: InputDecoration(
            labelText: hint.tr(context),
            labelStyle: const TextStyle(color: AppColors.primaryColor),
            prefixIcon: icon,
            suffixIcon: hint == "password" || hint == "confirm_pass"
                ? InkWell(
                    onTap: () {
                      if (hint == "confirm_pass") {
                        context
                            .read<AuthCubit>()
                            .changeConfirmPasswordVisability();
                      } else {
                        context.read<AuthCubit>().changePasswordVisability();
                      }
                    },
                    child: Icon(
                      state.show && hint == "password"
                          ? Icons.visibility
                          : state.show && hint == "password"
                              ? Icons.visibility_off
                              : state.showconfirmpass && hint == "confirm_pass"
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                      color: AppColors.primaryColor,
                    ),
                  )
                : null,
          ),
          onChanged: (value) {
            onChange(value);
          },
        );
      },
    );
  }
}

class FormContainerForSignUp extends StatelessWidget {
  const FormContainerForSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.3,
      left: 0,
      right: 0,
      child: SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(75.0.h),
            ),
            child: Padding(
              padding:
                  EdgeInsets.only(top: 120.0.h, left: 80.0.w, right: 80.0.w),
              child: Column(
                children: [
                  Text(
                    "Welcome_Dakota".tr(context),
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 100.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  AppConstant.customSizedBox(0, 100),
                  TextFormFieldForSignin(
                    hint: "user_name",
                    icon: const Icon(
                      Icons.person_outline,
                      color: AppColors.primaryColor,
                    ),
                    onChange: (value) {
                      context.read<AuthCubit>().changeUserNameForSignUp(value);
                    },
                  ),
                  AppConstant.customSizedBox(0, 50),
                  TextFormFieldForSignin(
                    hint: "Enter_phone_number",
                    icon: const Icon(
                      Icons.person_outline,
                      color: AppColors.primaryColor,
                    ),
                    onChange: (value) {
                      context
                          .read<AuthCubit>()
                          .changePhoneNumberForSignUp(value);
                    },
                  ),
                  AppConstant.customSizedBox(0, 50),
                  TextFormFieldForSignin(
                    hint: "password",
                    icon: const Icon(
                      Icons.lock_outline,
                      color: AppColors.primaryColor,
                    ),
                    onChange: (value) {
                      context.read<AuthCubit>().changePasswordForSignUp(value);
                    },
                  ),
                  AppConstant.customSizedBox(0, 50),
                  TextFormFieldForSignin(
                    hint: "confirm_pass",
                    icon: const Icon(
                      Icons.repeat,
                      color: AppColors.primaryColor,
                    ),
                    onChange: (value) {
                      context
                          .read<AuthCubit>()
                          .changeConfirmPasswordForSignUp(value);
                    },
                  ),
                  AppConstant.customSizedBox(0, 100),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return state.loading == true
                          ? AppConstant.customLoadingElvatedButton(context)
                          : AppConstant.customElvatedButton(context, "sign_up",
                              () {
                              context.read<AuthCubit>().SignUp(context);
                            });
                    },
                  ),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 50.0.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("already_have_account".tr(context)),
                            InkWell(
                              onTap: () {
                                AppConstant.customNavigation(
                                    context, const SigninScreen(), 1, 0);
                              },
                              child: Text(
                                "join_with_us".tr(context),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ))
                ],
              ),
            )),
      ),
    );
  }
}

class ContainerForCongratulationScreen extends StatelessWidget {
  const ContainerForCongratulationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.3,
      left: 0,
      right: 0,
      child: SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(75.0.r),
            ),
            child: Padding(
              padding:
                  EdgeInsets.only(top: 120.0.h, left: 80.0.w, right: 80.0.w),
              child: Column(
                children: [
                  Text(
                    "success".tr(context),
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 100.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  AppConstant.customSizedBox(0, 50),
                  Text(
                    "congratulations".tr(context),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 50.0.sp,
                        height: 1.5,
                        color: const Color.fromARGB(255, 100, 100, 100)),
                  ),
                  AppConstant.customSizedBox(0, 50),
                  ClipRRect(
                    child: Image.asset("assets/images/image_success.png"),
                  ),
                  AppConstant.customSizedBox(0, 50),
                  AppConstant.customElvatedButton(context, "go_shopping", () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const SectionsScreen()),
                      (Route route) => false,
                    );
                  })
                ],
              ),
            )),
      ),
    );
  }
}
