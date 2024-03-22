import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sheek/features/auth/data/datasources/forget_password_ds.dart';
import 'package:sheek/features/auth/data/datasources/login_ds.dart';
import 'package:sheek/features/auth/data/datasources/signUp_ds.dart';
import 'package:sheek/features/auth/data/repositories/forget_password_repo.dart';
import 'package:sheek/features/auth/data/repositories/login_repo.dart';
import 'package:sheek/features/auth/data/repositories/signUp_repo.dart';
import 'package:sheek/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:sheek/features/cart/data/datasources/address_ds.dart';
import 'package:sheek/features/cart/data/datasources/cart_ds.dart';
import 'package:sheek/features/cart/data/datasources/checkout_ds.dart';
import 'package:sheek/features/cart/data/repositories/cart_repo.dart';
import 'package:sheek/features/cart/data/repositories/checkout_repo.dart';
import 'package:sheek/features/cart/data/repositories/myAddress_repo.dart';
import 'package:sheek/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:sheek/features/categories/data/datasources/categories_ds.dart';
import 'package:sheek/features/categories/data/repositories/categories_repo.dart';
import 'package:sheek/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:sheek/features/home/data/datasources/home_ds.dart';
import 'package:sheek/features/home/data/datasources/productDetails_ds.dart';
import 'package:sheek/features/home/data/repositories/home_repo.dart';
import 'package:sheek/features/home/data/repositories/productDetails_repo.dart';
import 'package:sheek/features/home/presentation/cubit/home_cubit.dart';
import 'package:sheek/features/laundry/data/datasources/laundry_ds.dart';
import 'package:sheek/features/laundry/data/repositories/laundry_repo.dart';
import 'package:sheek/features/laundry/presentation/cubit/laundry_cubit.dart';
import 'package:sheek/features/profile/data/datasources/favorite_ds.dart';
import 'package:sheek/features/profile/data/datasources/orderDetails_ds.dart';
import 'package:sheek/features/profile/data/datasources/orders_ds.dart';
import 'package:sheek/features/profile/data/datasources/updateProfile_ds.dart';
import 'package:sheek/features/profile/data/repositories/favorite_repo.dart';
import 'package:sheek/features/profile/data/repositories/orderDetails_repo.dart';
import 'package:sheek/features/profile/data/repositories/orders_repo.dart';
import 'package:sheek/features/profile/data/repositories/updateProfile_repo.dart';
import 'package:sheek/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:sheek/features/shops/data/datasources/getProducts_ds.dart';
import 'package:sheek/features/shops/data/datasources/shops_ds.dart';
import 'package:sheek/features/shops/data/repositories/getProducts_repo.dart';
import 'package:sheek/features/shops/data/repositories/shops_repo.dart';
import 'package:sheek/features/shops/presentation/cubit/shops_cubit.dart';

import 'Locale/cubit/locale_cubit.dart';
import 'config/internet/cubit/internet_cubit.dart';
import 'core/utils/http_helper.dart';

final sl = GetIt.instance;
Future<void> init() async {
  sl.registerLazySingleton(() => ApiBaseHelper("https://sheek-bazar.com/app"));

  //cubit
  sl.registerFactory(() => HomeCubit(homeRepo: sl()));
  sl.registerFactory(() =>
      AuthCubit(logInRepo: sl(), signUpRepo: sl(), forgetPassswordRepo: sl()));
  sl.registerFactory(
      () => CartCubit(myAddressRepo: sl(), cartRepo: sl(), checkoutRepo: sl()));
  sl.registerFactory(() => ProductDetailsCubit(productDetailsRepo: sl()));
  sl.registerFactory(() => LocaleCubit());
  sl.registerFactory(() => InternetCubit());
  sl.registerFactory(() => ProfileCubit(
      favoriteRepo: sl(),
      updateProfileRepo: sl(),
      ordersRepo: sl(),
      orderDetailsRepo: sl()));
  sl.registerFactory(() => ShopsCubit(shopsRepo: sl(), getProductsRepo: sl()));
  sl.registerFactory(() => CategoriesCubit(categoriesRepo: sl()));
  sl.registerFactory(() => LaundryCubit(lundryRepo: sl()));
  //Repo
  sl.registerLazySingleton(() => HomeRepo(dataSource: sl()));
  sl.registerLazySingleton(() => LogInRepo(dataSource: sl()));
  sl.registerLazySingleton(() => SignUpRepo(dataSource: sl()));
  sl.registerLazySingleton(() => MyAddressRepo(dataSource: sl()));
  sl.registerLazySingleton(() => CartRepo(dataSource: sl()));
  sl.registerLazySingleton(() => FavoriteRepo(dataSource: sl()));
  sl.registerLazySingleton(() => ProductDetailsRepo(dataSource: sl()));
  sl.registerLazySingleton(() => ShopsRepo(dataSource: sl()));
  sl.registerLazySingleton(() => CategoriesRepo(dataSource: sl()));
  sl.registerLazySingleton(() => UpdateProfileRepo(dataSource: sl()));
  sl.registerLazySingleton(() => CheckoutRepo(dataSource: sl()));
  sl.registerLazySingleton(() => GetProductsRepo(dataSource: sl()));
  sl.registerLazySingleton(() => LundryRepo(dataSource: sl()));
  sl.registerLazySingleton(() => OrdersRepo(dataSource: sl()));
  sl.registerLazySingleton(() => OrderDetailsRepo(dataSource: sl()));
  sl.registerLazySingleton(() => ForgetPassswordRepo(dataSource: sl()));
  //DataSources
  sl.registerLazySingleton(() => HomeDs(apiHelper: sl()));
  sl.registerLazySingleton(() => LogInDs(apiHelper: sl()));
  sl.registerLazySingleton(() => SignUpDs(apiHelper: sl()));
  sl.registerLazySingleton(() => AddressDs(apiHelper: sl()));
  sl.registerLazySingleton(() => CartDs(apiHelper: sl()));
  sl.registerLazySingleton(() => FavoriteDS(apiHelper: sl()));
  sl.registerLazySingleton(() => ProductDetailsDs(apiHelper: sl()));
  sl.registerLazySingleton(() => ShopsDs(apiHelper: sl()));
  sl.registerLazySingleton(() => CategoriesDS(apiHelper: sl()));
  sl.registerLazySingleton(() => UpdateProfileDS(apiHelper: sl()));
  sl.registerLazySingleton(() => CheckOutDS(apiHelper: sl()));
  sl.registerLazySingleton(() => GetProductsDS(apiHelper: sl()));
  sl.registerLazySingleton(() => LaundryDS(apiHelper: sl()));
  sl.registerLazySingleton(() => OrdersDS(apiHelper: sl()));
  sl.registerLazySingleton(() => OrderDetailsDS(apiHelper: sl()));
  sl.registerLazySingleton(() => ForgetPAsswordDS(apiHelper: sl()));

  /////External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
}
