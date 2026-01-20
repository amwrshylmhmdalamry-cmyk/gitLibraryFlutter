import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String email, password, name;

  final _formKey = GlobalKey<FormState>();
  final AuthController authController = Get.find<AuthController>();
  bool isLogin = true;
  bool _obscurePassword = true;

  void getEmail(String value) => email = value;
  void getPassword(String value) => password = value;
  void getName(String value) => name = value;

  Future<void> loginUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        bool success = await authController.login(email, password);
        if (success) {
          Get.offAll(() => BookStoreHomePage());
        }
      } catch (e) {
        print('Error logging in: $e');
      }
    }
  }

  Future<void> registerUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        bool success = await authController.register(email, password, name);
        if (success) {
          // بعد التسجيل الناجح، انتقل إلى وضع تسجيل الدخول
          setState(() {
            isLogin = true;
          });
          Get.snackbar(
            'نجاح',
            'تم إنشاء الحساب بنجاح! يمكنك تسجيل الدخول الآن',
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        }
      } catch (e) {
        print('Error registering: $e');
      }
    }
  }

  InputDecoration textFieldInputDecoration(String labelText, Icon iconType) {
    return InputDecoration(
      fillColor: Colors.grey.withOpacity(0.1),
      filled: true,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        borderSide: BorderSide(color: Colors.blue, width: 2.0),
      ),
      prefixIcon: iconType,
      labelText: labelText,
      labelStyle: TextStyle(fontSize: 16.0),
    );
  }

  TextStyle simpleTextStyle() => TextStyle(fontSize: 17.0);

  RoundedRectangleBorder raisedButtonBorder() =>
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0));

  @override
  void initState() {
    super.initState();
    // تعيين بيانات الدخول الثابتة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      email = "suhil123@gmail.com";
      password = "suhil123";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(isLogin ? 'تسجيل الدخول' : 'إنشاء حساب'),
      ),
      body: Obx(() {
        // إذا كان المستخدم مسجل الدخول، انتقل إلى HomePage
        if (authController.isLoggedIn.value) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.offAll(() => BookStoreHomePage());
          });
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text('جاري التحويل...'),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Icon(
                    Icons.library_books,
                    size: 80,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'مكتبة الكتب',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'مرحباً بك في مكتبتنا',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 20),

                  // حقل الاسم (للحساب الجديد فقط)
                  if (!isLogin) ...[
                    TextFormField(
                      style: simpleTextStyle(),
                      decoration: textFieldInputDecoration('الاسم', Icon(Icons.person_outline)),
                      onChanged: getName,
                      validator: (value) =>
                      value!.isEmpty ? 'الرجاء إدخال الاسم' : null,
                    ),
                    SizedBox(height: 10.0),
                  ],

                  // حقل البريد الإلكتروني
                  TextFormField(
                    style: simpleTextStyle(),
                    decoration: textFieldInputDecoration('البريد الإلكتروني', Icon(Icons.email_outlined)),
                    onChanged: getEmail,
                    initialValue: "suhil123@gmail.com",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'الرجاء إدخال البريد الإلكتروني';
                      }
                      if (!GetUtils.isEmail(value)) {
                        return 'بريد إلكتروني غير صالح';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.0),

                  // حقل كلمة المرور
                  TextFormField(
                    style: simpleTextStyle(),
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.withOpacity(0.1),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      ),
                      prefixIcon: Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      labelText: 'كلمة المرور',
                      labelStyle: TextStyle(fontSize: 16.0),
                    ),
                    onChanged: getPassword,
                    initialValue: "suhil123",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'الرجاء إدخال كلمة المرور';
                      }
                      if (value.length < 6) {
                        return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15.0),

                  // أزرار التسجيل الدخول/إنشاء حساب
                  Obx(() => authController.isLoading.value
                      ? Center(child: CircularProgressIndicator())
                      : Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                            elevation: 8.0,
                            backgroundColor: isLogin ? Colors.blue : Colors.grey,
                            shape: raisedButtonBorder(),
                          ),
                          onPressed: isLogin ? loginUser : null,
                          child: Text(
                            'تسجيل الدخول',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                            backgroundColor: !isLogin ? Colors.orange : Colors.grey,
                            elevation: 8.0,
                            shape: raisedButtonBorder(),
                          ),
                          onPressed: !isLogin ? registerUser : null,
                          child: Text(
                            'إنشاء حساب',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),

                  const Divider(thickness: 1.0, height: 25.0, color: Colors.green),

                  // زر الدخول السريع
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      elevation: 8.0,
                      backgroundColor: Colors.green,
                      shape: raisedButtonBorder(),
                      minimumSize: Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      // استخدام البيانات الثابتة مباشرة
                      authController.login(
                        "suhil123@gmail.com",
                        "suhil123",
                      ).then((success) {
                        if (success) {
                          Get.offAll(() => BookStoreHomePage());
                        }
                      });
                    },
                    child: const Text(
                      'الدخول السريع (suhil123)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),

                  // زر الدخول كمدير
                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      elevation: 8.0,
                      backgroundColor: Colors.purple,
                      shape: raisedButtonBorder(),
                      minimumSize: Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      authController.login(
                        "admin@library.com",
                        "admin123",
                      ).then((success) {
                        if (success) {
                          Get.offAll(() => BookStoreHomePage());
                        }
                      });
                    },
                    child: const Text(
                      'الدخول كمدير',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),

                  SizedBox(height: 15.0),

                  // زر التبديل بين تسجيل الدخول والتسجيل
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                    child: Text(
                      isLogin
                          ? 'ليس لديك حساب؟ أنشئ حساب جديد'
                          : 'لديك حساب بالفعل؟ سجل الدخول',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}