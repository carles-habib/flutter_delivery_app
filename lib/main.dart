// ignore_for_file: prefer_const_constructors

import 'package:delivery_app/controllers/cart_controller.dart';
import 'package:delivery_app/controllers/popular_product_controller.dart';
import 'package:delivery_app/controllers/recommeded_product_controller.dart';
import 'package:delivery_app/features/account/presentation/new_account_page.dart';
import 'package:delivery_app/features/address/presentation/address_page.dart';
import 'package:delivery_app/features/auth/presentation/sign_in_page.dart';
import 'package:delivery_app/features/auth/presentation/sign_up_page.dart';
import 'package:delivery_app/features/cart/presentation/cart_screen.dart';
import 'package:delivery_app/features/food_details/presentation/recomaended_food_details_screen.dart';
import 'package:delivery_app/features/main_food/presentation/main_food_page.dart';
import 'package:delivery_app/features/food_details/presentation/popular_food_details_screen.dart';
import 'package:delivery_app/features/map.dart';
import 'package:delivery_app/features/splash/presentation/splash_page.dart';
import 'package:delivery_app/my_new_map.dart';
import 'package:delivery_app/routes/routes_helper.dart';
import 'package:delivery_app/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'helper/dependencies.dart' as dep;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dep.init();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    // Get.find<PopularProductController>()
    //     .initProduct(Get.find<CartController>());

    return GetBuilder<PopularProductController>(builder: (_) {
      return GetBuilder<RecommendedProductController>(builder: (_) {
        return GetBuilder<CartController>(builder: (_) {
          return GetMaterialApp(
            theme: ThemeSevice().lightTheme,
            darkTheme: ThemeSevice().darkTheme,
            themeMode: ThemeSevice().getThemeMode(),
            debugShowCheckedModeBanner: false,
            // home: MapScreen(),
            initialRoute: RouteHelper.getSplashPage(),
            getPages: RouteHelper.routes,
          );
        });
      });
    });
  }
}
