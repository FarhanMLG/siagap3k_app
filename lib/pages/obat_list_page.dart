import 'package:flutter/material.dart';
import '../models/obat_model.dart';
import '../services/api_service.dart';
import 'obat_detail_page.dart';

/// Halaman daftar obat dan alat medis P3K dengan desain flat dan minimalis.
class ObatListPage extends StatefulWidget {
  const ObatListPage({super.key});

  @override
  State<ObatListPage> createState() => _ObatListPageState();
}

class _ObatListPageState extends State<ObatListPage> {
  final ApiService _apiService = ApiService();
  final TextEditingController _searchController = TextEditingController();

  List<ObatModel> _allData = [];
  List<ObatModel> _filteredData = [];
  bool _isLoading = true;
  String? _errorMessage;
  String _selectedCategory = 'Semua';

  final List<String> _categories = [
    'Semua',
    'Obat Luar',
    'Obat Minum',
    'Alat Medis',
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Mengambil data dari REST API
  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final data = await _apiService.fetchObat();
      setState(() {
        _allData = data;
        _isLoading = false;
      });
      _applyFilter();
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceFirst('Exception: ', '');
        _isLoading = false;
      });
    }
  }

  /// Menerapkan filter pencarian teks dan filter chip kategori
  void _applyFilter() {
    final query = _searchController.text.toLowerCase().trim();

    setState(() {
      _filteredData = _allData.where((item) {
        final matchesQuery = item.name.toLowerCase().contains(query) ||
            item.functionDesc.toLowerCase().contains(query);
        final matchesCategory = _selectedCategory == 'Semua' ||
            item.category.toLowerCase() == _selectedCategory.toLowerCase();
        return matchesQuery && matchesCategory;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Obat & Alat P3K'),
      ),
      body: Column(
        children: [
          // Kolom Input Pencarian Minimalis
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              controller: _searchController,
              onChanged: (_) => _applyFilter(),
              decoration: InputDecoration(
                hintText: 'Cari obat atau alat...',
                hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                prefixIcon: const Icon(Icons.search, size: 20),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () {
                          _searchController.clear();
                          _applyFilter();
                        },
                      )
                    : null,
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFC62828)),
                ),
              ),
            ),
          ),

          // Baris Filter Chip Ringkas
          SizedBox(
            height: 38,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              separatorBuilder: (context, index) => const SizedBox(width: 6),
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = _selectedCategory == category;

                return ChoiceChip(
                  label: Text(category),
                  selected: isSelected,
                  selectedColor: const Color(0xFFC62828),
                  backgroundColor: Colors.white,
                  side: BorderSide(
                    color: isSelected ? const Color(0xFFC62828) : Colors.grey.shade300,
                  ),
                  labelStyle: TextStyle(
                    fontSize: 12.5,
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  visualDensity: VisualDensity.compact,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() => _selectedCategory = category);
                      _applyFilter();
                    }
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 8),
          const Divider(height: 1, color: Color(0xFFEEEEEE)),

          // Konten Utama
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2.5),
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_errorMessage!, textAlign: TextAlign.center, style: const TextStyle(color: Colors.black54)),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: _loadData,
                child: const Text('Coba Lagi'),
              ),
            ],
          ),
        ),
      );
    }

    if (_filteredData.isEmpty) {
      return RefreshIndicator(
        onRefresh: _loadData,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: const [
            SizedBox(height: 80),
            Center(
              child: Text(
                'Tidak ditemukan data.',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView.separated(
        itemCount: _filteredData.length,
        separatorBuilder: (_, _) => const Divider(height: 1, color: Color(0xFFEEEEEE)),
        itemBuilder: (context, index) {
          final item = _filteredData[index];

          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    item.name,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Text(
                    item.category,
                    style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600, color: Colors.black87),
                  ),
                ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                item.functionDesc,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 13, color: Colors.grey.shade700, height: 1.3),
              ),
            ),
            trailing: const Icon(Icons.chevron_right, size: 18, color: Colors.grey),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ObatDetailPage(obat: item),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
