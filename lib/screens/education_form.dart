import 'package:material_ui/material_ui.dart';

class EducationFormPage extends StatefulWidget {
  const EducationFormPage({super.key, this.drawer});

  final Widget? drawer;

  @override
  State<EducationFormPage> createState() => _EducationFormPageState();
}

class _EducationFormPageState extends State<EducationFormPage> {
  static final _yearPattern = RegExp(r'^[1-9][0-9]{3}$');
  final _formKey = GlobalKey<FormState>();
  final _startYear = TextEditingController();

  String _institution = '';
  String _program = '';
  String _endYear = '';

  @override
  void dispose() {
    _startYear.dispose();
    super.dispose();
  }

  String? _requiredText(String? value, String label) {
    if ((value ?? '').trim().isEmpty) return '$label wajib diisi.';
    return null;
  }

  String? _validateStartYear(String? value) {
    final year = (value ?? '').trim();
    if (year.isEmpty) return 'Tahun mulai wajib diisi.';
    if (!_yearPattern.hasMatch(year)) {
      return 'Masukkan tahun dalam empat digit.';
    }
    return null;
  }

  String? _validateEndYear(String? value) {
    final end = (value ?? '').trim();
    if (end.isEmpty) return null;
    if (!_yearPattern.hasMatch(end)) return 'Masukkan tahun dalam empat digit.';

    // Bandingkan kedua tahun setelah format tahun mulai dinyatakan valid.
    final start = _startYear.text.trim();
    if (_yearPattern.hasMatch(start) && int.parse(end) < int.parse(start)) {
      return 'Tahun selesai tidak boleh sebelum tahun mulai.';
    }
    return null;
  }

  void _showSummary() {
    final form = _formKey.currentState!;
    if (!form.validate()) return;

    // Simpan isian untuk ringkasan setelah semua validator lulus.
    form.save();
    FocusScope.of(context).unfocus();
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Ringkasan Edukasi'),
        content: SingleChildScrollView(
          child: Text(
            'Institusi: $_institution\n'
            'Program Studi: $_program\n'
            'Tahun Mulai: ${_startYear.text.trim()}\n'
            'Tahun Selesai: ${_endYear.isEmpty ? 'Belum diisi' : _endYear}',
          ),
        ),
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
                      decoration: const InputDecoration(
                        labelText: 'Tahun Selesai (opsional)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: _validateEndYear,
                      onSaved: (value) => _endYear = (value ?? '').trim(),
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
