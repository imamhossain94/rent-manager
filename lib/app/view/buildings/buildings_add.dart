import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../../../controllers/language_controller.dart';
import '../../../controllers/product_controller.dart';
import '../../../global.dart';
import '../../../models/product.dart';
import '../../../screens/products/products_add_screen.dart';
import '../../../screens/products/products_edit_screen.dart';
import '../../../widgets/input_field_widget.dart';
import '../../../widgets/line_button_widget.dart';
import '../../../widgets/line_widget.dart';
import '../../../widgets/main_text_widget.dart';
import '../../../widgets/second_text_widget.dart';
import '../../../widgets/sub_text_widget.dart';

class BuildingsAdd extends StatelessWidget {
  BuildingsAdd({Key? key, required this.controller}) : super(key: key);
  ProductController controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageController>(
        init: language,
        builder: (controller2) {
          return Scaffold(
            backgroundColor: color.background,
            appBar: AppBar(
              shadowColor: Colors.transparent.withOpacity(0.1),
              elevation: 0,
              surfaceTintColor: Colors.transparent,
              backgroundColor: color.background,
              automaticallyImplyLeading: false,
              leading: IconButton(
                tooltip: controller2.otherBack,
                icon: Icon(
                  Icons.arrow_back,
                  size: 20.sp,
                  color: color.mainText,
                ),
                onPressed: () => Get.back(),
              ),
              title: FadeInRight(
                duration: const Duration(milliseconds: 500),
                child: const Align(
                  alignment: Alignment.bottomLeft,
                  child: MainTextWidget("add_building"),
                ),
              ),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(top: 0.sp, right: 15.sp, left: 15.sp),
                child: Column(
                  children: [

                    FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      child: LineWidget(),
                    ),

                    FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      child: const SubTextWidget("add_buildings_helper_msg"),
                    ),
                    SizedBox(
                      height: 5.sp,
                    ),

                    InputFieldWidget(
                      controller: null,
                      autofocus: false,
                      labelText: "Building name",
                      textInputType: TextInputType.text,
                    ),
                    SizedBox(height: 20.sp),
                    InputFieldWidget(
                      controller: null,
                      autofocus: false,
                      labelText: "Number of floors",
                      textInputType: const TextInputType.numberWithOptions(),
                      secondLabelText: "s",
                    ),
                    SizedBox(height: 5.sp),


                    FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      child: LineWidget(),
                    ),
                    SizedBox(height: 3.sp),

                    FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        child: const SecondTextWidget("Building preview")),
                    SizedBox(height: 5.sp),
                    FadeInUp(
                      duration: const Duration(milliseconds: 600),
                      child: const SubTextWidget("Here you can build the preview and see the results"),
                    ),
                    SizedBox(height: 5.sp),


                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 5,
                        itemBuilder: (context, index) {

                          return FadeInUp(
                            duration:
                            Duration(milliseconds: (index * 100 + 600)),
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(vertical: 5.sp),
                              color: Colors.black,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: 5,
                                  scrollDirection: Axis.horizontal,

                                  itemBuilder: (context, index) {

                                    return FadeInUp(
                                      duration:
                                      Duration(milliseconds: (index * 100 + 600)),
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        margin: EdgeInsets.symmetric(horizontal: 5.sp),
                                        color: color.flatButton,

                                      ),
                                    );
                                  }),
                            ),
                          );
                        })




                  ],
                ),
              ),
            ),
          );
        });
  }
}
