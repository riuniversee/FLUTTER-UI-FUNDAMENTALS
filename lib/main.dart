import 'package:flutter/material.dart';

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
          title: const Text('Informatif List - Tahap 11'),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
        body: const InformativeTopicListPage(),
      ),
    );
  }
}

class InformativeTopicListPage extends StatelessWidget {
  const InformativeTopicListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Collection Data List<Map<String, dynamic>>
    final List<Map<String, dynamic>> topics = [
      {'title': 'Git & GitHub', 'subtitle': 'Version control', 'done': true},
      {'title': 'Dart Fundamentals', 'subtitle': 'Language basics', 'done': true},
      {'title': 'Flutter UI Fundamentals', 'subtitle': 'Widgets & layout', 'done': false},
      {'title': '$studentId - $studentName', 'subtitle': 'Pemilik aplikasi', 'done': false},
    ];

    // Menghitung jumlah topik yang sudah selesai menggunakan where()
    final int completedCount = topics.where((item) => item['done'] == true).length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Card Ringkasan & Identitas Mahasiswa
        Card(
          margin: const EdgeInsets.all(16.0),
          color: Colors.indigo.shade50,
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      studentName,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      'NIM: $studentId',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                // Badge Ringkasan Progress
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '$completedCount dari ${topics.length} Selesai',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: Text(
            'Progres Topik Pembelajaran',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),

        // List item dibungkus Card dengan Conditional UI
        Expanded(
          child: ListView.builder(
            itemCount: topics.length,
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            itemBuilder: (context, index) {
              final item = topics[index];
              final bool isDone = item['done'] == true;

              return Card(
                margin: const EdgeInsets.only(bottom: 10.0),
                elevation: 1,
                child: ListTile(
                  leading: Icon(
                    isDone ? Icons.check_circle : Icons.schedule,
                    color: isDone ? Colors.green : Colors.orange,
                  ),
                  title: Text(
                    item['title'] as String,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(item['subtitle'] as String),
                  trailing: Text(
                    isDone ? 'Selesai' : 'Belum',
                    style: TextStyle(
                      color: isDone ? Colors.green : Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}