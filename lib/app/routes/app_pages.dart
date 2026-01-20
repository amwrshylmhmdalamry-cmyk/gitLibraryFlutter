import 'package:get/get.dart';
import '../views/login_page.dart';  // ✅ تأكد من المسار الصحيح
import '../views/home_page.dart';   // ✅ تأكد من المسار الصحيح

class AppPages {
  static const INITIAL = '/login';

  static final routes = [
    GetPage(
      name: '/login',
      page: () => LoginPage(),
    ),
    GetPage(
      name: '/home',
      page: () => BookStoreHomePage(),  // ✅ الآن سيعمل
    ),
  ];
}