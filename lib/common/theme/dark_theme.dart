import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whats_app/common/theme/extention.dart';
import 'package:whats_app/common/utils/colors.dart';


ThemeData darkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    colorScheme: const ColorScheme.dark(
      background: Coloors.backgroundDark,
    ),
    scaffoldBackgroundColor: Coloors.backgroundDark,
    extensions: const [
      CustomThemeExtension.darkMode,
    ],
    appBarTheme: const AppBarTheme(
      backgroundColor: Coloors.greyBackground,
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
          color: Coloors.greenDark,
          width: 2,
        ),
      ),
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: Coloors.greenDark,
      unselectedLabelColor: Coloors.greyDark,
      labelStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Coloors.greenDark,
        foregroundColor: Coloors.backgroundDark,
        splashFactory: NoSplash.splashFactory,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Coloors.backgroundDark,
      selectedItemColor: Coloors.greenDark,
      unselectedItemColor: Coloors.greyDark,
      type: BottomNavigationBarType.fixed,
    ),
  );
}