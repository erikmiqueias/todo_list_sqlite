import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_list_sqlite/data/app_colors.dart';
import 'package:todo_list_sqlite/screens/login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) => runApp(
      MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF181F34),
            brightness: Brightness.dark,
          ),
          scaffoldBackgroundColor: AppColors.backgroundPrimary,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.backgroundPrimary,
            foregroundColor: Colors.white,
          ),
          fontFamily: 'Poppins',
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              textStyle: TextStyle(fontFamily: 'Poppins'),
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const LoginScreen(),
      ),
    ),
  );
}
