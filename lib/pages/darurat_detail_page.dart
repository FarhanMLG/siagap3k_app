import 'package:flutter/material.dart';
import '../models/darurat_model.dart';

/// Halaman detail panduan darurat dengan tipografi bersih tanpa card bertumpuk.
class DaruratDetailPage extends StatelessWidget {
  final DaruratModel darurat;

  const DaruratDetailPage({super.key, required this.darurat});

  @override
  Widget build(BuildContext context) {
    final stepList = darurat.steps
        .split('\n')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    final isTinggi = darurat.urgency.toLowerCase() == 'tinggi';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Panduan'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: [
          // Baris Status Urgensi
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isTinggi ? const Color(0xFFFFEBEE) : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: isTinggi ? const Color(0xFFC62828) : Colors.grey.shade300,
                  ),
                ),
                child: Text(
                  'Urgensi: ${darurat.urgency}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isTinggi ? const Color(0xFFC62828) : Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Judul Utama
          Text(
            darurat.title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 12),

          // Ringkasan
          Text(
            darurat.summary,
            style: const TextStyle(
              fontSize: 14.5,
              height: 1.5,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          const Divider(color: Color(0xFFEEEEEE)),
          const SizedBox(height: 20),

          // Langkah Pertolongan
          const Text(
            'Langkah Pertolongan Pertama',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          if (stepList.isEmpty)
            const Text(
              'Tidak ada instruksi khusus.',
              style: TextStyle(color: Colors.grey),
            )
          else
            ...stepList.asMap().entries.map((entry) {
              final stepNumber = entry.key + 1;
              final text = entry.value.replaceFirst(RegExp(r'^\d+\.\s*'), '');

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$stepNumber.',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.5,
                        height: 1.45,
                        color: Color(0xFFC62828),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        text,
                        style: const TextStyle(
                          fontSize: 14.5,
                          height: 1.45,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),

          const SizedBox(height: 16),

          // Bagian Peringatan: "Jangan Lakukan" dengan border kiri merah
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
                  'Jangan Lakukan',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFC62828),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  darurat.donts.isNotEmpty
                      ? darurat.donts
                      : 'Tidak ada larangan khusus.',
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
