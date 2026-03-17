import 'package:flutter/material.dart';
import 'package:movie/core/constants/extensions/context_extension.dart';

class SelectedBottom extends StatelessWidget {
  final String text;
  final bool isSelected;
  final void Function()? onTap;
  const SelectedBottom({super.key , required this.text , this.isSelected = false , required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4 , horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ?  context.primaryColor : Colors.transparent ,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: context.primaryColor , width: 1.5)
        ),
        child: Text(text , style: TextStyle(color: isSelected ? Colors.white : context.primaryColor , fontSize: 16 , fontWeight: FontWeight.w500),)
      )
    );
  }
}
