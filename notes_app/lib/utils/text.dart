import 'package:flutter/material.dart';

Text text(
  message, {
  Color? clr,
  double? fontSize,
  FontWeight? fontWeight,
}) {
  return Text(
    message,
    style: TextStyle(
      color: clr ?? Colors.black,
      fontSize: fontSize ?? 15,
      fontWeight: fontWeight ?? FontWeight.normal,
    ),
  );
}
