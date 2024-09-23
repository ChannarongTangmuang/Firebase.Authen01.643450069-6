import 'package:flutter/material.dart';
import 'package:test1/screen/signin.dart';
import 'package:test1/service/auth-service.dart';
import 'signin.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // สร้างตัวควบคุมสำหรับรับค่า email, password, confirmPassword
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>(); // ใช้สำหรับตรวจสอบฟอร์ม

  // ฟังก์ชันสำหรับแสดงข้อความแจ้งเตือน
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Signup"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Container(
          height: 380,
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
          child: Form(
            key: _formKey, // ใช้ FormKey เพื่อทำการตรวจสอบฟอร์ม
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 30),
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.length < 8) {
                      return 'Password must be at least 8 characters long';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Confirm Password",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      var res = await AuthService().reqistration(
                        email: _emailController.text,
                        password: _passwordController.text,
                        confirm: _confirmPasswordController.text,
                      );

                      if (res == 'success') {
                        // นำผู้ใช้กลับไปหน้า Signin หลังจากลงทะเบียนสำเร็จ
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SigninScreen()),
                        );
                      } else {
                        // แสดงข้อความ error ถ้าการลงทะเบียนไม่สำเร็จ
                      }
                    }
                  },
                  child: const Text("Sign Up"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
