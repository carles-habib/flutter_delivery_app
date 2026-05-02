// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:delivery_app/controllers/popular_product_controller.dart';
import 'package:delivery_app/controllers/recommeded_product_controller.dart';
import 'package:delivery_app/features/food_details/presentation/popular_food_details_screen.dart';
import 'package:delivery_app/features/main_food/presentation/widgets/food_page_item.dart';
import 'package:delivery_app/features/main_food/presentation/widgets/recomended_food_item.dart';
import 'package:delivery_app/models/products_model.dart';
import 'package:delivery_app/routes/routes_helper.dart';
import 'package:delivery_app/utils/colors.dart';
import 'package:delivery_app/utils/dimensions.dart';
import 'package:delivery_app/widgets/big_text.dart';
import 'package:delivery_app/widgets/icon__text_widget.dart';
import 'package:delivery_app/widgets/small_text.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPageValue = 0.0;

  @override
  void initState() {
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PopularProductController>(builder: (popularProduct) {
          return popularProduct.isLoaded
              ? Container(
                  height: Dimensions.pageView,
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: popularProduct.popularProductList.isEmpty
                        ? 1
                        : popularProduct.popularProductList.length,
                    itemBuilder: (context, position) {
                      return FoodPageItem(
                        currentPageValue: _currentPageValue,
                        index: position,
                        popularProduct:
                            popularProduct.popularProductList[position],
                      );
                    },
                  ),
                )
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }),
        GetBuilder<PopularProductController>(builder: (popularProduct) {
          return DotsIndicator(
            dotsCount: popularProduct.popularProductList.isEmpty
                ? 1
                : popularProduct.popularProductList.length,
            position: _currentPageValue.toInt(),
            decorator: DotsDecorator(
              size: Size.square(9.0),
              activeColor: AppColors.mainColor,
              activeSize: Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          );
        }),
        SizedBox(height: Dimensions.height30),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          //padding: EdgeInsets.only(left: Dimensions.screenWidth * 0.03),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(
                  text: 'Recommended', color: Theme.of(context).canvasColor),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 3),
                child: BigText(
                  text: '.',
                  color: Colors.black26,
                ),
              ),
              SizedBox(width: Dimensions.width10),
              Container(
                margin: EdgeInsets.only(bottom: 2),
                child: SmallText(
                  text: 'food pairing',
                ),
              ),
            ],
          ),
        ),
        GetBuilder<RecommendedProductController>(builder: (recomendedProduct) {
          return recomendedProduct.isLoaded
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: recomendedProduct.recommendedProductList.length,
                  itemBuilder: (context, index) {
                    return RecommendedFoodItem(
                      productsModel:
                          recomendedProduct.recommendedProductList[index],
                      pageId: index,
                    );
                  },
                )
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        })
      ],
    );
  }
}






// Widget _buildPageItem(int index) {
//     Matrix4 matrix = Matrix4.identity();
//     if (index == _currentPageValue.floor()) {
//       var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
//       var currTrans = _height * (1 - currScale) / 2;
//       matrix = Matrix4.diagonal3Values(1, currScale, 1)
//         ..setTranslationRaw(0, currTrans, 0);
//     } else if (index == _currentPageValue.floor() + 1) {
//       var currScale =
//           _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
//       var currTrans = _height * (1 - currScale) / 2;
//       matrix = Matrix4.diagonal3Values(1, currScale, 1);
//       matrix = Matrix4.diagonal3Values(1, currScale, 1)
//         ..setTranslationRaw(0, currTrans, 0);
//     } else if (index == _currentPageValue.floor() - 1) {
//       var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
//       var currTrans = _height * (1 - currScale) / 2;
//       matrix = Matrix4.diagonal3Values(1, currScale, 1);
//       matrix = Matrix4.diagonal3Values(1, currScale, 1)
//         ..setTranslationRaw(0, currTrans, 0);
//     } else {
//       var currScale = 0.8;
//       matrix = Matrix4.diagonal3Values(1, currScale, 1)
//         ..setTranslationRaw(0, _height * (1 - currScale), 0);
//     }
//     return Transform(
//       transform: matrix,
//       child: Stack(
//         children: [
//           Container(
//             height: Dimensions.pageViewContainer,
//             margin: EdgeInsets.only(
//                 left: Dimensions.width10, right: Dimensions.width10),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(Dimensions.radius30),
//               color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
//               image: DecorationImage(
//                 fit: BoxFit.cover,
//                 image: AssetImage('assets/images/food2.png'),
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               height: Dimensions.pageViewTextContainer,
//               margin: EdgeInsets.only(
//                   left: Dimensions.width30,
//                   right: Dimensions.width30,
//                   bottom: Dimensions.height30),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(Dimensions.radius20),
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Color(0xFFe8e8e8),
//                     blurRadius: 5.0,
//                     offset: Offset(0, 5),
//                   ),
//                   BoxShadow(
//                     color: Colors.white,
//                     offset: Offset(-5, 0),
//                   ),
//                   BoxShadow(
//                     color: Colors.white,
//                     offset: Offset(5, 0),
//                   ),
//                 ],
//               ),
//               child: Container(
//                 padding: EdgeInsets.only(
//                     top: //10,
//                         Dimensions.height10,
//                     right: 15,
//                     left: 15),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     BigText(text: 'Chinese Side'),
//                     SizedBox(height: Dimensions.height10),
//                     Row(
//                       children: [
//                         Wrap(
//                           children: List.generate(
//                             5,
//                             (index) => Icon(
//                               Icons.star,
//                               color: AppColors.mainColor,
//                               size: 15,
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 10),
//                         SmallText(text: '4.5 '),
//                         SizedBox(width: 10),
//                         SmallText(text: '1111 '),
//                         SizedBox(width: 10),
//                         SmallText(text: 'comment '),
//                       ],
//                     ),
//                     SizedBox(height: Dimensions.height20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         IconTextWidget(
//                             icon: Icons.circle_sharp,
//                             text: 'Normal',
//                             iconColor: AppColors.iconColor1),
//                         IconTextWidget(
//                             icon: Icons.location_on,
//                             text: '1.5km',
//                             iconColor: AppColors.mainColor),
//                         IconTextWidget(
//                             icon: Icons.access_time_rounded,
//                             text: '32min',
//                             iconColor: AppColors.icontColor2),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }