import 'package:flutter_badge_generator/badge.dart';

String createOutputCode(Badge badge, String link) {
  return '<a href="$link"><img src="https://flutter-badge-generator.web.app/assets/assets/images/badges/${badge.imageName}" alt="${badge.label}" align="left" height="60" width="60" ></a>';
}
