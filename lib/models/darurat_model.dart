/// Model data untuk panduan kondisi darurat pertolongan pertama (P3K).
class DaruratModel {
  final String id;
  final String title;
  final String urgency;
  final String summary;
  final String steps;
  final String donts;

  DaruratModel({
    required this.id,
    required this.title,
    required this.urgency,
    required this.summary,
    required this.steps,
    required this.donts,
  });

  /// Factory method untuk membuat objek [DaruratModel] dari data JSON.
  factory DaruratModel.fromJson(Map<String, dynamic> json) {
    return DaruratModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      urgency: json['urgency']?.toString() ?? 'Ringan',
      summary: json['summary']?.toString() ?? '',
      steps: json['steps']?.toString() ?? '',
      donts: json['donts']?.toString() ?? '',
    );
  }
}
