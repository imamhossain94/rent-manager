import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/language_controller.dart';
import '../../controllers/product_controller.dart';
import '../../global.dart';
import '../../models/product.dart';
import '../../widgets/big_button_widget.dart';
import '../../widgets/line_button_widget.dart';
import '../../widgets/line_widget.dart';
import '../../widgets/second_text_widget.dart';
import '../../widgets/sub_text_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../controllers/language_controller.dart';
import '../../global.dart';
import '../calculating/calculating_screen.dart';
import '../data/data_view_screen.dart';
import '../language/language_screen.dart';
import '../products/products_view_screen.dart';
import 'quick_access_screen.dart';

class HomeScreen extends StatelessWidget {
  ProductController productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageController>(
        init: language,
        builder: (controller) {
          return Obx(() {
            return Scaffold(
              backgroundColor: color.background,
              appBar: AppBar(
                shadowColor: Colors.transparent.withOpacity(0.1),
                elevation: 0,
                surfaceTintColor: Colors.transparent,
                backgroundColor: color.background,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(0.sp),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.sp, right: 12),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 6.sp),
                            child: Text(
                              "Spice",
                              style: TextStyle(
                                color: color.mainText,
                                fontSize: 22.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.sp,
                          ),
                          Container(
                            height: 21.sp,
                            width: 40.sp,
                            decoration: BoxDecoration(
                                color: color.red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.only(),
                                child: Text(
                                  "v1.3.7",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 11.sp),
                                ),
                              ),
                            ),
                          ),
                          Expanded(child: Container()),
                          Row(
                            children: [
                              // IconButton(
                              //   tooltip: controller.homeToolTip1,
                              //   splashRadius: 22,
                              //   icon: Unicon(
                              //     Unicons.uniGithub,
                              //     color: color.mainText,
                              //     size: 20.sp,
                              //   ),
                              //   onPressed: () async {
                              //     if (await canLaunchUrlString(
                              //         "https://github.com/vellt"))
                              //       await launchUrlString(
                              //           "https://github.com/vellt");
                              //   },
                              // ),
                              IconButton(
                                tooltip: controller.homeToolTip2,
                                splashRadius: 22,
                                icon: Icon(
                                  (color.isDarkMode)
                                      ? Icons.light_mode
                                      : Icons.dark_mode,
                                  color: color.secondText,
                                  size: 20.sp,
                                ),
                                onPressed: () => color.changeTheme(),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              body: Padding(
                padding: EdgeInsets.only(right: 14.sp, left: 14.sp),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      LineWidget(),
                      SizedBox(height: 8.sp),
                      FadeInUp(
                          duration: Duration(milliseconds: 600),
                          child: SecondTextWidget(language.homeHeader1)),
                      SizedBox(height: 5.sp),
                      FadeInUp(
                        duration: Duration(milliseconds: 600),
                        child: SubTextWidget(language.homeDescription1),
                      ),
                      SizedBox(height: 10.sp),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: FadeInUp(
                            duration: Duration(milliseconds: 500),
                            child: Container(
                              height: 135.sp,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  FadeInRight(
                                    duration: Duration(milliseconds: 500),
                                    child: BigButtonWidget(
                                      onPressed: () {
                                        Get.to(
                                            () => QuickAccessScreen(
                                                productController:
                                                    productController),
                                            transition: Transition.downToUp);
                                      },
                                      background: color.background,
                                      isDotted: true,
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                                CupertinoIcons
                                                    .rectangle_on_rectangle_angled,
                                                size: 25.sp,
                                                color: color.bigButton),
                                            SizedBox(height: 8.sp),
                                            Text(
                                              language.homeButton1,
                                              style: TextStyle(
                                                  fontSize: 9.sp,
                                                  color: color.bigButton),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.sp),
                                  GetBuilder<ProductController>(
                                      builder: (cont) {
                                    if (cont.product.length == 0) {
                                      return Center();
                                    } else {
                                      return ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          itemCount: cont.product.length,
                                          itemBuilder: (context, index) {
                                            Product product =
                                                cont.product.getAt(index);
                                            if (product.isFavorite) {
                                              return FadeInRight(
                                                duration: Duration(
                                                    milliseconds:
                                                        (600 + (index * 100))),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 10.sp),
                                                  child: BigButtonWidget(
                                                    onPressed: () {
                                                      int index = cont
                                                          .product.values
                                                          .toList()
                                                          .indexOf(product);
                                                      Get.to(
                                                          CalculatingScreen(
                                                            tabIndex: index,
                                                            productController:
                                                                productController,
                                                          ),
                                                          transition: Transition
                                                              .cupertino);
                                                    },
                                                    background:
                                                        color.flatButton,
                                                    isDotted: false,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10.sp,
                                                          right: 10.sp,
                                                          left: 10.sp,
                                                          top: 20.sp),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          SecondTextWidget(
                                                              product.name),
                                                          SizedBox(
                                                              height: 8.sp),
                                                          Align(
                                                            alignment: Alignment
                                                                .bottomRight,
                                                            child: Icon(
                                                              Icons
                                                                  .navigate_next,
                                                              color: color
                                                                  .subArrow,
                                                              size: 20.sp,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            } else
                                              return Container();
                                          });
                                    }
                                  }),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.sp),
                      FadeInUp(
                          duration: Duration(milliseconds: 500),
                          child: LineWidget()),
                      SizedBox(height: 5.sp),
                      FadeInUp(
                        duration: Duration(milliseconds: 500),
                        child: FadeInUp(
                            duration: Duration(milliseconds: 500),
                            child: SecondTextWidget(language.homeHeader2)),
                      ),
                      SizedBox(height: 5.sp),
                      FadeInUp(
                        duration: Duration(milliseconds: 500),
                        child: SubTextWidget(language.homeDescription2),
                      ),
                      SizedBox(height: 5.sp),
                      FadeInUp(
                        duration: Duration(milliseconds: 500),
                        child: LineButtonWidget(
                          background: color.blue,
                          function: () {
                            Get.to(
                              () => CalculatingScreen(
                                tabIndex: 0,
                                productController: productController,
                              ),
                              transition: Transition.cupertino,
                            );
                          },
                          leading: Icon(
                            CupertinoIcons.collections,
                            color: color.white,
                            size: 14.sp,
                          ),
                          title: SizedBox(
                            height: 25.sp,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                language.homeButton2,
                                style: TextStyle(
                                  color: color.white,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                          ),
                          trailing: Icon(
                            Icons.navigate_next,
                            color: color.mainArrow,
                            size: 20.sp,
                          ),
                        ),
                      ),
                      FadeInUp(
                        duration: Duration(milliseconds: 600),
                        child: LineButtonWidget(
                          background: color.flatButton,
                          function: () {
                            Get.to(
                              () => ProductsViewScreen(
                                  controller: productController),
                              transition: Transition.cupertino,
                            );
                          },
                          leading: Icon(
                            CupertinoIcons.tray_full,
                            color: color.mainText,
                            size: 14.sp,
                          ),
                          title: SizedBox(
                            height: 25.sp,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                language.homeButton3,
                                style: TextStyle(
                                  color: color.mainText,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                          ),
                          trailing: Icon(
                            Icons.navigate_next,
                            color: color.subArrow,
                            size: 20.sp,
                          ),
                        ),
                      ),
                      FadeInUp(
                        duration: Duration(milliseconds: 700),
                        child: LineButtonWidget(
                          background: color.flatButton,
                          function: () {
                            Get.to(
                              () => DataViewScreen(
                                controller: productController,
                              ),
                              transition: Transition.cupertino,
                            );
                          },
                          leading: Icon(
                            CupertinoIcons.chart_pie,
                            color: color.mainText,
                            size: 14.sp,
                          ),
                          title: SizedBox(
                            height: 25.sp,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                language.homeButton4,
                                style: TextStyle(
                                  color: color.mainText,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                          ),
                          trailing: Icon(
                            Icons.navigate_next,
                            color: color.subArrow,
                            size: 20.sp,
                          ),
                        ),
                      ),
                      FadeInUp(
                        duration: Duration(milliseconds: 800),
                        child: LineButtonWidget(
                          background: color.flatButton,
                          function: () {
                            Get.to(
                              () => LanguageScreen(),
                              transition: Transition.cupertino,
                            );
                          },
                          leading: Icon(
                            CupertinoIcons.globe,
                            color: color.mainText,
                            size: 14.sp,
                          ),
                          title: SizedBox(
                            height: 25.sp,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                language.homeButton5,
                                style: TextStyle(
                                  color: color.mainText,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                          ),
                          trailing: Icon(
                            Icons.navigate_next,
                            color: color.subArrow,
                            size: 20.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }
}

//todo: duration: Duration(milliseconds: (index * 100) + 500),