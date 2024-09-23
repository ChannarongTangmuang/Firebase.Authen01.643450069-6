import 'package:flutter/material.dart';
import 'package:test1/main.dart';
import 'package:test1/service/auth-service.dart';
import 'signup.dart'; // นำเข้าไฟล์ signup

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  // สร้างตัวควบคุมสำหรับรับค่า email และ password
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Container(
          height: 280,
          width: 300,
          padding: const EdgeInsets.all(18),
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: Offset(0.1, 1),
                blurRadius: 0.1,
                spreadRadius: 0.1,
                color: Colors.black,
              )
            ],
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "TODO",
                style: TextStyle(fontSize: 40),
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                    labelText: "Email", border: OutlineInputBorder()),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: "Password", border: OutlineInputBorder()),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      // นำทางไปหน้า SignupScreen เมื่อกดปุ่ม Sign up
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignupScreen()),
                      );
                    },
                    child: const Text("Sign up"),
                  ),
                  TextButton(
                    onPressed: () async {
                      var res = await AuthService().signin(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                      if (res == 'success') {
                        // นำทางไปหน้าแอพหลัก (Todo) หลังจากลงชื่อเข้าใช้สำเร็จ
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TodaApp()),
                        );
                      }
                      print(res);
                    },
                    child: const Text("Sign in"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
