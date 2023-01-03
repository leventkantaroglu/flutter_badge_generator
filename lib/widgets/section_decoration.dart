import 'package:flutter/material.dart';
import 'package:flutter_badge_generator/config/config.dart';

BoxDecoration sectionDecoration([Color? bgColor]) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: appThemeColor),
    color: bgColor,
  );
}
