import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek/Locale/app_localization.dart';
import 'package:sheek/core/utils/app_colors.dart';
import 'package:sheek/core/utils/app_constants.dart';

import '../../data/models/orders_model.dart';
import '../pages/orderDetails_screen.dart';

class OrderCard extends StatelessWidget {
  final Orders order;
  final bool fromLaundry;
  const OrderCard({super.key, required this.order, this.fromLaundry = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
              color: AppColors.greyColor,
              offset: Offset(4, 4),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(50.0.sp),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${"invoice_number".tr(context)} : # ${order.orderId}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 40.sp),
                        ),
                        AppConstant.customSizedBox(0, 35),
                        Text(
                          "${"final_amount".tr(context)} : ${order.grandTotal}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 40.sp),
                        ),
                        AppConstant.customSizedBox(0, 35),
                        Text(
                          "${"order_status".tr(context)} : ${order.orderStatus}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 40.sp),
                        ),
                        AppConstant.customSizedBox(0, 35),
                        Text(
                          "${"order_date".tr(context)} : ${order.createdAt}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 40.sp),
                        ),
                      ],
                    ),
                  ),
                  AppConstant.customSizedBox(40, 0),
                  order.orderStatus == "pending"
                      ? Icon(
                          Icons.pending_actions_rounded,
                          size: 150.sp,
                          color: Colors.blue,
                        )
                      : order.orderStatus == "confirmed"
                          ? Icon(
                              Icons.check_box,
                              size: 150.sp,
                              color: Colors.yellow,
                            )
                          : order.orderStatus == "on_the_way"
                              ? Icon(
                                  Icons.delivery_dining,
                                  size: 150.sp,
                                  color: Colors.pink[900],
                                )
                              : order.orderStatus == "deliverd"
                                  ? Icon(
                                      Icons.checklist_rounded,
                                      size: 150.sp,
                                      color: Colors.green,
                                    )
                                  : Icon(
                                      Icons.cancel_rounded,
                                      size: 150.sp,
                                      color: Colors.red,
                                    )
                ],
              ),
              fromLaundry
                  ? const SizedBox()
                  : AppConstant.customSizedBox(0, 50),
              fromLaundry
                  ? const SizedBox()
                  : AppConstant.customElvatedButton(context, "order_details",
                      () {
                      AppConstant.customNavigation(context,
                          OrderDetails(orderId: order.orderId!), -1, 0);
                    })
            ],
          ),
        ),
      ),
    );
  }
}

//  Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Order #12345",
//                 style:
//                     TextStyle(fontSize: 50.0.sp, fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 "shipped".tr(context),
//                 style: TextStyle(fontSize: 30.sp),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 400.h,
//           child: ListView.builder(
//             itemCount: 2,
//             itemBuilder: (context, index) {
//               return const Item();
//             },
//           ),
//         )
//       ],
//     );
class Item extends StatelessWidget {
  const Item({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 250.0.w,
            width: 250.0.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              image: const DecorationImage(
                image: AssetImage("assets/images/onbording1.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          AppConstant.customSizedBox(20.0, 0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "#1515asdf",
                  style: TextStyle(color: AppColors.greyColor, fontSize: 35.sp),
                ),
                AppConstant.customSizedBox(0, 10),
                Text(
                  "best order best order best order best rdasdfa ",
                  style: TextStyle(fontSize: 35.sp),
                ),
                AppConstant.customSizedBox(0, 10),
                Text(
                  "240 \$",
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 35.sp,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
