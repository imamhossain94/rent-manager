import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/language_controller.dart';
import '../../../controllers/product_controller.dart';
import '../../../global.dart';
import '../../../models/product.dart';
import '../../../screens/calculating/calculating_screen.dart';
import '../../../screens/home/quick_access_screen.dart';
import '../../../widgets/big_button_widget.dart';
import '../../../widgets/line_button_widget.dart';
import '../../../widgets/line_widget.dart';
import '../../../widgets/second_text_widget.dart';
import '../../../widgets/sub_text_widget.dart';

class HomeScreen extends StatelessWidget {
  ProductController productController = Get.put(ProductController());

  HomeScreen({Key? key}) : super(key: key);

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
                              "Rant Manager",
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
                            decoration: BoxDecoration(
                                color: color.red,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8))),
                            child: Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.sp),
                                child: Text(
                                  "Lite",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 11.sp),
                                ),
                              ),
                            ),
                          ),
                          Expanded(child: Container()),
                          Row(
                            children: [
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
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      LineWidget(),
                      Padding(
                        padding: EdgeInsets.only(top: 8.sp, bottom: 5.sp),
                        child: FadeInUp(
                            duration: const Duration(milliseconds: 600),
                            child: const SecondTextWidget("quick_access")),
                      ),
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        child: const SubTextWidget("quick_access_msg"),
                      ),
                      quickAccess(),
                      FadeInUp(
                          duration: const Duration(milliseconds: 500),
                          child: LineWidget()),
                      SizedBox(height: 5.sp),
                      FadeInUp(
                        duration: const Duration(milliseconds: 500),
                        child: FadeInUp(
                            duration: const Duration(milliseconds: 500),
                            child: const SecondTextWidget("options")),
                      ),
                      SizedBox(height: 5.sp),
                      FadeInUp(
                        duration: const Duration(milliseconds: 500),
                        child: const SubTextWidget("options_msg"),
                      ),
                      SizedBox(height: 5.sp),
                      mainCustomButton(
                        title: "manage_rent",
                        icon: CupertinoIcons.collections,
                      ),
                      subCustomButton(
                        title: "buildings",
                        icon: CupertinoIcons.house_alt,
                      ),
                      subCustomButton(
                        title: "flats",
                        icon: CupertinoIcons.uiwindow_split_2x1,
                      ),
                      subCustomButton(
                        title: "tenants",
                        icon: CupertinoIcons.group,
                      ),
                      subCustomButton(
                        title: "data_management",
                        icon: CupertinoIcons.chart_pie,
                      ),
                      subCustomButton(
                        title: "languages",
                        icon: CupertinoIcons.globe,
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  // QuickAccess List of Buildings
  Widget quickAccess() {
    return Padding(
      padding: EdgeInsets.only(top: 10.sp, bottom: 5.sp),
      child: Align(
        alignment: Alignment.centerLeft,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: FadeInUp(
            duration: const Duration(milliseconds: 500),
            child: SizedBox(
              height: 135.sp,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FadeInRight(
                    duration: const Duration(milliseconds: 500),
                    child: BigButtonWidget(
                      onPressed: () {
                        Get.to(
                            () => QuickAccessScreen(
                                productController: productController),
                            transition: Transition.downToUp);
                      },
                      background: color.background,
                      isDotted: true,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(CupertinoIcons.rectangle_on_rectangle_angled,
                                size: 25.sp, color: color.bigButton),
                            SizedBox(height: 8.sp),
                            Text(
                              language.homeButton1,
                              style: TextStyle(
                                  fontSize: 9.sp, color: color.bigButton),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.sp),
                  GetBuilder<ProductController>(builder: (cont) {
                    if (cont.product.length == 0) {
                      return const SizedBox.shrink();
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: cont.product.length,
                          itemBuilder: (context, index) {
                            Product product = cont.product.getAt(index);
                            if (product.isFavorite) {
                              return FadeInRight(
                                duration: Duration(
                                    milliseconds: (600 + (index * 100))),
                                child: Padding(
                                  padding: EdgeInsets.only(right: 10.sp),
                                  child: BigButtonWidget(
                                    onPressed: () {
                                      int index = cont.product.values
                                          .toList()
                                          .indexOf(product);
                                      Get.to(
                                          CalculatingScreen(
                                            tabIndex: index,
                                            productController:
                                                productController,
                                          ),
                                          transition: Transition.cupertino);
                                    },
                                    background: color.flatButton,
                                    isDotted: false,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 10.sp,
                                          right: 10.sp,
                                          left: 10.sp,
                                          top: 20.sp),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SecondTextWidget(product.name),
                                          SizedBox(height: 8.sp),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: Icon(
                                              Icons.navigate_next,
                                              color: color.subArrow,
                                              size: 20.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          });
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Main Custom Button
  Widget mainCustomButton(
      {required title, required icon, VoidCallback? onPressed}) {
    return FadeInUp(
      duration: const Duration(milliseconds: 500),
      child: LineButtonWidget(
        background: Colors.blue,
        function: onPressed ?? () {},
        leading: Icon(
          icon,
          color: color.white,
          size: 14.sp,
        ),
        title: SizedBox(
          height: 25.sp,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: TextStyle(
                color: color.white,
                fontSize: 12.sp,
              ),
            ).tr(),
          ),
        ),
        trailing: Icon(
          Icons.navigate_next,
          color: color.mainArrow,
          size: 20.sp,
        ),
      ),
    );
  }

  // Sub Custom Button
  Widget subCustomButton(
      {required title, required icon, VoidCallback? onPressed}) {
    return FadeInUp(
      duration: const Duration(milliseconds: 700),
      child: LineButtonWidget(
        background: color.flatButton,
        function: onPressed ?? () {},
        leading: Icon(
          icon,
          color: color.mainText,
          size: 14.sp,
        ),
        title: SizedBox(
          height: 25.sp,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: TextStyle(
                color: color.mainText,
                fontSize: 12.sp,
              ),
            ).tr(),
          ),
        ),
        trailing: Icon(
          Icons.navigate_next,
          color: color.subArrow,
          size: 20.sp,
        ),
      ),
    );
  }
}
