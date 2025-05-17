import 'package:flutter/material.dart';
import 'package:todo_list_sqlite/data/app_colors.dart';
import 'package:todo_list_sqlite/screens/login.dart';

void main() {
  runApp(
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
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    ),
  );
}
