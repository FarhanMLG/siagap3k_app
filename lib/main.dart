import 'package:flutter/material.dart';
import 'pages/main_page.dart';

void main() {
  runApp(const SiagaP3KApp());
}

/// Root widget aplikasi SiagaP3K dengan tema flat minimalis.
class SiagaP3KApp extends StatelessWidget {
  const SiagaP3KApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryAccent = Color(0xFFC62828);

    return MaterialApp(
      title: 'SiagaP3K',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryAccent,
          primary: primaryAccent,
          surface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryAccent,
          foregroundColor: Colors.white,
          centerTitle: false,
          elevation: 0,
          scrolledUnderElevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        dividerTheme: const DividerThemeData(
          color: Color(0xFFEEEEEE),
          thickness: 1,
          space: 1,
        ),
      ),
      home: const MainPage(),
    );
  }
}
