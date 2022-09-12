import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../global.dart';

class MainTextWidget extends StatelessWidget {
  final String text;
  const MainTextWidget(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 20.sp, color: color.mainText, fontWeight: FontWeight.w600),
    ).tr();
  }
}
