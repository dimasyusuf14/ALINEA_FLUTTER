import 'package:alinea/pages/home/detail_home_page.dart';
import 'package:alinea/pages/login/login_page.dart';
import 'package:alinea/routes/route_name.dart';
import 'package:get/get.dart';

class PagesRoute {
  static final pages = [
    GetPage(name: RouteName.splash, page: () => LoginPage()),
    GetPage(name: RouteName.detailHome, page: () => DetailHomePage()),
  ];
}
