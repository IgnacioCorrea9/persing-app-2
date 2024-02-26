import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomLabels {
  static TextStyle h1 = GoogleFonts.nunito(
    fontSize: 25,
    fontWeight: FontWeight.w600,
  );

  static TextStyle h4 = GoogleFonts.nunito(
    fontSize: 25,
    fontWeight: FontWeight.w600,
    color: const Color(0xFF54BDC8),
  );

  static TextStyle plateAppBar = GoogleFonts.nunito(
    fontSize: 19,
    fontWeight: FontWeight.w700,
    color: Colors.black.withOpacity(0.6),
  );

  static TextStyle h2 = GoogleFonts.nunito(
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );

  static TextStyle h3 = GoogleFonts.nunito(fontSize: 14);

  static TextStyle h5 = GoogleFonts.nunito(fontSize: 16);

  static TextStyle h6 = GoogleFonts.nunito(fontSize: 12);

  static TextStyle dateFilter = GoogleFonts.nunito(fontSize: 14);

  static TextStyle search = GoogleFonts.nunito(
    fontSize: 14,
    color: const Color(0xFF707070),
  );

  static TextStyle subtitle = GoogleFonts.nunito(
    fontSize: 16,
    color: const Color(0xFF707070),
  );

  static TextStyle numberCart = GoogleFonts.nunito(
    fontSize: 18,
    color: Colors.white,
  );

  static TextStyle smallText = GoogleFonts.nunito(
    fontSize: 10,
  );

  static TextStyle textButtonStyle = GoogleFonts.openSans(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static TextStyle customButtonTextStyle = GoogleFonts.openSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );

  static TextStyle customNavBarLabel = GoogleFonts.openSans(
    fontSize: 12,
    color: const Color(0xFFB9B9BA),
    fontWeight: FontWeight.w400,
  );
}
