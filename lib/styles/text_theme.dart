import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// 텍스트 속성은 아래 페이지에서 설정해 m2 스타일 코드를 간편 생성할 수 있다.
// https://m2.material.io/design/typography/the-type-system.html#type-scale > code 복붙
// 이후, m2 속성명을 최신 m3 속성명으로 재지정(alt + enter) > 각 m3 속성에 대한 자세한 설명은
//  https://m3.material.io/styles/typography/overview 참고
TextTheme textTheme = TextTheme(
  displayLarge: GoogleFonts.openSans(
      fontSize: 95, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  displayMedium: GoogleFonts.openSans(
      fontSize: 59, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  displaySmall: GoogleFonts.openSans(fontSize: 48, fontWeight: FontWeight.w400),
  headlineMedium: GoogleFonts.openSans(
      fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headlineSmall:
      GoogleFonts.openSans(fontSize: 24, fontWeight: FontWeight.w400),
  titleLarge: GoogleFonts.openSans(
      fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  titleMedium: GoogleFonts.openSans(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  titleSmall: GoogleFonts.openSans(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyLarge: GoogleFonts.roboto(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyMedium: GoogleFonts.roboto(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  labelLarge: GoogleFonts.roboto(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  bodySmall: GoogleFonts.roboto(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  labelSmall: GoogleFonts.roboto(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);
