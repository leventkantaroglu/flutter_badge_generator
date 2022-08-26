import 'package:flutter/material.dart';

class GenerateButton extends StatelessWidget {
  final VoidCallback onPressed;
  const GenerateButton({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Text("Generate"),
      onPressed: () {
        onPressed();
      },
    );
  }
}
