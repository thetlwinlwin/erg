import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';

class ErgTheme {
  static TextTheme lightTextTheme = TextTheme(
    bodyText1: GoogleFonts.montserrat(
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
    subtitle1: GoogleFonts.montserrat(
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    subtitle2: GoogleFonts.montserrat(
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headline1: GoogleFonts.montserrat(
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headline2: GoogleFonts.montserrat(
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headline3: GoogleFonts.montserrat(
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  );
  static TextTheme darkTextTheme = TextTheme(
    bodyText1: GoogleFonts.montserrat(
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
    subtitle1: GoogleFonts.montserrat(
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    subtitle2: GoogleFonts.montserrat(
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headline1: GoogleFonts.montserrat(
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headline2: GoogleFonts.montserrat(
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headline3: GoogleFonts.montserrat(
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  );
  static const Color darkColor = Color(0xFFe28413);
  static const Color lightColor = Color(0xFF21b1ff);

  static ThemeData light() {
    return ThemeData(
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateColor.resolveWith(
          (states) => lightColor,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateColor.resolveWith(
          (states) => lightColor,
        ),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: lightColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(fontWeight: FontWeight.normal),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: lightColor),
        ),
        contentPadding: EdgeInsets.all(10),
        focusColor: lightColor,
        hoverColor: lightColor,
        iconColor: lightColor,
      ),
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSwatch(
          primarySwatch: createMaterialColor(lightColor)),
      textTheme: lightTextTheme,
    );
  }

  static const DatePickerTheme darkDatePickerTheme = DatePickerTheme(
    backgroundColor: Colors.black,
    doneStyle: TextStyle(
      color: darkColor,
      fontWeight: FontWeight.bold,
    ),
    cancelStyle: TextStyle(
      color: darkColor,
      fontWeight: FontWeight.bold,
    ),
    itemStyle: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 20,
      color: Colors.white,
    ),
  );
  static const DatePickerTheme lightDatePickerTheme = DatePickerTheme(
    backgroundColor: Colors.white,
    doneStyle: TextStyle(
      color: lightColor,
      fontWeight: FontWeight.bold,
    ),
    cancelStyle: TextStyle(
      color: lightColor,
      fontWeight: FontWeight.bold,
    ),
    itemStyle: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 20,
      color: Colors.black,
    ),
  );

  static ThemeData dark() {
    return ThemeData(
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateColor.resolveWith(
          (states) => darkColor,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateColor.resolveWith(
          (states) => darkColor,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(fontWeight: FontWeight.normal),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: lightColor),
        ),
        contentPadding: EdgeInsets.all(10),
        focusColor: darkColor,
        hoverColor: darkColor,
        iconColor: darkColor,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: darkColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: createMaterialColor(darkColor),
      ).copyWith(brightness: Brightness.dark),
      textTheme: darkTextTheme,
    );
  }
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.1];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
