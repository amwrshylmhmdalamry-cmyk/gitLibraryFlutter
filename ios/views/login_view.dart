import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('تسجيل الدخول')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'البريد الإلكتروني'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'كلمة المرور'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              if (auth.errorMessage.isNotEmpty)
                Text(auth.errorMessage.value, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: auth.isLoading.value
                    ? null
                    : () => auth.login(emailController.text.trim(), passwordController.text.trim()),
                child: auth.isLoading.value
                    ? const CircularProgressIndicator()
                    : const Text('دخول'),
              ),
              TextButton(
                onPressed: auth.isLoading.value
                    ? null
                    : () => auth.signup(emailController.text.trim(), passwordController.text.trim()),
                child: const Text('إنشاء حساب جديد'),
              ),
            ],
          );
        }),
      ),
    );
  }
}
