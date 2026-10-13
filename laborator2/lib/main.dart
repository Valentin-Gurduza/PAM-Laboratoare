import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'design.dart';
import 'screens/home_screen.dart';

void main() {
  for (final family in ['Outfit', 'OpenSans', 'Poppins']) {
    LicenseRegistry.addLicense(() async* {
      final license = await rootBundle.loadString(
        'assets/fonts/$family-LICENSE.txt',
      );
      yield LicenseEntryWithLineBreaks([family], license);
    });
  }
  runApp(const MedicalApp());
}

class MedicalApp extends StatelessWidget {
  const MedicalApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Medical Healthcare App',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      fontFamily: 'Outfit',
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        surface: Colors.white,
      ),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.homePrimary,
      ),
    ),
    home: const HomeScreen(),
  );
}
