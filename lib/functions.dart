import 'package:flutter_badge_generator/badge.dart';

String createOutputCode(Badge badge, String url) {
  return "![${badge.label}](https://github.com/leventkantaroglu/repository/blob/master/img/octocat.png$url)";
}
