import 'package:material_ui/material_ui.dart';

import '../navigation/home_navigation.dart';

class EducationFormPage extends StatefulWidget {
  const EducationFormPage({super.key, this.drawer});

  final Widget? drawer;

  @override
  State<EducationFormPage> createState() => _EducationFormPageState();
}

class _EducationFormPageState extends State<EducationFormPage> {
  static const _maxEducationTextLength = 255;
  static final _yearPattern = RegExp(r'^[1-9][0-9]{3}$');
  final _formKey = GlobalKey<FormState>();
  final _startYear = TextEditingController();
  final _endYear = TextEditingController();
  late final _yearChanges = Listenable.merge([_startYear, _endYear]);

  String _institution = '';
  String _program = '';

  @override
  void dispose() {
    _startYear.dispose();
    _endYear.dispose();
    super.dispose();
  }

  String? _requiredText(String? value, String label) {
    final text = (value ?? '').trim();
    if (text.isEmpty) return '$label wajib diisi.';

    // Hitung karakter Unicode seperti pada batas CharField model Education.
    if (text.runes.length > _maxEducationTextLength) {
      return '$label maksimal $_maxEducationTextLength karakter.';
    }
    return null;
  }

  String? _validateStartYear(String? value) {
    final year = (value ?? '').trim();
    if (year.isEmpty) return 'Tahun mulai wajib diisi.';
    if (_parseYear(year) == null) {
      return 'Masukkan tahun dalam empat digit.';
    }
    return null;
  }

  String? _validateEndYear(String? value) {
    final end = (value ?? '').trim();
    if (end.isEmpty) return null;
    final endYear = _parseYear(end);
    if (endYear == null) return 'Masukkan tahun dalam empat digit.';

    // Bandingkan kedua tahun setelah format tahun mulai dinyatakan valid.
    final startYear = _parseYear(_startYear.text.trim());
    if (startYear != null && endYear < startYear) {
      return 'Tahun selesai tidak boleh sebelum tahun mulai.';
    }
    return null;
  }

  int? _parseYear(String value) =>
      _yearPattern.hasMatch(value) ? int.parse(value) : null;

  // Tahun saja memberi perkiraan, karena tanggal mulai dan selesai belum diketahui.
  String? get _durationPreview {
    final start = _parseYear(_startYear.text.trim());
    final end = _parseYear(_endYear.text.trim());
    if (start == null || end == null || end < start) return null;
    if (end == start) return 'Mulai dan selesai pada tahun yang sama.';
    return 'Perkiraan durasi: ${end - start} tahun';
  }

  void _showSummary() {
    final form = _formKey.currentState!;
    if (!form.validate()) return;

    // Simpan isian untuk ringkasan setelah semua validator lulus.
    form.save();
    final endYear = _endYear.text.trim();
    final summary = [
      'Institusi: $_institution',
      'Program Studi: $_program',
      'Tahun Mulai: ${_startYear.text.trim()}',
      'Tahun Selesai: ${endYear.isEmpty ? 'Belum diisi' : endYear}',
      ?_durationPreview,
    ].join('\n');
    FocusScope.of(context).unfocus();
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Ringkasan Edukasi'),
        content: SingleChildScrollView(child: Text(summary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Edukasi'),
        leading: BackButton(
          onPressed: () => returnToPortfolioHome(
            Navigator.of(context),
            isFirstRoute: ModalRoute.of(context)!.isFirst,
          ),
        ),
        actions: [if (widget.drawer != null) const DrawerButton()],
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
      ),
      drawer: widget.drawer,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Institusi',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => _requiredText(value, 'Institusi'),
                      onSaved: (value) => _institution = (value ?? '').trim(),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Program Studi',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          _requiredText(value, 'Program studi'),
                      onSaved: (value) => _program = (value ?? '').trim(),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _startYear,
                      decoration: const InputDecoration(
                        labelText: 'Tahun Mulai',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: _validateStartYear,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _endYear,
                      decoration: const InputDecoration(
                        labelText: 'Tahun Selesai (opsional)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: _validateEndYear,
                    ),
                    ListenableBuilder(
                      listenable: _yearChanges,
                      builder: (context, child) {
                        final preview = _durationPreview;
                        if (preview == null) return const SizedBox.shrink();
                        return Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Semantics(
                            liveRegion: true,
                            child: Text(
                              preview,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    FilledButton(
                      onPressed: _showSummary,
                      child: const Text('Simpan'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
