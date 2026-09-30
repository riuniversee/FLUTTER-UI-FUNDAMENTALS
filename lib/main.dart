import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

// Identitas Wajib Mahasiswa
const String studentName = 'Kadek Ripa Adi Putra';
const String studentId = '2455011011';

void main() {
  runApp(const LearningDashboardApp());
}

class LearningDashboardApp extends StatelessWidget {
  const LearningDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Learning Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const LearningDashboardPage(),
    );
  }
}

class LearningDashboardPage extends StatefulWidget {
  const LearningDashboardPage({super.key});

  @override
  State<LearningDashboardPage> createState() => _LearningDashboardPageState();
}

class _LearningDashboardPageState extends State<LearningDashboardPage> {
  late Future<Map<String, dynamic>> studentFuture;
  final TextEditingController _nameController = TextEditingController();
  String _visitorName = '';

  Future<Map<String, dynamic>> loadStudentData() async {
    final jsonString = await rootBundle.loadString('assets/data/student_data.json');
    return jsonDecode(jsonString) as Map<String, dynamic>;
  }

  @override
  void initState() {
    super.initState();
    studentFuture = loadStudentData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  // Reusable Widget Kartu Statistik
  Widget _buildStatCard(String value, String label, IconData icon, Color color) {
    return Expanded(
      child: Card(
        elevation: 1.5,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
          child: Column(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color),
              ),
              Text(
                label,
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning Dashboard'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: studentFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Gagal memuat dashboard: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final data = snapshot.data!;
          final student = data['student'] as Map<String, dynamic>;
          final courses = data['courses'] as List<dynamic>;

          final completedCourses = courses.where((c) => c['status'] == 'done').length;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Profil Pengembang / Mahasiswa
                Card(
                  color: Colors.indigo.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.indigo,
                          child: Icon(Icons.person, size: 36, color: Colors.white),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                student['name'] ?? studentName,
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'NIM: ${student['nim'] ?? studentId}',
                                style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),
                              ),
                              const Text(
                                'Informatics Engineering Student',
                                style: TextStyle(fontSize: 12, color: Colors.indigo),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // 2. Row Ringkasan Statistik (Reusable Widgets)
                Row(
                  children: [
                    _buildStatCard('${courses.length}', 'Total Kursus', Icons.book, Colors.indigo),
                    _buildStatCard('$completedCourses', 'Selesai', Icons.check_circle, Colors.green),
                    _buildStatCard('${courses.length - completedCourses}', 'Progres', Icons.pending, Colors.orange),
                  ],
                ),
                const SizedBox(height: 16),

                // 3. Form Input Interaktif (Stateful Input)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sapa Pengembang',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _nameController,
                                decoration: const InputDecoration(
                                  hintText: 'Masukkan nama Anda...',
                                  isDense: true,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _visitorName = _nameController.text.trim();
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.indigo,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Kirim'),
                            ),
                          ],
                        ),
                        if (_visitorName.isNotEmpty) ...[
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'Halo $_visitorName, selamat datang di dashboard $studentName!',
                              style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w600, fontSize: 12),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // 4. Daftar Progres Pembelajaran
                const Text(
                  'Daftar Topik & Modul',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    final course = courses[index] as Map<String, dynamic>;
                    final bool isDone = course['status'] == 'done';

                    return Card(
                      margin: const EdgeInsets.only(bottom: 8.0),
                      child: ListTile(
                        leading: Icon(
                          isDone ? Icons.check_circle : Icons.radio_button_unchecked,
                          color: isDone ? Colors.green : Colors.orange,
                        ),
                        title: Text(
                          course['title'] as String,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text('Kode: ${course['code']} • ${course['credits']} SKS'),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: isDone ? Colors.green.shade100 : Colors.orange.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            (course['status'] as String).toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: isDone ? Colors.green.shade900 : Colors.orange.shade900,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}