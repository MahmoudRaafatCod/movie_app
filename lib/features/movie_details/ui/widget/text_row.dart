import 'package:flutter/material.dart';
import 'package:movie/core/constants/extensions/context_extension.dart';

class TextRow extends StatelessWidget {
  final String text;
  final bool isOnTap;
  final void Function()? onTap;
  const TextRow({
    super.key,
    required this.text,
    this.isOnTap = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              color: isOnTap ? context.primaryColor : Color(0xff5b5d60),
              fontSize: 16,
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: isOnTap ? 3 : 1.5,
            width: MediaQuery.of(context).size.width * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isOnTap ? context.primaryColor : Color(0xff5b5d60),
            ),
          ),
        ],
      ),
    );
  }
}
