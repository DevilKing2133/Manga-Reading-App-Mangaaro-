// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/painting.dart';

const white = Color(0xFFFFFFFF);

class Constant {
  // ignore: constant_identifier_names
  static const String APP_NAME = "Mangaaro";
  static const String mangaInfoBackgroundWallpaper =
      "https://wallpaperaccess.com/full/639663.jpg";

  static const String fontMedium = "UbuntuMedium";
  static const String fontLight = "UbuntuLight";
  static const String fontRegular = "UbuntuRegular";
  static const String mainUrl = "https://shonen-jump.herokuapp.com/";
  static const String mangaListPath = "manga_list";
  static const String popularMangaQuery = "?orby=topview";
  static const String mangaInfoPath = "manga_info";
  static const String searchPath = "manga_search?find=";
  static const String chaptersPath = "read_manga";
  static const String referer = "https://readmanganato.com/";

  static const String appTheme = "Theme";

  static const String dark = "Dark";

  static const String light = "Light";
  // ignore: constant_identifier_names
  static const String systemDefault = "System default";
  static const List<String> themes = ["System default", "Light", "Dark"];
}

const kHintTextStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'OpenSans',
);

const kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: const Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(10.0),
  // ignore: prefer_const_literals_to_create_immutables
  boxShadow: [
    const BoxShadow(
      color: Colors.black,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

class Themes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color.fromRGBO(50, 50, 50, 0.5),
    backgroundColor: Colors.black12,
    colorScheme: const ColorScheme.dark(
      secondary: Colors.yellow,
      primary: Colors.white,
      onError: Colors.red,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 7, 0, 0),
      actionsIconTheme: IconThemeData(
        color: Colors.white,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        color: Colors.white54,
        fontSize: 15,
      ),
      bodyText2: TextStyle(
        fontSize: 13.5,
      ),
      headline1: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 20,
      ),
      subtitle1: TextStyle(
        color: Colors.white,
      ),
      subtitle2: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
      caption: TextStyle(
        color: Colors.white,
      ),
      headline2: TextStyle(
        color: Colors.white,
        fontSize: 18.0,
        fontFamily: Constant.fontRegular,
        fontWeight: FontWeight.bold,
      ),
      headline3: TextStyle(
        color: Colors.white,
        fontSize: 19.0,
        fontFamily: Constant.fontRegular,
        fontWeight: FontWeight.bold,
      ),
      headline4: TextStyle(
        color: Colors.white,
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
      headline5: TextStyle(
        color: Colors.white,
        fontSize: 15.0,
        fontFamily: Constant.fontRegular,
        fontWeight: FontWeight.bold,
      ),
      headline6: TextStyle(
        color: Colors.black,
        fontSize: 15.0,
        fontFamily: Constant.fontRegular,
        fontWeight: FontWeight.bold,
      ),
      button: TextStyle(
        fontSize: 17,
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontFamily: Constant.fontRegular,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: Colors.black,
      hintStyle: TextStyle(
        color: Colors.white54,
        fontSize: 20,
        fontWeight: FontWeight.normal,
      ),
      focusColor: Colors.white,
      hoverColor: Colors.white,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.white,
      selectionColor: Colors.blue,
    ),
    primaryIconTheme: const IconThemeData(
      color: Colors.white,
    ),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(
      secondary: Color(0xFF0FE2E8),
      primary: Colors.black,
      onError: Colors.red,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0FE2E8),
      actionsIconTheme: IconThemeData(
        color: Colors.black,
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        color: Colors.black45,
        fontSize: 15,
      ),
      bodyText2: TextStyle(
        fontSize: 13.5,
      ),
      headline1: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 20,
      ),
      subtitle1: TextStyle(
        color: Colors.black,
      ),
      subtitle2: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
      caption: TextStyle(
        color: Colors.black,
      ),
      headline2: TextStyle(
        color: Colors.black,
        fontSize: 18.0,
        fontFamily: Constant.fontRegular,
        fontWeight: FontWeight.bold,
      ),
      headline3: TextStyle(
        color: Colors.black,
        fontSize: 19.0,
        fontFamily: Constant.fontRegular,
        fontWeight: FontWeight.bold,
      ),
      headline4: TextStyle(
        color: Colors.black,
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
      headline5: TextStyle(
        color: Colors.black,
        fontSize: 15.0,
        fontFamily: Constant.fontRegular,
        fontWeight: FontWeight.bold,
      ),
      headline6: TextStyle(
        color: Colors.white,
        fontSize: 15.0,
        fontFamily: Constant.fontRegular,
        fontWeight: FontWeight.bold,
      ),
      button: TextStyle(
        fontSize: 17,
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontFamily: Constant.fontRegular,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: Colors.black,
      hintStyle: TextStyle(
        color: Colors.black54,
        fontSize: 20,
        fontWeight: FontWeight.normal,
      ),
      focusColor: Colors.black,
      hoverColor: Colors.black,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.black,
      selectionColor: Colors.blue,
    ),
    primaryIconTheme: const IconThemeData(
      color: Colors.black,
    ),
  );
}
