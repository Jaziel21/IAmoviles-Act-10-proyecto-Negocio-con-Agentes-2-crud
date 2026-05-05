import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/auth_gate.dart';
import 'package:myapp/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF004D40); 
    const Color accentColor = Color(0xFFFFC107);  
    const Color backgroundColor = Color(0xFFFAF9F6);
    const Color cardBackgroundColor = Colors.white;
    const Color textColor = Colors.black87;

    final textTheme = GoogleFonts.montserratTextTheme(Theme.of(context).textTheme).apply(
      bodyColor: textColor,
      displayColor: textColor, 
    );

    return MaterialApp(
      title: 'Libraria',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: backgroundColor,
        
        colorScheme: const ColorScheme.light().copyWith(
          primary: primaryColor,
          secondary: accentColor,
          surface: cardBackgroundColor,
        ),

        textTheme: textTheme,

        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white, 
          elevation: 4.0,
          titleTextStyle: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
        ),

        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: accentColor,
          foregroundColor: Colors.black,
        ),

        cardTheme: CardThemeData(
          color: cardBackgroundColor,
          elevation: 2.0,
          shadowColor: Colors.black.withAlpha(25), // Reemplazado withOpacity
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
        ),
        
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor, width: 2.0),
          ),
          floatingLabelStyle: TextStyle(color: primaryColor),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0)
          )
        ),
      ),
      home: const AuthGate(),
    );
  }
}
