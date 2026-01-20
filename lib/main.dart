import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'firebase_options.dart'; // أضف هذا الاستيراد
import 'app/controllers/auth_controller.dart';
import 'app/views/login_page.dart';
import 'app/views/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // تهيئة Firebase مع الخيارات المولدة
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put(AuthController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'مكتبة الكتب',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // أثناء التحميل
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 20),
                    Text('جاري التحميل...'),
                  ],
                ),
              ),
            );
          }

          // إذا كان المستخدم مسجل دخول
          if (snapshot.hasData && snapshot.data != null) {
            return BookStoreHomePage();
          }

          // إذا لم يكن مسجل دخول
          return LoginPage();
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}