import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../views/home_view.dart';
import '../views/login_view.dart';

class AuthController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var errorMessage = ''.obs;

  Future<void> login(String email, String password) async {
    try {
      final snapshot = await _db
          .collection('users')
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .get();

      if (snapshot.docs.isNotEmpty) {
        Get.offAll(() => const HomeView());
      } else {
        errorMessage.value = 'بيانات الدخول غير صحيحة';
      }
    } catch (e) {
      errorMessage.value = 'حدث خطأ أثناء تسجيل الدخول';
    }
  }

  void logout() {
    Get.offAll(() => const LoginView());
  }
}
