// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek/Locale/app_localization.dart';
import 'package:sheek/Locale/cubit/locale_cubit.dart';
import 'package:sheek/core/utils/cache_helper.dart';
import 'package:sheek/features/auth/presentation/pages/sign_in.dart';
import 'package:sheek/features/cart/presentation/pages/my_address.dart';
import 'package:sheek/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:sheek/features/profile/presentation/pages/my_orders_screen.dart';
import '../../features/contact_us/contactUs_screen.dart';
import '../../features/contact_us/privacy.dart';
import '../../sections_screen.dart';
import '../../features/contact_us/term.dart';
import 'app_colors.dart';

class AppConstant {
  static customNavigation(
      BuildContext context, Widget screen, double x, double y) async {
    await Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: Offset(x, y),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return screen;
        },
      ),
    );
  }

  static customElvatedButton(
      BuildContext context, String title, Function onpress) {
    return SizedBox(
      height: 175.h,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(75.r),
        child: ElevatedButton(
            onPressed: () {
              onpress();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                AppColors.primaryColor,
              ),
            ),
            child: Text(
              title.tr(context),
              style: TextStyle(color: AppColors.whiteColor, fontSize: 50.sp),
            )),
      ),
    );
  }

  static customLoadingElvatedButton(BuildContext context) {
    return SizedBox(
      height: 175.h,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(75.r),
        child: ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                AppColors.primaryColor,
              ),
            ),
            child: const CircularProgressIndicator(
              color: AppColors.whiteColor,
            )),
      ),
    );
  }

  static customSizedBox(double width, double height) {
    return SizedBox(
      width: width.w,
      height: height.h,
    );
  }

  static customDrawer(BuildContext context, {bool isGuest = false}) {
    return BlocBuilder<LocaleCubit, ChangeLocaleState>(
      builder: (context, state) {
        return Drawer(
          backgroundColor: AppColors.whiteColor,
          surfaceTintColor: AppColors.whiteColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              // Drawer header with logo
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Center(
                    child: Image.asset(
                  'assets/images/icon.png',
                  width: 100,
                  height: 100,
                )),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "change_language".tr(context),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    BlocBuilder<LocaleCubit, ChangeLocaleState>(
                      builder: (context, state) {
                        return DropdownButton<String>(
                            dropdownColor: AppColors.whiteColor,
                            value: state.locale.languageCode,
                            items: ['ar', 'en'].map((String items) {
                              return DropdownMenuItem<String>(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                context
                                    .read<LocaleCubit>()
                                    .changeLanguage(newValue);
                              }
                            });
                      },
                    )
                  ],
                ),
              ),
              const Divider(),
              ListTile(
                title: Text(
                  'Home'.tr(context),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const SectionsScreen(),
                    ),
                  );
                  // AppConstant.customNavigation(
                  //     context, const SectionsScreen(), -1, 0);
                },
              ),
              ListTile(
                title: Text('my_orders'.tr(context),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                onTap: () {
                  Navigator.pop(context);
                  AppConstant.customNavigation(
                      context, const MyOrdersScreen(), -1, 0);
                },
              ),
              ListTile(
                title: Text('Shipping_address'.tr(context),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                onTap: () {
                  Navigator.pop(context);
                  AppConstant.customNavigation(
                      context,
                      MyAddressScreen(
                        fromProfile: true,
                      ),
                      -1,
                      0);
                },
              ),
              ListTile(
                title: Text('contact_us'.tr(context),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                onTap: () {
                  Navigator.pop(context);
                  AppConstant.customNavigation(
                      context, const ContactUsScreen(), -1, 0);
                },
              ),
              ListTile(
                title: Text('privacy'.tr(context),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                onTap: () {
                  Navigator.pop(context);
                  AppConstant.customNavigation(
                      context, const PrivactScreen(), -1, 0);
                },
              ),
              ListTile(
                title: Text('terms'.tr(context),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                onTap: () {
                  Navigator.pop(context);
                  AppConstant.customNavigation(
                      context, const TermsScreen(), -1, 0);
                },
              ),

              const Divider(),
              ListTile(
                title:
                    Text(isGuest ? 'log_in'.tr(context) : 'log_out'.tr(context),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                onTap: () async {
                  await CacheHelper.clearData(
                    key: "USER_NAME",
                  );
                  await CacheHelper.clearData(
                    key: "USER_ID",
                  );
                  await CacheHelper.clearData(
                    key: "CUSTOMER_ID",
                  );
                  await CacheHelper.clearData(
                    key: "SUPPLIER_ID",
                  );
                  await CacheHelper.clearData(
                    key: "USER_PASSWORD",
                  );
                  await CacheHelper.clearData(
                    key: "USER_PHONENUMBER",
                  );
                  await CacheHelper.clearData(
                    key: "ADDRESS_ID",
                  );
                  context.read<ProfileCubit>().clearMyFavorite();

                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const SigninScreen()),
                    (Route route) => false,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  static customAppbar(
      BuildContext context, Widget title, List<Widget> actions, bool canBack) {
    return AppBar(
      elevation: 5,
      surfaceTintColor: AppColors.whiteColor,
      backgroundColor: AppColors.whiteColor,
      actions: actions,
      leading: canBack
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            )
          : null,
      centerTitle: true,
      title: title,
      titleTextStyle: const TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Future<void> showOneSecondAlert(BuildContext context, String message) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        Timer(const Duration(seconds: 1), () => Navigator.pop(context));
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Container(
            margin: EdgeInsets.only(top: 0.75.sh),
            decoration: BoxDecoration(
              color: Colors.red[400],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                message.tr(context),
                style: const TextStyle(color: AppColors.whiteColor),
              ),
            ),
          ),
        );
      },
    );
  }

  static customAlert(BuildContext context, String message,
      {bool withTranslate = true, bool witherror = true}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        Timer(const Duration(seconds: 1), () => Navigator.pop(context));
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Container(
            margin: EdgeInsets.only(top: 0.75.sh),
            decoration: BoxDecoration(
              color: witherror ? Colors.red[400] : Colors.green,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                withTranslate ? message.tr(context) : message,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.whiteColor),
              ),
            ),
          ),
        );
      },
    );
  }

  static customNetworkImage({
    required String imagePath,
    String placeholder = "assets/images/placeholder.png",
    String imageError = "assets/images/placeholder.png",
    double? height,
    double? width,
    BoxFit? fit = BoxFit.fill,
  }) {
    return FadeInImage.assetNetwork(
      image: imagePath,
      fit: fit,
      height: height,
      width: width,
      placeholder: placeholder,
      imageErrorBuilder: (BuildContext context, x, u) =>
          customAssetImage(imagePath: imageError, width: width, height: height),
    );
  }

  static customAssetImage({
    required String imagePath,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    height,
    width,
    Color? color,
    BoxFit? fit = BoxFit.cover,
  }) {
    return Padding(
      padding: padding,
      child: Image.asset(
        imagePath,
        height: height?.toDouble(),
        color: color,
        width: width?.toDouble(),
        fit: fit,
      ),
    );
  }

  static Color getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  static customAddFavoriteIcon(
      {bool? fromFav, String? productId, String? userId}) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (userId != null) {
          if (fromFav!) {
            return const Icon(
              Icons.favorite,
              color: Colors.red,
            );
          } else {
            if (state.myFavorite != null) {
              bool isFav = false;
              String favID = "";
              for (int i = 0;
                  i < state.myFavorite!.wishlistItems!.length;
                  i++) {
                if (state.myFavorite!.wishlistItems![i].productId ==
                    productId) {
                  isFav = true;
                  favID = state.myFavorite!.wishlistItems![i].id!;
                }
              }
              if (isFav) {
                return InkWell(
                  onTap: () {
                    context
                        .read<ProfileCubit>()
                        .deleteFromMyFavorite(context, favID);
                  },
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                );
              } else {
                return InkWell(
                  onTap: fromFav
                      ? () {}
                      : () {
                          context
                              .read<ProfileCubit>()
                              .insertToMyFavorite(context, productId!);
                        },
                  child: const Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                  ),
                );
              }
            } else {
              return InkWell(
                onTap: productId == null
                    ? () {}
                    : () {
                        context
                            .read<ProfileCubit>()
                            .insertToMyFavorite(context, productId);
                      },
                child: const Icon(
                  Icons.favorite_border,
                  color: Colors.red,
                ),
              );
            }
          }
        } else {
          return InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AppColors.primaryColor,
                  padding: EdgeInsets.only(
                      bottom: 150.h, top: 50.h, left: 50.w, right: 50.w),
                  content: Text('log_in_to_enjoy_these_benefits'.tr(context)),
                  duration: const Duration(seconds: 2), // Optional duration
                ),
              );
            },
            child: const Icon(
              Icons.favorite,
              color: Colors.red,
            ),
          );
        }
      },
    );
  }
}
