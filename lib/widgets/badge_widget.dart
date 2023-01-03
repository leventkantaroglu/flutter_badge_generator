import 'package:flutter/material.dart';
import 'package:flutter_badge_generator/config/config.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum BadgeWidgetType {
  selected,
  collection,
  none,
}

class BadgeWidget extends StatelessWidget {
  final String? imagePath;
  final String? label;
  final Color? themeColor;
  final double fontSize;
  final BadgeWidgetType type;
  const BadgeWidget({
    required this.imagePath,
    required this.label,
    required this.type,
    required this.fontSize,
    this.themeColor = Colors.blue,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: Center(
                child: Opacity(
                  opacity: type == BadgeWidgetType.none ? 0.15 : 1,
                  child: ColorFiltered(
                    colorFilter: type == BadgeWidgetType.selected
                        ? const ColorFilter.mode(
                            Colors.transparent,
                            BlendMode.screen,
                          )
                        : const ColorFilter.matrix(<double>[
                            0.2126,
                            0.7152,
                            0.0722,
                            0,
                            0,
                            0.2126,
                            0.7152,
                            0.0722,
                            0,
                            0,
                            0.2126,
                            0.7152,
                            0.0722,
                            0,
                            0,
                            0,
                            0,
                            0,
                            1,
                            0,
                          ]),
                    child: (imagePath != null)
                        ? imagePath!.contains(".svg")
                            ? SvgPicture.asset(
                                "assets/images/badges/${imagePath!}")
                            : Image.asset("assets/images/badges/${imagePath!}")
                        : SvgPicture.asset("assets/images/badges/none.svg"),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  label ?? "",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: fontSize,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color borderColor() {
    switch (type) {
      case BadgeWidgetType.collection:
        return Colors.grey;
      case BadgeWidgetType.selected:
        return appThemeColor;
      case BadgeWidgetType.none:
        return Colors.grey.shade200;
    }
  }
}
