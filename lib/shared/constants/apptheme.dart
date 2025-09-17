import 'package:flutter/material.dart';
import 'package:movies/shared/constants/font_manager.dart';

class AppTheme {
  static const Color primary = Color(0XFF121312);
  static const Color white = Color(0XFFF2FEFF);
  static const Color darkCharcoal = Color(0XFF282A28);
  static const Color yellow = Color(0XFFF6BD00);
  static const Color red = Color(0XFFFF5659);
  static const Color black = Color(0XFF1C1C1C);
  static const Color gray = Color(0XFF7B7B7B);
  static const Color transparentYellow = Color(0xFFF6BD00);
  static const Color grey = Color(0xFF282A28);
  static const Color headerGrey = Color(0xFFADADAD);

  // TODO: gradient colors
  static const Color gradientTop = Color.fromRGBO(18, 19, 18, 0.8);
  static const Color gradientMiddle = Color.fromRGBO(18, 19, 18, 0.6);
  static const Color gradientBottom = Color(0xFF121312);

  // Black with opacity 0.7
  static const Color black70 = Color.fromARGB(179, 0, 0, 0);

  static ThemeData lightTheme = ThemeData();

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: primary,

    appBarTheme: AppBarTheme(
      backgroundColor: primary,
      centerTitle: true,
      foregroundColor: yellow,
      titleTextStyle: TextStyle(
        color: yellow,
        fontSize: FontSizes.s16,
        fontWeight: FontWeightManager.fw400,
        fontFamily: FontStyleManager.fontFamily,
      ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: darkCharcoal,
      selectedItemColor: yellow,
      unselectedItemColor: white,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      enableFeedback: false,
      elevation: 3,
    ),

    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        fontSize: FontSizes.s16,
        fontWeight: FontWeightManager.fw400,
        color: white,
        fontFamily: FontStyleManager.fontFamily,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: darkCharcoal),
        borderRadius: BorderRadius.circular(RadiusSizes.r16),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: darkCharcoal),
        borderRadius: BorderRadius.circular(RadiusSizes.r16),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: red),
        borderRadius: BorderRadius.circular(RadiusSizes.r16),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: red),
        borderRadius: BorderRadius.circular(RadiusSizes.r16),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RadiusSizes.r16),
        ),
      ),
    ),

    textTheme: TextTheme(
      displaySmall: TextStyle(
        fontSize: FontSizes.s36,
        fontWeight: FontWeightManager.fw500,
        fontFamily: FontStyleManager.fontFamily,
        color: white,
      ),
      headlineSmall: TextStyle(
        fontSize: FontSizes.s24,
        fontWeight: FontWeightManager.fw500,
        color: white,
        fontFamily: FontStyleManager.fontFamily,
      ),
      titleLarge: TextStyle(
        fontSize: FontSizes.s20,
        fontWeight: FontWeightManager.fw400,
        color: white,
        fontFamily: FontStyleManager.fontFamily,
      ),
      titleMedium: TextStyle(
        fontSize: FontSizes.s16,
        fontWeight: FontWeightManager.fw500,
        color: black,
        fontFamily: FontStyleManager.fontFamily,
      ),
      titleSmall: TextStyle(
        fontSize: FontSizes.s14,
        fontWeight: FontWeightManager.fw400,
        color: white,
        fontFamily: FontStyleManager.fontFamily,
      ),
    ),
  );
}
