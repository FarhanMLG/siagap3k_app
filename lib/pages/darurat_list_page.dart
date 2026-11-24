import 'package:flutter/material.dart';
import '../models/darurat_model.dart';
import '../services/api_service.dart';
import 'darurat_detail_page.dart';

/// Halaman daftar panduan kondisi darurat P3K dengan desain flat dan minimalis.
class DaruratListPage extends StatefulWidget {
  const DaruratListPage({super.key});

  @override
  State<DaruratListPage> createState() => _DaruratListPageState();
}

class _DaruratListPageState extends State<DaruratListPage> {
  final ApiService _apiService = ApiService();
  final TextEditingController _searchController = TextEditingController();

  List<DaruratModel> _allData = [];
  List<DaruratModel> _filteredData = [];
  bool _isLoading = true;
  String? _errorMessage;
  String _selectedUrgency = 'Semua';

  final List<String> _filterCategories = ['Semua', 'Tinggi', 'Sedang', 'Ringan'];

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
      final data = await _apiService.fetchDarurat();
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

  /// Menerapkan filter pencarian teks dan filter chip urgensi
  void _applyFilter() {
    final query = _searchController.text.toLowerCase().trim();

    setState(() {
      _filteredData = _allData.where((item) {
        final matchesQuery = item.title.toLowerCase().contains(query) ||
            item.summary.toLowerCase().contains(query);
        final matchesUrgency = _selectedUrgency == 'Semua' ||
            item.urgency.toLowerCase() == _selectedUrgency.toLowerCase();
        return matchesQuery && matchesUrgency;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panduan Darurat P3K'),
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
                hintText: 'Cari panduan darurat...',
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
              itemCount: _filterCategories.length,
              separatorBuilder: (context, index) => const SizedBox(width: 6),
              itemBuilder: (context, index) {
                final category = _filterCategories[index];
                final isSelected = _selectedUrgency == category;

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
                      setState(() => _selectedUrgency = category);
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
          final isTinggi = item.urgency.toLowerCase() == 'tinggi';

          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    item.title,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: isTinggi ? const Color(0xFFFFEBEE) : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: isTinggi ? const Color(0xFFC62828) : Colors.grey.shade300,
                    ),
                  ),
                  child: Text(
                    item.urgency,
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                      color: isTinggi ? const Color(0xFFC62828) : Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                item.summary,
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
                  builder: (context) => DaruratDetailPage(darurat: item),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
