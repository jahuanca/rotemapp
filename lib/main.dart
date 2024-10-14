import 'dart:io';

import 'package:app_metor/src/app.dart';
import 'package:app_metor/src/utils/core/preferencias_usuario.dart';
import 'package:flutter/material.dart';
import 'package:utils/utils.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  UserPreferences prefs = UserPreferences();
  await prefs.initPrefs();

  loadConfig(
    DataConfig(
      primaryColor: const Color.fromARGB(255,244,104,104),
      backgroundPageColor: const Color.fromARGB(255, 255,255,255),
      borderRadius: 20,
      inputBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(   
          width: 1, 
          color: Color.fromARGB(255, 200, 200, 200)),
      ),
      hintStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
      )
    )
  );

  HttpOverrides.global = MyHttpOverrides();
  runApp(const App());
}

class MyHttpOverrides extends HttpOverrides{

  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
