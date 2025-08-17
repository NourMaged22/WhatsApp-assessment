import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whats_app/common/theme/extention.dart';
import 'package:whats_app/common/utils/colors.dart';

ThemeData lightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: const ColorScheme.light(
      background: Coloors.backgroundLight,
    ),
    scaffoldBackgroundColor: Coloors.backgroundLight,
    extensions: const [
      CustomThemeExtension.lightMode,
    ],
    appBarTheme: const AppBarTheme(
      backgroundColor: Coloors.greenLight,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    tabBarTheme: const TabBarTheme(
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          color: Colors.white,
          width: 2,
        ),
      ),
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white70,
      labelStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Coloors.greenLight,
        foregroundColor: Coloors.backgroundLight,
        splashFactory: NoSplash.splashFactory,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Coloors.backgroundLight,
      selectedItemColor: Coloors.greenLight,
      unselectedItemColor: Coloors.greyLight,
      type: BottomNavigationBarType.fixed,
    ),
  );
}