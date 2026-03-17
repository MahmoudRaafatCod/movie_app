import 'package:flutter/material.dart';

OutlineInputBorder textFormFieldDefaultOutlineInputBorder({Color borderColor = Colors.transparent}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: borderColor),
  );
}
