
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import 'home_page.dart';

/* ========= قاعدة بيانات داخلية ========= */
final Map<String, Map<String, String>> localDatabase = {
'admin@library.com': {
'password': 'admin123',
'name': 'المدير',
},
'user@test.com': {
'password': '123456',
'name': 'مستخدم',
},
};
/* ====================================== */

class LoginPage extends StatelessWidget {
LoginPage({super.key});

final AuthController _authController = Get.find();
final _emailController = TextEditingController();
final _passwordController = TextEditingController();
final _nameController = TextEditingController();

final _isLogin = true.obs;
final _obscurePassword = true.obs;

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Obx(() => Text(
_isLogin.value ? 'تسجيل الدخول' : 'إنشاء حساب',
style: TextStyle(fontSize: 20),
)),
),
body: SingleChildScrollView(
child: Padding(
padding: EdgeInsets.all(20),
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
SizedBox(height: 40),
Icon(Icons.library_books, size: 80, color: Colors.blue),
SizedBox(height: 10),
Text(
'مكتبتي',
style: TextStyle(
fontSize: 28,
fontWeight: FontWeight.bold,
color: Colors.blue),
),
SizedBox(height: 30),

Obx(() => _isLogin.value
? SizedBox()
    : Column(
children: [
TextField(
controller: _nameController,
decoration: InputDecoration(
labelText: 'اسمك',
prefixIcon: Icon(Icons.person),
border: OutlineInputBorder(),
),
),
SizedBox(height: 15),
],
)),

TextField(
controller: _emailController,
decoration: InputDecoration(
labelText: 'البريد الإلكتروني',
prefixIcon: Icon(Icons.email),
border: OutlineInputBorder(),
),
),
SizedBox(height: 15),

Obx(() => TextField(
controller: _passwordController,
obscureText: _obscurePassword.value,
decoration: InputDecoration(
labelText: 'كلمة المرور',
prefixIcon: Icon(Icons.lock),
suffixIcon: IconButton(
icon: Icon(_obscurePassword.value
? Icons.visibility_off
    : Icons.visibility),
onPressed: () => _obscurePassword.toggle(),
),
border: OutlineInputBorder(),
),
)),
SizedBox(height: 30),

SizedBox(
width: double.infinity,
child: ElevatedButton(
onPressed: () {
if (_isLogin.value) {
_login();
} else {
_register();
}
},
child:
Text(_isLogin.value ? 'تسجيل الدخول' : 'إنشاء حساب'),
),
),

SizedBox(height: 15),

TextButton(
onPressed: () {
_isLogin.toggle();
_emailController.clear();
_passwordController.clear();
_nameController.clear();
},
child: Obx(() => Text(
_isLogin.value
? 'ليس لديك حساب؟ أنشئ حساب جديد'
    : 'لديك حساب بالفعل؟ سجل الدخول',
)),
),

SizedBox(height: 20),

OutlinedButton(
onPressed: () {
_emailController.text = 'admin@library.com';
_passwordController.text = 'admin123';
_login();
},
child: Text('دخول سريع (مدير)'),
),
],
),
),
),
);
}

/* ========= شرط الدخول فقط ========= */
void _login() {
final email = _emailController.text.trim();
final password = _passwordController.text.trim();

if (email.isEmpty || password.isEmpty) {
Get.snackbar('خطأ', 'الرجاء إدخال البريد وكلمة المرور');
return;
}

if (localDatabase.containsKey(email) &&
localDatabase[email]!['password'] == password) {
Get.offAll(() => BookStoreHomePage());
} else {
Get.snackbar('خطأ', 'بيانات الدخول غير صحيحة');
}
}
/* ================================== */

void _register() {
final email = _emailController.text.trim();
final password = _passwordController.text.trim();
final name = _nameController.text.trim();

if (email.isEmpty || password.isEmpty || name.isEmpty) {
Get.snackbar('خطأ', 'الرجاء إدخال جميع البيانات');
return;
}

if (password.length < 6) {
Get.snackbar('خطأ', 'كلمة المرور يجب أن تكون 6 أحرف على الأقل');
return;
}

localDatabase[email] = {
'password': password,
'name': name,
};

Get.offAll(() => BookStoreHomePage());
}
}

