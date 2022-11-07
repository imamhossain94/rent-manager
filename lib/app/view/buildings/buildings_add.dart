import 'package:animate_do/animate_do.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../global.dart';
import '../../controllers/language_controller.dart';
import '../../viewmodel/building_viewmodel.dart';
import '../widgets/input_field_widget.dart';
import '../widgets/line_button_widget.dart';
import '../widgets/line_widget.dart';
import '../widgets/main_text_widget.dart';
import '../widgets/second_text_widget.dart';
import '../widgets/sub_text_widget.dart';

class BuildingsAdd extends StatelessWidget {
  final BuildingViewModel controller;

  const BuildingsAdd({Key? key, required this.controller}) : super(key: key);

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
                onPressed: () {
                  Get.back();
                },
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
                      child: const SubTextWidget(
                          "Enter building name, add floor then add flats or rooms in every floor."),
                    ),
                    SizedBox(
                      height: 5.sp,
                    ),
                    FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      child: InputFieldWidget(
                        controller: controller.buildingsNameTextEditingController,
                        autofocus: false,
                        labelText: "Building name",
                        textInputType: TextInputType.text,
                      ),
                    ),
                    SizedBox(
                      height: 5.sp,
                    ),
                    Obx(() => ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.floors.length,
                          itemBuilder: (context, i) {
                            return FadeInRight(
                              duration: const Duration(milliseconds: 500),
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 10.sp),
                                decoration: BoxDecoration(
                                    color: color.background,
                                    border: Border.all(
                                        color: color.subArrow, width: 2),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5.0))),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 10.sp),
                                          child: SecondTextWidget(
                                              controller.floors[i].name),
                                        ),
                                        IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              color: color.red,
                                              size: 14.sp,
                                            ),
                                            onPressed: () {
                                              controller.floors.removeWhere(
                                                  (element) =>
                                                      element.id ==
                                                      controller.floors[i].id);
                                            })
                                      ],
                                    ),
                                    Divider(
                                      thickness: 1.sp,
                                      color: color.subArrow,
                                    ),
                                    Obx(() => ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: controller
                                            .flats[controller.floors[i].id]!
                                            .length,
                                        itemBuilder: (context, j) {
                                          return FadeInLeft(
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: LineButtonWidget(
                                                  background: color.flatButton,
                                                  function: () {
                                                    Get.to(
                                                        () => BuildingsAdd(
                                                              controller:
                                                                  controller,
                                                            ),
                                                        transition: Transition
                                                            .rightToLeft);
                                                  },
                                                  leading: Icon(
                                                    CupertinoIcons
                                                        .building_2_fill,
                                                    color: color.secondText,
                                                    size: 14.sp,
                                                  ),
                                                  title: SizedBox(
                                                    height: 25.sp,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        controller.floors[i]
                                                            .flats[j].name,
                                                        style: TextStyle(
                                                          color:
                                                              color.secondText,
                                                          fontSize: 12.sp,
                                                        ),
                                                      ).tr(),
                                                    ),
                                                  ),
                                                  trailing: Obx(() {
                                                    return j == controller.floors[i].flats.length-1? IconButton(
                                                      icon: Icon(
                                                          Icons.delete_forever,
                                                          color: color.secondText,
                                                          size: 14.sp),
                                                      onPressed: () {
                                                        controller.floors[i].flats
                                                            .removeWhere(
                                                                (element) =>
                                                            element.id ==
                                                                controller
                                                                    .floors[i]
                                                                    .flats[j]
                                                                    .id);
                                                        controller.flats.refresh();

                                                      },
                                                    ): const SizedBox.shrink();
                                                  }),
                                                ),
                                              ));
                                        })),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: helpBox(
                                          "Click here to add Flat or Room",
                                          padding: EdgeInsets.only(top: 10.sp),
                                          duration: 0, onPressed: () {
                                        controller.createFlat(
                                            controller.floors[i].id,
                                            i,
                                            controller.floors[i].flats.length);
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )),
                    SizedBox(height: 5.sp),
                    helpBox("Click here to add Floor",
                        padding: EdgeInsets.only(top: 10.sp), onPressed: () {
                      controller.createFloor(controller.floors.length);
                    }),
                    FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      child: LineButtonWidget(
                        background: color.blue,
                        function: () {
                          // Get.to(
                          //         () => BuildingsAdd(
                          //       controller: controller,
                          //     ),
                          //     transition: Transition.rightToLeft);

                          controller.saveBuilding();
                        },
                        leading: Icon(
                          CupertinoIcons.floppy_disk,
                          color: color.white,
                          size: 14.sp,
                        ),
                        title: SizedBox(
                          height: 25.sp,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Save",
                              style: TextStyle(
                                color: color.white,
                                fontSize: 12.sp,
                              ),
                            ).tr(),
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: color.mainArrow,
                          size: 20.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.sp),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget floor() {
    return FadeInUp(
      duration: const Duration(milliseconds: 500),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.sp),
        decoration: BoxDecoration(
            color: color.background,
            border: Border.all(color: color.subArrow, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(5.0))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: SecondTextWidget("Ground Floor"),
                ),
                IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: color.red,
                      size: 14.sp,
                    ),
                    onPressed: () {})
              ],
            ),
            Divider(
              thickness: 1.sp,
              color: color.subArrow,
            ),
            for (int i = 0; i < 3; i++)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: LineButtonWidget(
                  background: color.flatButton,
                  function: () {
                    Get.to(
                        () => BuildingsAdd(
                              controller: controller,
                            ),
                        transition: Transition.rightToLeft);
                  },
                  leading: Icon(
                    CupertinoIcons.building_2_fill,
                    color: color.secondText,
                    size: 14.sp,
                  ),
                  title: SizedBox(
                    height: 25.sp,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "G-1",
                        style: TextStyle(
                          color: color.secondText,
                          fontSize: 12.sp,
                        ),
                      ).tr(),
                    ),
                  ),
                  trailing: Icon(
                    Icons.delete_forever,
                    color: color.secondText,
                    size: 14.sp,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(5.sp),
                dashPattern: [5.sp, 3.sp],
                color: color.bigButton,
                strokeWidth: 2,
                child: Container(
                    width: double.infinity,
                    height: 40.sp,
                    alignment: Alignment.center,
                    child: Text(
                      "Click here to add Flat or Room",
                      style: TextStyle(fontSize: 13.sp, color: color.bigButton),
                    ).tr()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget helpBox(String msg,
      {EdgeInsets padding = const EdgeInsets.all(10),
      required VoidCallback onPressed,
      duration = 500}) {
    return FadeInUp(
      duration: Duration(milliseconds: duration),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.sp),
        child: Material(
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.all(Radius.circular(5.sp)),
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(5.sp),
              dashPattern: [5.sp, 3.sp],
              color: color.bigButton,
              strokeWidth: 2,
              child: Container(
                  width: double.infinity,
                  height: 40.sp,
                  alignment: Alignment.center,
                  child: Text(
                    "Click here to add Floor",
                    style: TextStyle(fontSize: 13.sp, color: color.bigButton),
                  ).tr()),
            ),
          ),
        ),
      ),
    );
  }
}
