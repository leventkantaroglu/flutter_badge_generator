import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_badge_generator/config/config.dart';

class OutputCodeSection extends StatelessWidget {
  final String? outputCode;
  const OutputCodeSection(this.outputCode, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.white,
      child: Stack(
        children: [
          SelectableText(
            outputCode ?? "",
            onTap: () {
              if (outputCode != null && outputCode!.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(strings.copied),
                    duration: const Duration(milliseconds: 500),
                  ),
                );
                Clipboard.setData(ClipboardData(text: outputCode));
              }
            },
          ),
          if (outputCode == "")
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_upward_rounded,
                    size: 36,
                    color: Colors.grey.shade500,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    strings.typeLink,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
