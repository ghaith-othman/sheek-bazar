import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheek/core/utils/app_colors.dart';
import 'package:sheek/core/utils/app_constants.dart';

import 'config/internet/cubit/internet_cubit.dart';
import 'features/cart/presentation/pages/cart_screen.dart';
import 'features/home/presentation/pages/home_screen.dart';
import 'features/laundry/presentation/pages/laundry_screen.dart';
import 'features/profile/presentation/pages/profile.dart';
import 'features/shops/presentation/pages/shops_screen.dart';

class SectionsScreen extends StatefulWidget {
  final int number;
  const SectionsScreen({super.key, this.number = 0});

  @override
  State<SectionsScreen> createState() => _SectionsScreenState();
}

class _SectionsScreenState extends State<SectionsScreen> {
  late int index;
  @override
  void initState() {
    super.initState();
    context.read<InternetCubit>().whenOpenApp(context);
    setState(() {
      index = widget.number;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: index == 2
          ? null
          : ConvexAppBar(
              initialActiveIndex: index,
              items: [
                const TabItem(icon: Icons.home),
                TabItem(
                    icon: ClipRRect(
                      child: Image.asset("assets/icons/categorise_icon.png"),
                    ),
                    activeIcon: ClipRRect(
                      child: Image.asset(
                        "assets/icons/categorise_icon.png",
                        color: AppColors.primaryColor,
                      ),
                    )),
                TabItem(
                  icon: InkWell(
                    onTap: () {
                      AppConstant.customNavigation(
                          context, const CartScreen(), 0, 1);
                    },
                    child: ClipOval(
                      child: Container(
                        color: AppColors.primaryColor,
                        child: const Icon(
                          Icons.shopping_cart_outlined,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ),
                TabItem(
                  icon: ClipRRect(
                    child: Image.asset("assets/icons/collections_icon.png"),
                  ),
                  activeIcon: ClipRRect(
                    child: Image.asset(
                      "assets/icons/collections_icon.png",
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                const TabItem(icon: Icons.person),
              ],
              activeColor: AppColors.primaryColor,
              color: AppColors.greyColor,
              backgroundColor: Colors.white,
              style: TabStyle.fixedCircle,
              onTap: (i) {
                setState(() {
                  index = i;
                });
              },
            ),
      body: BlocListener<InternetCubit, InternetState>(
        listener: (context, state) {
          context.read<InternetCubit>().showSnackBarForStatus(context);
        },
        child: Builder(
          builder: (BuildContext context) {
            switch (index) {
              case 0:
                return const HomeScreen();
              case 1:
                return const LaundryScreen();
              case 2:
                return const HomeScreen();
              case 3:
                return const ShopsScreen();
              case 4:
                return const ProfileScreen();
              default:
                return Container();
            }
          },
        ),
      ),
    );
  }
}
