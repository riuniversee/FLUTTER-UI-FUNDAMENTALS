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
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Membaca JSON Statik - Tahap 12'),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
        body: const JsonReaderTestPage(),
      ),
    );
  }
}

class JsonReaderTestPage extends StatefulWidget {
  const JsonReaderTestPage({super.key});

  @override
  State<JsonReaderTestPage> createState() => _JsonReaderTestPageState();
}

class _JsonReaderTestPageState extends State<JsonReaderTestPage> {
  String _jsonOutput = 'Menunggu pembacaan file JSON...';

  // Function pembaca JSON statik dari assets
  Future<Map<String, dynamic>> loadStudentData() async {
    final String jsonString = await rootBundle.loadString('assets/data/student_data.json');
    return jsonDecode(jsonString) as Map<String, dynamic>;
  }

  void _testReadJson() async {
    try {
      final data = await loadStudentData();
      final student = data['student'] as Map<String, dynamic>;
      final courses = data['courses'] as List<dynamic>;

      setState(() {
        _jsonOutput = 'Berhasil Membaca JSON!\n\n'
            'NIM: ${student['nim']}\n'
            'Nama: ${student['name']}\n'
            'Jumlah Kursus: ${courses.length} item';
      });
    } catch (e) {
      setState(() {
        _jsonOutput = 'Gagal membaca JSON: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, // Properti milik Column
        children: [
          Card(
            color: Colors.indigo.shade50,
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    studentName,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text('NIM: $studentId', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _testReadJson,
            icon: const Icon(Icons.folder_open),
            label: const Text('Uji Baca File JSON'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Text(
                    _jsonOutput,
                    style: const TextStyle(fontSize: 14, fontFamily: 'monospace'),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}