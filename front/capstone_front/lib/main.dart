import 'package:capstone_front/firebase_options.dart';
import 'package:capstone_front/screens/home_screen.dart';
import 'package:capstone_front/screens/login/login_screen.dart';
import 'package:capstone_front/screens/login/signup_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

// 앱에서 지원하는 언어 리스트 변수
final supportedLocales = [const Locale('en', 'US'), const Locale('ko', 'KR')];

// 기본적으로 한국어로 세팅
List<String> languageSetting = ['ko', 'KR'];

// 언어를 설정해주는 함수
Future<void> setLanguage() async {
  const storage = FlutterSecureStorage();
  String? language = await storage.read(key: 'language');
  if (language == 'english') {
    languageSetting = ['en', 'US'];
  } else {
    languageSetting = ['ko', 'KR'];
  }
}

void initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeFirebase();
  await setLanguage();
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
    // 지원 언어 리스트
    supportedLocales: supportedLocales,
    //path: 언어 파일 경로
    path: 'assets/translations',
    //fallbackLocale supportedLocales에 설정한 언어가 없는 경우 설정되는 언어
    fallbackLocale: const Locale('en', 'US'),

    //startLocale을 지정하면 초기 언어가 설정한 언어로 변경됨
    //만일 이 설정을 하지 않으면 OS 언어를 따라 기본 언어가 설정됨
    startLocale: Locale(languageSetting[0], languageSetting[1]),
    child: const App(),
  ));
}

final GoRouter router = GoRouter(
  initialLocation: '/login',
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
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerConfig: router,
      theme: ThemeData(
        fontFamily: 'pretendard',
        colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Color(0xff6E2FF4),
            onPrimary: Colors.red,
            secondary: Color(0xFFE8E8FC),
            onSecondary: Colors.yellow,
            error: Colors.green,
            onError: Colors.blue,
            background: Colors.white,
            onBackground: Colors.lightBlue,
            surface: Colors.white,
            onSurface: Colors.black),
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
