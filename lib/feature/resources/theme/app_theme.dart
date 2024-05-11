import 'package:ads_app/feature/resources/constants.dart';
import 'package:flutter/material.dart';

import '../colors/colors.dart';
import '../styles/app_text_style.dart';

extension on ThemeData {
  ThemeData setCommonThemeElements() => copyWith(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: colorScheme.copyWith(secondary: AppColors.red),
      );
}

ThemeData lightTheme() => ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primaryL,
      scaffoldBackgroundColor: AppColors.white,
      fontFamily: 'Dubai',
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black,
        elevation: 0,
        titleSpacing: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w400,
          fontFamily: 'Dubai',
          color: AppColors.black,
        ),
      ),
      // radio button
      unselectedWidgetColor: AppColors.gray,
      toggleableActiveColor: AppColors.accentL,
      tabBarTheme: const TabBarTheme(
        unselectedLabelColor: AppColors.textAppGray,
        labelColor: AppColors.textBlack,
      ),
      // textSelectionTheme
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.primaryL,
        selectionColor: AppColors.primaryL,
        selectionHandleColor: AppColors.primaryL,
      ),
      drawerTheme: const DrawerThemeData(width: 200),
      textTheme: const TextTheme(
        bodyText1: TextStyle(color: Colors.black),
        bodyText2: TextStyle(color: Colors.black),
        button: TextStyle(color: Colors.black),
        caption: TextStyle(color: Colors.black),
        subtitle1: TextStyle(color: AppColors.black),
        subtitle2: TextStyle(color: AppColors.primaryL),
        headline1: TextStyle(
          fontSize: 18,
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        ),
        headline2: TextStyle(
          fontSize: 16,
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        ),
        headline3: TextStyle(
          fontSize: 16,
          color: AppColors.primaryL,
          fontWeight: FontWeight.bold,
        ),
        headline4: TextStyle(
          color: Colors.black,
        ),

        /// used in appBar
        headline5: TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),

        /// used in family code .. numbers
        headline6: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w900,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        errorMaxLines: 2,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Constants.padding15,
          vertical: Constants.padding10,
        ),
        hoverColor: AppColors.primaryD,
        focusColor: AppColors.primaryD,
        hintStyle: AppTextStyle.textStyleEditTextLabelRegularGray,
        filled: true,
        fillColor: AppColors.fillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0,
            color: AppColors.textAppGray.withOpacity(.5),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.primaryL,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        labelStyle: AppTextStyle.textStyleEditTextLabelRegularGray,
        floatingLabelStyle: AppTextStyle.floatingLabelStyle,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.white,
          backgroundColor: AppColors.accentL,
          minimumSize: const Size(100, 45),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white, minimumSize: const Size(100, 45),
          // padding: EdgeInsets.symmetric(horizontal: 16),
          side: const BorderSide(color: Colors.white, width: 2),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
      radioTheme: RadioThemeData(
        fillColor:
            MaterialStateColor.resolveWith((states) => AppColors.textAppGray),
      ),
      timePickerTheme: const TimePickerThemeData(
        hourMinuteTextColor: AppColors.secondaryL,
        // hourMinuteColor: AppColors.primaryL,
        dayPeriodTextColor: AppColors.secondaryL,
        // dayPeriodColor: AppColors.primaryL,
        dialHandColor: AppColors.secondaryL,
        // dialBackgroundColor: AppColors.primaryL,
        // dialTextColor: AppColors.secondaryL,
        entryModeIconColor: AppColors.secondaryL,
        hourMinuteTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          fontFamily: 'Dubai',
        ),
        helpTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          fontFamily: 'Dubai',
          color: AppColors.secondaryL,
        ),
        dayPeriodTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          fontFamily: 'Dubai',
          color: AppColors.secondaryL,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryL,
        ),
      ),
      // textButtonTheme: TextButtonThemeData(
      //   style: TextButton.styleFrom(
      //     primary: AppColors.accentL,
      //   ),
      // ),
      // textTheme: TextTheme(
      //   subtitle1: TextStyle(
      //     fontWeight: FontWeight.bold,
      //     color: AppColors.textGray,
      //   ),
      // ),
    ).setCommonThemeElements();

ThemeData darkTheme() => ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryD,
      scaffoldBackgroundColor: AppColors.primaryL,
      cardColor: AppColors.primaryDisabledD,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.black,
          backgroundColor: AppColors.accentD,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.secondaryL,
        ),
      ),
      textTheme: const TextTheme(
        subtitle1: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.white,
        ),
      ),
    ).setCommonThemeElements();
