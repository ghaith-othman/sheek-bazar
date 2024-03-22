import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheek/features/auth/data/repositories/forget_password_repo.dart';
import 'package:sheek/features/auth/data/repositories/login_repo.dart';
import 'package:sheek/features/auth/data/repositories/signUp_repo.dart';
import 'package:sheek/features/cart/data/repositories/cart_repo.dart';
import 'package:sheek/features/cart/data/repositories/checkout_repo.dart';
import 'package:sheek/features/cart/data/repositories/myAddress_repo.dart';
import 'package:sheek/features/categories/data/repositories/categories_repo.dart';
import 'package:sheek/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:sheek/features/home/data/repositories/productDetails_repo.dart';
import 'package:sheek/features/laundry/data/repositories/laundry_repo.dart';
import 'package:sheek/features/laundry/presentation/cubit/laundry_cubit.dart';
import 'package:sheek/features/profile/data/repositories/favorite_repo.dart';
import 'package:sheek/features/profile/data/repositories/orderDetails_repo.dart';
import 'package:sheek/features/profile/data/repositories/orders_repo.dart';
import 'package:sheek/features/profile/data/repositories/updateProfile_repo.dart';
import 'package:sheek/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:sheek/features/shops/data/repositories/getProducts_repo.dart';
import 'package:sheek/features/shops/data/repositories/shops_repo.dart';
import 'package:sheek/features/shops/presentation/cubit/shops_cubit.dart';

import 'Locale/cubit/locale_cubit.dart';
import 'config/internet/cubit/internet_cubit.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/cart/presentation/cubit/cart_cubit.dart';
import 'features/home/data/repositories/home_repo.dart';
import 'injection_container.dart' as di;

import 'features/home/presentation/cubit/home_cubit.dart';

MultiBlocProvider blocMultiProvider({required child}) {
  return MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (BuildContext context) => HomeCubit(
          homeRepo: di.sl<HomeRepo>(),
        ),
      ),
      BlocProvider(
        create: (BuildContext context) => AuthCubit(
            logInRepo: di.sl<LogInRepo>(),
            signUpRepo: di.sl<SignUpRepo>(),
            forgetPassswordRepo: di.sl<ForgetPassswordRepo>()),
      ),
      BlocProvider(
        create: (BuildContext context) => CartCubit(
            myAddressRepo: di.sl<MyAddressRepo>(),
            cartRepo: di.sl<CartRepo>(),
            checkoutRepo: di.sl<CheckoutRepo>()),
      ),
      BlocProvider(
        create: (BuildContext context) => ProfileCubit(
            orderDetailsRepo: di.sl<OrderDetailsRepo>(),
            favoriteRepo: di.sl<FavoriteRepo>(),
            ordersRepo: di.sl<OrdersRepo>(),
            updateProfileRepo: di.sl<UpdateProfileRepo>()),
      ),
      BlocProvider(
        create: (BuildContext context) => ProductDetailsCubit(
            productDetailsRepo: di.sl<ProductDetailsRepo>()),
      ),
      BlocProvider(
        create: (BuildContext context) =>
            CategoriesCubit(categoriesRepo: di.sl<CategoriesRepo>()),
      ),
      BlocProvider(
        create: (BuildContext context) => ShopsCubit(
            shopsRepo: di.sl<ShopsRepo>(),
            getProductsRepo: di.sl<GetProductsRepo>()),
      ),
      BlocProvider(
        create: (BuildContext context) => LaundryCubit(
          lundryRepo: di.sl<LundryRepo>(),
        ),
      ),
      BlocProvider(
        create: (BuildContext context) => LocaleCubit()..getSavedLAnguage(),
      ),
      BlocProvider(
        create: (BuildContext context) => InternetCubit()..checkConnection(),
      ),
    ],
    child: child,
  );
}
