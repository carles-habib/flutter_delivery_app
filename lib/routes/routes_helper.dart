// ignore_for_file: prefer_const_constructors

import 'package:delivery_app/features/address/presentation/address_page.dart';
import 'package:delivery_app/features/auth/presentation/sign_in_page.dart';
import 'package:delivery_app/features/cart/presentation/cart_screen.dart';
import 'package:delivery_app/features/food_details/presentation/popular_food_details_screen.dart';
import 'package:delivery_app/features/food_details/presentation/recomaended_food_details_screen.dart';
import 'package:delivery_app/features/home/presentation/home_page.dart';
import 'package:delivery_app/features/main_food/presentation/main_food_page.dart';
import 'package:delivery_app/features/payment/order_sucess_page.dart';
import 'package:delivery_app/features/payment/payment.dart';
import 'package:delivery_app/features/settings/presentation/settings_page.dart';
import 'package:delivery_app/features/splash/presentation/splash_page.dart';
import 'package:delivery_app/models/order_model.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String splashPage = '/splash-page';

  static const String intial = '/';
  static const String popularFood = '/popular-food';
  static const String recommendedFood = '/recommended-food';
  static const String cartPage = '/cart-page';
  static const String signInPage = '/sign-in-page';
  static const String addaddress = '/add-address';
  static const String settings = '/settings';
  static const String payment = '/payment';
  static const String orderSuccess = '/order-successful';

  static String getIntial() => '$intial';
  static String getSplashPage() => '$splashPage';

  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId) =>
      '$recommendedFood?pageId=$pageId';

  static String getCartPage() => '$cartPage';
  static String getSignInPage() => '$signInPage';
  static String getAddressPage() => '$addaddress';
  static String getSettingsPage() => '$settings';
  static String getPaymentPage(String id, int userID) =>
      '$payment?id=$id&userID=$userID';
  static String getOrderSuccessPage(String orderId, String status) =>
      '$orderSuccess?id=$orderId&status=$status';

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => Splashpage()),
    GetPage(name: intial, page: () => HomePage()),
    GetPage(
        name: signInPage,
        page: () => SignInPage(),
        transition: Transition.fadeIn),
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];

          return PopularFoodDetailsScreen(
            pageId: int.parse(pageId!),
            page: page!,
          );
        },
        transition: Transition.fadeIn),
    GetPage(
      name: recommendedFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        return RecomendedFoodDetailsScreen(
          pageId: int.parse(pageId!),
        );
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: cartPage,
      page: () {
        return CartScreen();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
        name: addaddress,
        page: () {
          return AddressPage();
        },
        transition: Transition.fadeIn),
    GetPage(
        name: settings,
        page: () {
          return SettingPage();
        },
        transition: Transition.fadeIn),
    GetPage(
        name: payment,
        page: () {
          return PaymentScreen(
            orderModel: OrderModel(
                id: int.parse(Get.parameters['id']!),
                userId: int.parse(Get.parameters['userID']!)),
          );
        },
        transition: Transition.fadeIn),
    GetPage(
        name: orderSuccess,
        page: () => OrderSuccessPage(
            orderID: Get.parameters['id']!,
            status: Get.parameters['status'].toString().contains('success')
                ? 1
                : 0))
  ];
}
