import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rent_manager/app/viewmodel/building_controller.dart';
import 'package:rent_manager/app/viewmodel/building_viewmodel.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';

import '../../../global.dart';
import '../../controllers/language_controller.dart';
import '../../model/building.dart';
import '../widgets/line_button_widget.dart';
import '../widgets/line_widget.dart';
import '../widgets/main_text_widget.dart';
import '../widgets/second_text_widget.dart';
import '../widgets/sub_text_widget.dart';
import 'buildings_add.dart';

class BuildingsView extends StatelessWidget {
  BuildingsView({Key? key, required this.controller}) : super(key: key);
  BuildingController controller;

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
                  child: MainTextWidget("buildings"),
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
                    FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      child: LineButtonWidget(
                        background: color.blue,
                        function: () {
                          var uid = const Uuid().v1();
                          Get.to(
                              () => BuildingsAdd(
                                    controller: Get.put(
                                        BuildingViewModel(
                                          uid: uid,
                                        ),
                                        tag: uid),
                                  ),
                              transition: Transition.rightToLeft);
                        },
                        leading: Icon(
                          CupertinoIcons.add,
                          color: color.white,
                          size: 14.sp,
                        ),
                        title: SizedBox(
                          height: 25.sp,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "add_building",
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
                    ),
                    FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      child: LineWidget(),
                    ),
                    SizedBox(height: 3.sp),
                    FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        child: const SecondTextWidget("edit_building")),
                    SizedBox(height: 5.sp),
                    FadeInUp(
                      duration: const Duration(milliseconds: 600),
                      child: const SubTextWidget("edit_building_helper_msg"),
                    ),
                    SizedBox(height: 5.sp),

                    GetBuilder<BuildingController>(builder: (cont) {
                      if (cont.building.length == 0) {
                        return FadeInUp(
                          duration: Duration(milliseconds: 700),
                          child: Container(
                            height: 150.sp,
                            child: Center(
                                child: Text(
                              controller2.noProduct,
                              style: TextStyle(
                                  color: color.subText, fontSize: 10.sp),
                            )),
                          ),
                        );
                      } else {
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cont.building.length,
                            itemBuilder: (context, index) {

                              Building building = cont.building.getAt(index);
                              return FadeInUp(
                                duration:
                                    Duration(milliseconds: (index * 100 + 600)),
                                child: LineButtonWidget(
                                  function: () {
                                    // Get.to(
                                    //     () => ProductsEditScreen(
                                    //           product: product,
                                    //           controller: controller,
                                    //         ),
                                    //     transition: Transition.cupertino);
                                  },
                                  title: SizedBox(
                                    height: 25.sp,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(building.name,
                                          style: TextStyle(
                                            color: color.secondText,
                                            fontSize: 12.sp,
                                          )),
                                    ),
                                  ),
                                  background: color.flatButton,
                                  trailing: Icon(
                                    Icons.navigate_next,
                                    color: color.subArrow,
                                    size: 20.sp,
                                  ),
                                ),
                              );
                            });
                      }
                    })
                  ],
                ),
              ),
            ),
          );
        });
  }
}
