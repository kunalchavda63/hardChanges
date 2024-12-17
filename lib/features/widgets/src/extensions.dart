import 'package:flutter/material.dart';

extension CustomTextStyle on TextStyle {
  TextStyle s(double s) => copyWith(fontSize: s); // fontSize
  TextStyle family(String f) => copyWith(fontFamily: f); // fontFamily

  // Map int to FontWeight using a switch statement
  TextStyle w(int weight) {
    FontWeight? fontWeight;

    switch (weight) {
      case 100:
        fontWeight = FontWeight.w100;
        break;
      case 200:
        fontWeight = FontWeight.w200;
        break;
      case 300:
        fontWeight = FontWeight.w300;
        break;
      case 400:
        fontWeight = FontWeight.w400;
        break;
      case 500:
        fontWeight = FontWeight.w500;
        break;
      case 600:
        fontWeight = FontWeight.w600;
        break;
      case 700:
        fontWeight = FontWeight.w700;
        break;
      case 800:
        fontWeight = FontWeight.w800;
        break;
      case 900:
        fontWeight = FontWeight.w900;
        break;
      default:
        throw ArgumentError("Invalid font weight: $weight. Use 100-900.");
    }

    return copyWith(fontWeight: fontWeight);
  }
  TextStyle c(Color c) => copyWith(color: c);
}
