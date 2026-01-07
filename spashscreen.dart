import 'dart:async';
import 'package:flutter/material.dart';
import 'package:untitled13/LoginScreen.dart';
class spashscreen extends StatefulWidget {
  const spashscreen({super.key});

  @override
  State<spashscreen> createState() => _spashscreenState();
}

class _spashscreenState extends State<spashscreen> {
  @override
  void initState() {
    super.initState();

    // 1. تحديد مدة ظهور الشاشة (مثلاً 3 ثوانٍ) ثم الانتقال
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>LoginScreen() ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 2. تعيين لون الخلفية البرتقالي كما في الصورة
      backgroundColor: Colors.orange[800],
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // يمكنك هنا إضافة الصورة الخلفية (النقوش) باستخدام DecorationImage
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 3. وضع شعار "ون كاش" في المنتصف
              Image.asset('images/logo.png', // تأكد من إضافة المسار في pubspec.yaml
                width: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}