import 'package:flutter/material.dart';

import '../config/config.dart';

class OutputCodeSection extends StatelessWidget {
  final String? outputCode;
  const OutputCodeSection(this.outputCode, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sectionWidth,
      height: 120,
      color: Colors.white,
      child: SelectableText(
        outputCode ?? "",
      ),
    );
  }
}
