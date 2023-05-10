import 'package:car_predictor_front_end/constants/app_colors.dart';
import 'package:car_predictor_front_end/screens/form_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCBT-rc1nO4635AM2Xxxlb16_EXfPuIz4g",
          authDomain: "carpredictor-62506.firebaseapp.com",
          projectId: "carpredictor-62506",
          storageBucket: "carpredictor-62506.appspot.com",
          messagingSenderId: "161576689686",
          appId: "1:161576689686:web:90804bc6a4e60bf2f29537"),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        },
      ),
      debugShowCheckedModeBanner: false,
      title: 'Car Predictor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor: AppColors.whiteColor,
      ),
      home: const FormScreen(),
    );
  }
}
