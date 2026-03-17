import 'package:flutter/material.dart';
import 'package:movie/core/constants/extensions/context_extension.dart';

class ButtonCustom extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isSelected;
  const ButtonCustom({super.key, required this.text, required this.onPressed, this.isSelected = false,});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: isSelected? context.primaryColor : Colors.grey.shade800,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

      child: Text(text),
    );
  }
}
