import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// 1) 텍스트 속성은 아래 페이지에서 설정해 m2 스타일 코드를 간편 생성할 수 있다.
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

// 2) 그리고 위 코드는 아래처럼 구글 폰트에 지정된 폰트별 정적테마 코드를 통째로 가져오는 방법도 있다.
// TextTheme textTheme = GoogleFonts.robotoTextTheme(); // roboto 폰트 텍스트 테마 일체
TextTheme textTheme2 = GoogleFonts.itimTextTheme(); // iTim 폰트 텍스트 테마 일체

TextTheme textTheme2dark = GoogleFonts.itimTextTheme(
  ThemeData(brightness: Brightness.dark).textTheme, // 기본 테마 밝기 변경(다크모드용)
);

// 3) Typography 를 적용하는 방법도 있다.
//  구글폰트가 아닌, 플러터 기본 내장 코드 Typography 를 사용하는 방식인데,
//  이 또한, 1)처럼 일일이 geometry 세부 설정을 거칠 필요 없이,
//  2)처럼 정적인 테마 내 기본 세부설정을 그대로 가져와 사용할 수 있다.
//    너비, 높이, 간격, 크기 등의 속성을 통칭하는 geometry 속성이 Typography 내에서는 제외되기 때문
TextTheme textTheme3 = Typography.blackMountainView;
TextTheme textTheme3dark = Typography.whiteMountainView;
