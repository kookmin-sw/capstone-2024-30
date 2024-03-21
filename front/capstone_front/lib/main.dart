import 'package:capstone_front/firebase_options.dart';
import 'package:capstone_front/screens/home_screen.dart';
import 'package:capstone_front/screens/login/login_screen.dart';
import 'package:capstone_front/screens/login/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeFirebase();
  runApp(const App());
}

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (context, state) => const LoginScreen(),
      routes: [
        GoRoute(
          name: 'signup',
          path: 'signup',
          builder: (context, state) => const SignupScreen(),
        ),
      ],
    ),
  ],
);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(
        fontFamily: 'pretendard',
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: Colors.white,
          accentColor: const Color(0xff0099fc),
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
              fontFamily: 'pretendard',
              fontSize: 50,
              fontWeight: FontWeight.w600),
          titleMedium: TextStyle(
              fontFamily: 'pretendard',
              fontSize: 20,
              fontWeight: FontWeight.w600),
          bodyMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
