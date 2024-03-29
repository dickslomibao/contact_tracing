import 'package:flutter/material.dart';

Widget spacer(double height) {
  return SizedBox(
    height: height,
  );
}
const mainColor = Color(0xffDC9754);
const whiteColor = Color(0xffFBF9F7);
const blackColor = Color(0xff1F1F1F);
const txtColor = Color.fromRGBO(0, 0, 0, .8);
final roundedBtn = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(10),
);
const btnTxtStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
  color: whiteColor,
);
final outlineBtnStyle = OutlinedButton.styleFrom(
  shape: roundedBtn,
  side: const BorderSide(color: mainColor),
);
const outlineBtnTxtStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
  color: mainColor,
);
const backgroundCover = BoxDecoration(
  image: DecorationImage(
    image: AssetImage('assets/images/bg_line.png'),
    alignment: Alignment.bottomCenter,
    fit: BoxFit.cover,
    opacity: .08,
  ),
);
MaterialColor primaryColor = const MaterialColor(
  0xffDC9754,
  <int, Color>{
    50: mainColor,
    100: mainColor,
    200: mainColor,
    300: mainColor,
    400: mainColor,
    500: mainColor,
    600: mainColor,
    700: mainColor,
    800: mainColor,
    900: mainColor,
  },
);
