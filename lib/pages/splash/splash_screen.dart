
import 'dart:async';

import 'package:alinea/routes/route_name.dart';
import 'package:alinea/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    final box = GetStorage();
    var duration = const Duration(seconds: 3);
    Timer(duration, () async {
      if (box.read('token') != null) {
        logPrint("TOKEN : ${box.read('token')}");
        Get.offAllNamed(RouteName.mainPage);
      } else {
        Get.offAllNamed(RouteName.login);
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}