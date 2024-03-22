// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek/Locale/app_localization.dart';
import 'package:sheek/core/utils/app_colors.dart';
import 'package:sheek/core/utils/app_constants.dart';
import 'package:sheek/core/utils/cache_helper.dart';
import 'package:sheek/features/cart/presentation/pages/my_address.dart';
import 'package:sheek/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:sheek/features/profile/presentation/pages/my_favorite_screen.dart';

import '../pages/my_orders_screen.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({
    Key? key,
  }) : super(key: key);
  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  // late File _imageFile;
  // final picker = ImagePicker();
  // var userInfo;
  // var image;

  // @override
  // void initState() {
  //   super.initState();
  //   _imageFile = File('assets/images/profile_avatar.jpg');
  // }

  // Future pickImage() async {
  //   final pickedImage = await picker.pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     if (pickedImage != null) {
  //       _imageFile = File(pickedImage.path);
  //       showSelectedPhoto = false;
  //     } else {
  //       _imageFile = File('assets/images/profile_avatar.jpg');
  //     }
  //   });
  // }

  // bool showSelectedPhoto = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 450.w,
          height: 450.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(250.sp),
              image: DecorationImage(
                image: const AssetImage(
                  'assets/images/profile_avatar.jpg',
                ),
                fit: BoxFit.cover,
                onError: (exception, stackTrace) => {},
              )),
        )
        // Stack(
        //   alignment: Alignment.bottomRight,
        //   children: <Widget>[
        //     showSelectedPhoto == true
        //         ? Container(
        //             width: 450.w,
        //             height: 450.w,
        //             decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.circular(250.sp),
        //                 image: DecorationImage(
        //                   image: AssetImage(
        //                     _imageFile.path,
        //                   ),
        //                   fit: BoxFit.cover,
        //                   onError: (exception, stackTrace) => {},
        //                 )),
        //           )
        //         : CircleAvatar(
        //             radius: 225.sp,
        //             backgroundColor: Colors.grey[300],
        //             backgroundImage: _imageFile.existsSync()
        //                 ? Image.file(_imageFile).image
        //                 : const AssetImage('assets/images/profile_avatar.jpg'),
        //           ),
        //     CircleAvatar(
        //       backgroundColor: AppColors.primaryColor,
        //       child: InkWell(
        //         onTap: () {
        //           pickImage();
        //         },
        //         child: Padding(
        //             padding: EdgeInsets.all(10.sp),
        //             child: const Icon(
        //               Icons.add,
        //               color: AppColors.whiteColor,
        //             )),
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}

class MyAccountInfo extends StatefulWidget {
  const MyAccountInfo({super.key});

  @override
  State<MyAccountInfo> createState() => _MyAccountInfoState();
}

class _MyAccountInfoState extends State<MyAccountInfo> {
  String? userNameValue, phoneNumberValue, passwordValue;
  Future<void> getData() async {
    setState(() {
      userNameValue = CacheHelper.getData(key: "USER_NAME");
      phoneNumberValue = CacheHelper.getData(key: "USER_PHONENUMBER");
      passwordValue = CacheHelper.getData(key: "USER_PASSWORD");
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.0.sp),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "my_account".tr(context),
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 50.sp,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          AppConstant.customSizedBox(0, 50),
          TextFormFieldForProfile(
            hint: "user_name",
            initialValue: userNameValue,
            icon: const Icon(Icons.person),
            onChange: (String value) {
              context.read<ProfileCubit>().onUserNameChange(value);
            },
          ),
          AppConstant.customSizedBox(0, 30),
          TextFormFieldForProfile(
            initialValue: phoneNumberValue,
            hint: "Enter_phone_number",
            icon: const Icon(Icons.phone),
            onChange: (String value) {
              context.read<ProfileCubit>().onPhoneNumberChange(value);
            },
          ),
          AppConstant.customSizedBox(0, 30),
          TextFormFieldForProfile(
            initialValue: passwordValue,
            hint: "password",
            icon: const Icon(Icons.password),
            onChange: (String value) {
              context.read<ProfileCubit>().onPasswordChange(value);
            },
          ),
          AppConstant.customSizedBox(0, 30),
          AppConstant.customElvatedButton(context, "save_changes", () {
            context.read<ProfileCubit>().updateProfile(
                context, userNameValue!, passwordValue!, phoneNumberValue!);
          }),
          AppConstant.customSizedBox(0, 50),
          const Divider(),
          AppConstant.customSizedBox(0, 50),
        ],
      ),
    );
  }
}

class TextFormFieldForProfile extends StatelessWidget {
  String hint;
  String? initialValue;
  Icon icon;
  Function onChange;
  TextFormFieldForProfile(
      {super.key,
      required this.hint,
      required this.icon,
      required this.initialValue,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        labelStyle: const TextStyle(color: Colors.black),
        prefixIconColor: Colors.black,
        labelText: hint.tr(context),
        prefixIcon: icon,
      ),
      onChanged: (value) {
        onChange(value);
      },
    );
  }
}

class InformationDetails extends StatelessWidget {
  const InformationDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.0.sp),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "information_details".tr(context),
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 50.sp,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          AppConstant.customSizedBox(0, 50.0),
          InkWell(
            onTap: () {
              AppConstant.customNavigation(
                  context, const MyOrdersScreen(), 0, -1);
            },
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "my_orders".tr(context),
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 50.sp,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 75.sp,
                    ),
                  ],
                ),
                const Divider(),
              ],
            ),
          ),
          AppConstant.customSizedBox(0, 50.0),
          InkWell(
            onTap: () {
              AppConstant.customNavigation(
                  context, MyAddressScreen(fromProfile: true), 0, -1);
            },
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Shipping_address".tr(context),
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 50.sp,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 75.sp,
                    ),
                  ],
                ),
                const Divider(),
              ],
            ),
          ),
          AppConstant.customSizedBox(0, 50.0),
          InkWell(
            onTap: () {
              AppConstant.customNavigation(
                  context, const FavoriteScreen(), 0, -1);
            },
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "favorite".tr(context),
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 50.sp,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 75.sp,
                    ),
                  ],
                ),
                const Divider(),
              ],
            ),
          ),
          AppConstant.customSizedBox(0, 50.0),
          SizedBox(
            height: 175.h,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(75.r),
              child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('are_you_sure'.tr(context)),
                          actions: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('close'.tr(context)),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red),
                              onPressed: () {
                                context
                                    .read<ProfileCubit>()
                                    .deletePRofile(context);
                              },
                              child: Text('delete'.tr(context)),
                            ),
                          ],
                        );
                      },
                    );
                    // AwesomeDialog(
                    //   context: context,
                    //   animType: AnimType.scale,
                    //   dialogType: DialogType.info,
                    //   body: Center(
                    //     child: Text(
                    //       'are_you_sure'.tr(context),
                    //       style: const TextStyle(fontStyle: FontStyle.italic),
                    //     ),
                    //   ),
                    //   title: 'This is Ignored',
                    //   desc: 'This is also Ignored',
                    //   btnOkOnPress: () {
                    //     context.read<ProfileCubit>().deletePRofile(context);
                    //   },
                    // ).show();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.red,
                    ),
                  ),
                  child: Text(
                    "delete_account".tr(context),
                    style:
                        TextStyle(color: AppColors.whiteColor, fontSize: 50.sp),
                  )),
            ),
          ),
          AppConstant.customSizedBox(0, 100.0),
        ],
      ),
    );
  }
}
