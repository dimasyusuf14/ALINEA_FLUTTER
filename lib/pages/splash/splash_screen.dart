import 'dart:async';

import 'package:alinea/routes/route_name.dart';
import 'package:alinea/services/utilities/asset_constant.dart';
import 'package:alinea/services/utilities/utilities.dart';
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
    var duration = const Duration(seconds: 1);
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
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/bg.png",
              fit: BoxFit.cover,
              width: Get.width,
            ),
          ),
          Center(
            child: Image.asset(AssetConstant.logo),
          ),
        ],
      ),
    );
  }
}
