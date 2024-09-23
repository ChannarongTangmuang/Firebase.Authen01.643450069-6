import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // สำหรับออกจากระบบ
import 'package:firebase_core/firebase_core.dart'; // Import Firebase core
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test1/screen/signin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 12, 113, 69)),
        useMaterial3: true,
      ),
      home: const SigninScreen(),
    );
  }
}

class TodaApp extends StatefulWidget {
  const TodaApp({super.key});

  @override
  State<TodaApp> createState() => _TodaAppState();
}

class _TodaAppState extends State<TodaApp> {
  late TextEditingController _titleController;
  late TextEditingController _detailController;
  final CollectionReference tasks =
      FirebaseFirestore.instance.collection('Task');

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _detailController = TextEditingController();
  }

  // ฟังก์ชันสร้างรายการใหม่
  Future<void> addTodoHandle(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("เพิ่มรายการใหม่"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "ชื่อหัวข้อ"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _detailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "รายละเอียด"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await tasks.add({
                  'name': _titleController.text,
                  'note': _detailController.text,
                  'status': false, // ค่าเริ่มต้นเป็น false (ยังไม่เสร็จ)
                });
                _titleController.clear();
                _detailController.clear();
                Navigator.pop(context);
              },
              child: const Text("บันทึก"),
            )
          ],
        );
      },
    );
  }

  // ฟังก์ชันแก้ไขข้อมูล
  Future<void> editTodoHandle(BuildContext context, String id,
      String currentName, String currentNote, bool currentStatus) async {
    _titleController.text = currentName;
    _detailController.text = currentNote;
    bool _isChecked = currentStatus; // สร้างตัวแปรเพื่อเก็บสถานะ

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("แก้ไขรายการ"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "ชื่อหัวข้อ"),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _detailController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "รายละเอียด"),
                  ),
                  const SizedBox(height: 10),
                  CheckboxListTile(
                    title: const Text("ทำเสร็จแล้ว"),
                    value: _isChecked,
                    onChanged: (bool? newValue) {
                      setState(() {
                        _isChecked = newValue!; // อัพเดตสถานะ
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    await tasks.doc(id).update({
                      'name': _titleController.text,
                      'note': _detailController.text,
                      'status': _isChecked, // อัพเดตสถานะ
                    });
                    _titleController.clear();
                    _detailController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("บันทึก"),
                )
              ],
            );
          },
        );
      },
    );
  }

  // ฟังก์ชันลบรายการ
  Future<void> deleteTodoHandle(String id) async {
    await tasks.doc(id).delete();
  }

  // ฟังก์ชันออกจากระบบ
  Future<void> logoutHandle(BuildContext context) async {
    await FirebaseAuth.instance.signOut(); // ออกจากระบบ Firebase
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => const SigninScreen()), // กลับไปหน้า Signin
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("รายการที่ต้องทำ เจี๊ยบ ชญณรงค์"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              logoutHandle(
                  context); // เรียกฟังก์ชันออกจากระบบเมื่อกดปุ่ม Logout
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: tasks.snapshots(), // ดึงข้อมูลจาก Firestore แบบเรียลไทม์
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              return ListTile(
                title: Text(doc['name']),
                subtitle: Text(doc['note']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit,
                          color: Color.fromARGB(255, 49, 121, 76)),
                      onPressed: () {
                        editTodoHandle(
                          context,
                          doc.id,
                          doc['name'],
                          doc['note'],
                          doc['status'],
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete,
                          color: Color.fromARGB(255, 15, 66, 42)),
                      onPressed: () {
                        deleteTodoHandle(doc.id);
                      },
                    ),
                  ],
                ),
                leading: Checkbox(
                  value: doc['status'],
                  onChanged: (bool? value) {
                    tasks.doc(doc.id).update({'status': value});
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTodoHandle(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
