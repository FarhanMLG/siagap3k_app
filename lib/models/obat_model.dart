/// Model data untuk daftar obat dan alat pertolongan pertama (P3K).
class ObatModel {
  final String id;
  final String name;
  final String category;
  final String functionDesc;
  final String usageGuide;
  final String warning;

  ObatModel({
    required this.id,
    required this.name,
    required this.category,
    required this.functionDesc,
    required this.usageGuide,
    required this.warning,
  });

  /// Factory method untuk membuat objek [ObatModel] dari data JSON.
  factory ObatModel.fromJson(Map<String, dynamic> json) {
    return ObatModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      functionDesc: json['function_desc']?.toString() ?? '',
      usageGuide: json['usage_guide']?.toString() ?? '',
      warning: json['warning']?.toString() ?? '',
    );
  }
}
