import 'package:flutter/material.dart';

// Identitas Wajib Mahasiswa (Statis)
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
      home: const InteractiveProfilePage(),
    );
  }
}

class InteractiveProfilePage extends StatefulWidget {
  const InteractiveProfilePage({super.key});

  @override
  State<InteractiveProfilePage> createState() => _InteractiveProfilePageState();
}

class _InteractiveProfilePageState extends State<InteractiveProfilePage> {
  // Controller untuk membaca nilai dari TextField
  final TextEditingController _nameController = TextEditingController();
  
  // Variable State untuk menyimpan nama interaktif
  String _inputtedName = '';

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _updateGreeting() {
    setState(() {
      _inputtedName = _nameController.text.trim();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StatefulWidget & Input - Tahap 9'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Header Identitas Mahasiswa
            Card(
              color: Colors.indigo.shade50,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      studentName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'NIM: $studentId',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // 2. Form Input Nama
            const Text(
              'Masukkan Nama Anda:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nama Lengkap',
                hintText: 'Contoh: Budi Santoso',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _updateGreeting,
              icon: const Icon(Icons.check),
              label: const Text('Tampilkan Salam'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            const SizedBox(height: 24),

            // 3. Tampilan Output Dinamis
            if (_inputtedName.isNotEmpty)
              Card(
                color: Colors.green.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Icon(Icons.sentiment_very_satisfied,
                          color: Colors.green, size: 40),
                      const SizedBox(height: 8),
                      Text(
                        'Halo, $_inputtedName!',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Selamat belajar Flutter UI Fundamentals!',
                        style: TextStyle(color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}