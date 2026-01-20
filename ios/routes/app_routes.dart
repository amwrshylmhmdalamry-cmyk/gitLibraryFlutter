import 'package:get/get.dart';
import '../views/login_view.dart';
import '../views/home_view.dart';

class AppRoutes {
  static const login = '/login';
  static const home = '/home';

  static final routes = [
    GetPage(name: login, page: () =>  LoginView()),
    GetPage(name: home, page: () =>  HomeView()),
  ];
}
