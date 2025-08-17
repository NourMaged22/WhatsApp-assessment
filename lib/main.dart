import 'package:flutter/material.dart';
import 'package:whats_app/common/theme/dark_theme.dart';
import 'package:whats_app/common/theme/light_theme.dart';
import 'package:whats_app/view/screen/welcomepage.dart';

void main() {
  runApp(const WhatsApp());
}

class WhatsApp extends StatelessWidget {
  const WhatsApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WhatsApp',

      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: ThemeMode.system,
    home: const WelcomePage(),
    
    );
  }
}
