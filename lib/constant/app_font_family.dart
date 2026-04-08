import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color.dart';

class AppFontFamily {
  static final TextStyle heading = GoogleFonts.orbitron(
    fontSize: 60,
    color: AppColor.white,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle scdheading = GoogleFonts.montserrat(
    fontSize: 15,
    color: AppColor.accentGreen,
    letterSpacing: 4,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle txtField = GoogleFonts.montserrat(
    fontSize: 14,
    letterSpacing: 2,
    color: AppColor.shaded,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle btn = GoogleFonts.montserrat(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle txt = GoogleFonts.poppins(color: AppColor.shaded);

  static final TextStyle rgtbtn = GoogleFonts.poppins(color: AppColor.white);

  static final TextStyle email = GoogleFonts.outfit(
    color: AppColor.white,
    fontWeight: FontWeight.bold,
    fontSize: 15,
  );

  static final TextStyle email1 = GoogleFonts.outfit(
    color: AppColor.white,
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  static final TextStyle name = GoogleFonts.poppins(
    color: AppColor.white,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle name1 = GoogleFonts.poppins(
      color: AppColor.white,
      fontWeight: FontWeight.w500,
      fontSize: 25
  );

  static final TextStyle txt1 = GoogleFonts.outfit(
    color: AppColor.white,
    fontSize: 28,
  );

  static final TextStyle txt2 = GoogleFonts.outfit(
    color: AppColor.accentGreen,
    fontSize: 25,
  );

  static final TextStyle txt3 = GoogleFonts.poppins(
    color: AppColor.shaded,
    fontSize: 13,
  );

  static final TextStyle txt4 = GoogleFonts.bebasNeue(
    letterSpacing: 1,
    color: AppColor.white,
    fontSize: 16,
  );

  static final TextStyle txt5 = GoogleFonts.poppins(
    color: AppColor.white,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle txt6 = GoogleFonts.outfit(
    color: AppColor.white,
    fontWeight: FontWeight.w500,
    fontSize: 22,
  );
}