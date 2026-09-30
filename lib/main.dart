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
          title: const Text('Collection List - Tahap 10'),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
        body: const TopicListPage(),
      ),
    );
  }
}

class TopicListPage extends StatelessWidget {
  const TopicListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Collection Data List<Map<String, dynamic>>
    final List<Map<String, dynamic>> topics = [
      {'title': 'Git & GitHub', 'subtitle': 'Version control', 'done': true},
      {'title': 'Dart Fundamentals', 'subtitle': 'Language basics', 'done': true},
      {'title': 'Flutter UI Fundamentals', 'subtitle': 'Widgets & layout', 'done': false},
      {'title': '$studentId - $studentName', 'subtitle': 'Pemilik aplikasi', 'done': false},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Identitas di Atas Daftar
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          color: Colors.indigo.shade50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Identitas Pengembang:',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
              ),
              const SizedBox(height: 4),
              Text(
                '$studentId - $studentName',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            'Daftar Topik Pembelajaran',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),

        // ListView.builder dibungkus Expanded
        Expanded(
          child: ListView.builder(
            itemCount: topics.length,
            itemBuilder: (context, index) {
              final item = topics[index];
              final bool isDone = item['done'] == true;

              return ListTile(
                leading: Icon(
                  isDone ? Icons.check_circle : Icons.circle_outlined,
                  color: isDone ? Colors.green : Colors.grey,
                ),
                title: Text(
                  item['title'] as String,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle: Text(item['subtitle'] as String),
              );
            },
          ),
        ),
      ],
    );
  }
}