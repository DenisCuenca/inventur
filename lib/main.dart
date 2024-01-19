import 'package:inventur/screens/gestionarAlmacen.dart';
import 'package:inventur/screens/home_screen.dart';
import 'package:inventur/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:inventur/screens/register.dart';
import 'package:inventur/screens/splash_screen.dart';
import 'firebase_options.dart';

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
    final TextTheme = Theme.of(context).textTheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(48, 153, 161, 1),
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.latoTextTheme(TextTheme).copyWith(
          bodyMedium: GoogleFonts.oswald(textStyle: TextTheme.bodyMedium),
        ),
      ),
      routes: {
        '/splash': (_) => const SplashScreen(),
        '/login': (_) => const Login(),
        '/register': (_) => const RegisterScreen(),
        '/home': (_) => const HomeScreen(),
        '/gestionarAlmacen': (_) => GestionarAlmacen(),
      },
      home: const Login(),
    );
  }
}
