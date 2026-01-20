import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AuthController extends GetxController {
  // جعل الـ instance سهل الوصول
  static AuthController get instance => Get.find();

  final RxBool isLoading = false.obs;
  final RxBool isLoggedIn = false.obs;
  final RxString currentUserName = ''.obs;
  final RxString currentUserEmail = ''.obs;

  // بيانات المستخدمين المخزنة محلياً
  final List<Map<String, String>> _users = [
    {
      'email': 'suhil123@gmail.com',
      'password': 'suhil123',
      'name': 'سُهيل',
    },
    {
      'email': 'admin@library.com',
      'password': 'admin123',
      'name': 'مدير النظام',
    },
    {
      'email': 'user@test.com',
      'password': 'user123',
      'name': 'مستخدم تجريبي',
    },
  ];

  @override
  void onInit() {
    super.onInit();
    _checkLoginStatus();
  }

  // التحقق من حالة تسجيل الدخول
  Future<void> _checkLoginStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final loggedIn = prefs.getBool('isLoggedIn') ?? false;

      if (loggedIn) {
        isLoggedIn.value = true;
        currentUserEmail.value = prefs.getString('userEmail') ?? '';
        currentUserName.value = prefs.getString('userName') ?? '';
        print('✅ المستخدم مسجل الدخول: ${currentUserEmail.value}');
      }
    } catch (e) {
      print('❌ خطأ في التحقق من حالة الدخول: $e');
    }
  }

  // دالة تسجيل الدخول
  Future<bool> login(String email, String password) async {
    try {
      isLoading.value = true;
      print('🔄 محاولة تسجيل الدخول بـ: $email');

      // البحث عن المستخدم في القائمة
      final user = _users.firstWhere(
            (user) => user['email'] == email.trim() && user['password'] == password.trim(),
        orElse: () => {},
      );

      if (user.isNotEmpty) {
        print('✅ تسجيل الدخول ناجح لـ: ${user['email']}');

        // حفظ حالة الدخول في SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('userEmail', user['email']!);
        await prefs.setString('userName', user['name']!);

        // تحديث القيم الحالية
        isLoggedIn.value = true;
        currentUserEmail.value = user['email']!;
        currentUserName.value = user['name']!;

        _showToast('مرحباً ${user['name']}! تم تسجيل الدخول بنجاح', Colors.green);
        isLoading.value = false;
        return true;
      } else {
        print('❌ فشل تسجيل الدخول: بيانات غير صحيحة');
        _showToast('البريد الإلكتروني أو كلمة المرور غير صحيحة', Colors.red);
        isLoading.value = false;
        return false;
      }

    } catch (e) {
      isLoading.value = false;
      print('❌ خطأ غير متوقع: $e');
      _showToast('حدث خطأ غير متوقع', Colors.red);
      return false;
    }
  }

  // دالة التسجيل (للمستقبل)
  Future<bool> register(String email, String password, String name) async {
    try {
      isLoading.value = true;
      print('🔄 محاولة إنشاء حساب بـ: $email');

      // التحقق من عدم وجود البريد مسبقاً
      final emailExists = _users.any((user) => user['email'] == email.trim());

      if (emailExists) {
        _showToast('البريد الإلكتروني مستخدم مسبقاً', Colors.orange);
        isLoading.value = false;
        return false;
      }

      // إضافة المستخدم الجديد
      _users.add({
        'email': email.trim(),
        'password': password.trim(),
        'name': name.trim(),
      });

      print('✅ إنشاء حساب ناجح لـ: $email');
      _showToast('تم إنشاء الحساب بنجاح! يمكنك تسجيل الدخول الآن', Colors.green);

      isLoading.value = false;
      return true;

    } catch (e) {
      isLoading.value = false;
      print('❌ خطأ غير متوقع: $e');
      _showToast('حدث خطأ غير متوقع', Colors.red);
      return false;
    }
  }

  // دالة تسجيل الخروج
  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      isLoggedIn.value = false;
      currentUserEmail.value = '';
      currentUserName.value = '';

      _showToast('تم تسجيل الخروج بنجاح', Colors.blue);
      Get.offAllNamed('/login');
    } catch (e) {
      print('❌ خطأ في تسجيل الخروج: $e');
    }
  }

  // دالة للحصول على قائمة المستخدمين (للتطوير)
  List<Map<String, String>> get users => _users;

  // دالة مساعدة لعرض الرسائل
  void _showToast(String message, Color color) {
    Get.snackbar(
      '',
      message,
      backgroundColor: color,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 3),
    );
  }
}