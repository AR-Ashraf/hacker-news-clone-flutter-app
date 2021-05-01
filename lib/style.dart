

import 'dart:ui';

import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final chipStyle = C2ChoiceStyle(
  labelStyle: GoogleFonts.openSans(
    fontSize: 16,
    color: const Color(0xff000000),
    fontWeight: FontWeight.w700,
  ),
  color: const Color(0xffFBC91B),
  disabledColor: const Color(0xffF2F2F2),
  showCheckmark: false,
  margin: EdgeInsets.all(0),
  padding: EdgeInsets.all(5),
  brightness: Brightness.dark,

);

final newsTitle = GoogleFonts.openSans(
  fontSize: 16,
  color: const Color(0xff000000),
  fontWeight: FontWeight.w700,

);

final newsMetadata = GoogleFonts.openSans(
  fontSize: 14,
  color: const Color(0xff000000),
  fontWeight: FontWeight.w400,
);

final newsTime = GoogleFonts.openSans(
  fontSize: 12,
  color: const Color(0x80000000),
  fontWeight: FontWeight.w400,
);

final newsComments = GoogleFonts.openSans(
  fontSize: 12,
  color: const Color(0x80000000),
  fontWeight: FontWeight.w400,
);
final loadText = GoogleFonts.openSans(
  fontSize: 16,
  color: const Color(0xff000000),
  fontWeight: FontWeight.w700,
);

final loadButtonStyle = ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10)),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
        )
    ),
  backgroundColor: MaterialStateProperty.all(Color(0xffFFC700)),
  minimumSize: MaterialStateProperty.all<Size>(Size( 100,50)),
);