import 'package:flutter/material.dart';
import '../models/obat_model.dart';

/// Halaman detail informasi obat dan alat P3K dengan tampilan bersih dan tipografi tegas.
class ObatDetailPage extends StatelessWidget {
  final ObatModel obat;

  const ObatDetailPage({super.key, required this.obat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Obat & Alat'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: [
          // Tag Kategori
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Text(
                  obat.category,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Nama Obat / Alat
          Text(
            obat.name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 16),
          const Divider(color: Color(0xFFEEEEEE)),
          const SizedBox(height: 16),

          // Fungsi Utama
          const Text(
            'Fungsi Utama',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            obat.functionDesc.isNotEmpty
                ? obat.functionDesc
                : 'Tidak ada deskripsi fungsi.',
            style: const TextStyle(
              fontSize: 14.5,
              height: 1.5,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),

          // Cara Pemakaian Aman
          const Text(
            'Cara Pemakaian Aman',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            obat.usageGuide.isNotEmpty
                ? obat.usageGuide
                : 'Gunakan sesuai petunjuk medis.',
            style: const TextStyle(
              fontSize: 14.5,
              height: 1.5,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 24),

          // Peringatan & Efek Samping (Aksen border kiri merah)
          Container(
            padding: const EdgeInsets.all(14),
            decoration: const BoxDecoration(
              color: Color(0xFFFFF5F5),
              border: Border(
                left: BorderSide(
                  color: Color(0xFFC62828),
                  width: 4,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Peringatan & Efek Samping',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFC62828),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  obat.warning.isNotEmpty
                      ? obat.warning
                      : 'Tidak ada peringatan khusus.',
                  style: const TextStyle(
                    fontSize: 13.5,
                    height: 1.4,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
