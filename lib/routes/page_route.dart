import 'package:alinea/controller/signUp/sign_up_controller.dart';
import 'package:alinea/pages/home/home_page.dart';
import 'package:alinea/pages/login/login_page.dart';
import 'package:alinea/pages/main/main_page.dart';
import 'package:alinea/pages/notif/notifikasi.dart';
import 'package:alinea/pages/sign_up/sign_up.dart';
import 'package:alinea/pages/wellcome/wellcome_page.dart';
import 'package:alinea/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:alinea/pages/home/detail_home_page.dart';

class PagesRoute {
  static final pages = [
    GetPage(name: RouteName.login, page: () => LoginPage()),
    GetPage(name: RouteName.signUp, page: () => SignUpPage()),
    GetPage(name: RouteName.homePage, page: () => HomePage()),
    GetPage(name: RouteName.mainPage, page: () => MainPage()),
    GetPage(name: RouteName.wellcomePage, page: () => WellcomePage()),
     GetPage(name: RouteName.notifikasiPage, page: () => NotifikasiPage()),
    // GetPage(name: RouteName.detailHome, page: () => DetailHomePage()),
  ];
}
