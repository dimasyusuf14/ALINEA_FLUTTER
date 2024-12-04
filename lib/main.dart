
import 'package:alinea/pages/login/login_page.dart';
import 'package:alinea/pages/main/main_page.dart';
import 'package:alinea/pages/sign_up/sign_up_page.dart';
import 'package:alinea/pages/splash/splash_screen.dart';
import 'package:alinea/pages/wellcome/wellcome_page.dart';
import 'package:alinea/routes/page_route.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() async {
  runApp(MyApp());
  
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    
    return RefreshConfiguration(
      footerBuilder: () => const ClassicFooter(
        loadingIcon: SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(
              color: kColorPrimary,
              strokeWidth: 2,
            )),
      ),
      headerBuilder: () => const WaterDropMaterialHeader(
        backgroundColor: kColorPrimary,
        distance: 40,
      ),
      child: GetMaterialApp(
        title: 'Alinea',
        getPages: PagesRoute.pages,
        theme: ThemeData(
            useMaterial3: true,
            fontFamily: 'Poppins',
            splashColor: Colors.transparent),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
