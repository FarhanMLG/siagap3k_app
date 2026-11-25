import 'package:flutter/material.dart';

/// Halaman informasi ringkas aplikasi SiagaP3K dan profil pembuat.
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang SiagaP3K'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        children: const [
          Icon(
            Icons.medical_services_outlined,
            size: 64,
            color: Color(0xFFC62828),
          ),
          SizedBox(height: 16),
          Text(
            'SiagaP3K',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            'v1.0.0',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
          SizedBox(height: 16),
          Text(
            'Aplikasi panduan pertolongan pertama darurat dan referensi obat P3K dasar.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.4),
          ),
          SizedBox(height: 32),
          Divider(color: Color(0xFFEEEEEE)),
          SizedBox(height: 24),
          Text(
            'Pengembang',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black54),
          ),
          SizedBox(height: 12),
          _ProfileRow(label: 'Nama', value: 'Muhammad Farhan Abdillah'),
          SizedBox(height: 8),
          _ProfileRow(label: 'NIM', value: '21120124130069'),
          SizedBox(height: 8),
          _ProfileRow(label: 'Matkul', value: 'Praktikum PPB 2026'),
        ],
      ),
    );
  }
}

class _ProfileRow extends StatelessWidget {
  final String label;
  final String value;

  const _ProfileRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(label, style: const TextStyle(color: Colors.black54, fontSize: 13.5)),
        ),
        const Text(': ', style: TextStyle(color: Colors.black54)),
        Expanded(
          child: Text(value, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w500)),
        ),
      ],
    );
  }
}
