// ignore_for_file: deprecated_member_use, file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek/Locale/app_localization.dart';
import 'package:sheek/core/utils/app_colors.dart';
import 'package:sheek/core/utils/app_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    Future<void> openWhatsApp(String whatsappNumber) async {
      String url = Uri.encodeFull('https://wa.me/$whatsappNumber');
      // Check if WhatsApp is installed
      await canLaunch(url) ? launch(url) : print('WhatsApp not installed');
    }

    callNumber(String phoneNumber) async {
      const String url = 'tel:';
      print("Hello man");
      await canLaunch(url) ? launch(url) : print('WhatsApp not installed');
    }

    Future<void> launchEmail(String emailAddress) async {
      const String url = 'mailto:';
      if (await canLaunch(url + emailAddress)) {
        await launch(url + emailAddress);
      } else {
        print('Failed to launch email for address $emailAddress');
      }
    }

    Future<void> launchMessage(String emailAddress) async {
      const String url = 'sms:';
      if (await canLaunch(url + emailAddress)) {
        await launch(url + emailAddress);
      } else {
        print('Failed to launch email for address $emailAddress');
      }
    }

    return Scaffold(
      appBar: AppConstant.customAppbar(
          context,
          Text(
            "contact_us".tr(context),
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: AppColors.primaryColor),
          ),
          [],
          true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.w),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Center(
            child: Image.asset(
              "assets/images/contact_us.png",
              height: 750.h,
            ),
          ),
          const Divider(),
          AppConstant.customSizedBox(0, 50),
          Text(
            "social_media".tr(context),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          AppConstant.customSizedBox(0, 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  await openWhatsApp("+964750 290 7090");
                },
                child: Image.asset(
                  "assets/images/whatsapp_logo.jpeg",
                  height: 100.h,
                ),
              ),
            ],
          ),
          AppConstant.customSizedBox(0, 50),
          const Divider(),
          AppConstant.customSizedBox(0, 50),
          Text(
            "call_us".tr(context),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          AppConstant.customSizedBox(0, 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () async {
                    await callNumber("+964750 290 7090");
                  },
                  child: const CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    child: Icon(Icons.call, color: AppColors.whiteColor),
                  )),
              AppConstant.customSizedBox(50, 0),
              InkWell(
                  onTap: () async {
                    await launchMessage("+964750 290 7090");
                  },
                  child: const CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    child: Icon(Icons.mail, color: AppColors.whiteColor),
                  )),
            ],
          ),
          AppConstant.customSizedBox(0, 50),
          const Divider(),
          AppConstant.customSizedBox(0, 50),
          Text(
            "email".tr(context),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          AppConstant.customSizedBox(0, 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () async {
                    await launchEmail("Info@sheek-bazar.com");
                  },
                  child: const Text(
                    "Info@sheek-bazar.com",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
            ],
          )
        ]),
      ),
    );
  }
}
