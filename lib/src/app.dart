import 'package:app_metor/src/login/ui/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es'), // Spanish
      ],
      debugShowCheckedModeBanner: false,
      title: 'App Metor',
      theme: ThemeData(
        fontFamily: 'Kiwi_Maru',
        useMaterial3: true,
      ),
      home: const SplashPage(),
    );
  }
}
