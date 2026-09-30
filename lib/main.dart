import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

// Identitas Wajib Mahasiswa
const String studentName = 'Kadek Ripa Adi Putra';
const String studentId = '2455011011';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // Variabel late Future untuk menyimpan proses pembacaan JSON
  late Future<Map<String, dynamic>> studentFuture;

  // Fungsi membaca file JSON statik dari assets
  Future<Map<String, dynamic>> loadStudentData() async {
    final String jsonString = await rootBundle.loadString('assets/data/student_data.json');
    return jsonDecode(jsonString) as Map<String, dynamic>;
  }

  @override
  void initState() {
    super.initState();
    // Menginisialisasi Future hanya satu kali di initState
    studentFuture = loadStudentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Async FutureBuilder - Tahap 13'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: studentFuture,
        builder: (context, snapshot) {
          // 1. State Loading / Menunggu Data
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2. State Error / Gagal Memuat Data
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Gagal memuat data: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          // 3. State Data Siap (Success)
          final data = snapshot.data!;
          final student = data['student'] as Map<String, dynamic>;
          final courses = data['courses'] as List<dynamic>;

          return Column(
            children: [
              // Kartu Informasi Identitas dari Data JSON
              Card(
                margin: const EdgeInsets.all(16.0),
                color: Colors.indigo.shade50,
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.indigo,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  title: Text(
                    student['name'] as String,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('NIM: ${student['nim']}'),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Daftar Materi dari JSON Statik:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              // Rendering List Data Kursus
              Expanded(
                child: ListView.builder(
                  itemCount: courses.length,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  itemBuilder: (context, index) {
                    final course = courses[index] as Map<String, dynamic>;
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.book, color: Colors.indigo),
                        title: Text(
                          course['title'] as String,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text('Kode: ${course['code']} • ${course['credits']} SKS'),
                        trailing: Text(
                          (course['status'] as String).toUpperCase(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}