import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color , textColor;
  const ButtonWidget({super.key , required this.text , required this.onPressed , required this.color , this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      padding: EdgeInsets.symmetric(horizontal: 40 , vertical: 15),
      color: color,
      elevation: 50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(text , style: TextStyle(color: textColor , fontSize: 16 , fontWeight: FontWeight.bold),),
    );
  }
}
