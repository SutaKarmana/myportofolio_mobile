import 'package:http/http.dart' show ClientException;
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../models/project.dart';
import '../navigation/home_navigation.dart';
import '../services/api_client.dart';
import '../services/auth_state.dart';
import '../widgets/auth_guard.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key, this.drawer});

  final Widget? drawer;

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  String _techStack = '';
  String _projectUrl = '';
  String _projectImageUrl = '';
  bool _isSubmitting = false;

  String? _validateUrl(String? value) {
    final text = (value ?? '').trim();
    if (text.isEmpty) return null;

    final uri = Uri.tryParse(text);
    if (uri == null ||
        (uri.scheme != 'http' && uri.scheme != 'https') ||
        uri.host.isEmpty ||
        RegExp(r'\s').hasMatch(text)) {
      return 'Masukkan URL yang diawali http:// atau https://.';
    }
    return null;
  }

  Future<void> _submit() async {
    if (_isSubmitting) return;
    final form = _formKey.currentState!;
    if (!form.validate()) return;
    form.save();

    final newProject = Project(
      title: _title,
      description: _description,
      techStack: _techStack,
      projectUrl: _projectUrl,
      projectImageUrl: _projectImageUrl,
    );

    setState(() => _isSubmitting = true);
    try {
      final loggedIn = await ensureLoggedIn(context);
      if (!mounted || !loggedIn) return;

      final auth = context.read<AuthState>();
      final token = auth.token;
      if (token == null) return;

      final project = await context.read<ApiClient>().createProject(
        newProject,
        token: token,
      );
      if (!mounted) return;

      // Tampilkan konfirmasi setelah Django mengembalikan proyek yang disimpan.
      await _showProjectSummary(project);
      if (mounted) form.reset();
    } on ApiException catch (error) {
      if (!mounted) return;
      if (error.statusCode == 401) {
        await context.read<AuthState>().logout();
        if (!mounted) return;
        _showMessage('Sesi berakhir. Silakan login dan kirim ulang proyek.');
        await ensureLoggedIn(context);
      } else {
        _showMessage('Gagal menambahkan proyek (${error.statusCode}).');
      }
    } on ClientException {
      if (mounted) _showMessage('Gagal terhubung ke server Django.');
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _showProjectSummary(Project project) {
    return showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Proyek berhasil ditambahkan!'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nama Proyek: ${project.title}'),
                Text('Deskripsi: ${project.description}'),
                Text('Teknologi: ${project.techStack}'),
                if (project.projectUrl.isNotEmpty)
                  Text('Tautan: ${project.projectUrl}'),
                if (project.projectImageUrl.isNotEmpty)
                  Text('URL gambar: ${project.projectImageUrl}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Project Form')),
        leading: BackButton(
          onPressed: () => returnToPortfolioHome(
            Navigator.of(context),
            isFirstRoute: ModalRoute.of(context)!.isFirst,
          ),
        ),
        actions: [if (widget.drawer != null) const DrawerButton()],
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: widget.drawer,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nama Proyek',
                    hintText: 'Nama Proyek',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nama proyek tidak boleh kosong!';
                    }
                    return null;
                  },
                  onSaved: (value) => _title = (value ?? '').trim(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Deskripsi Proyek',
                    hintText: 'Deskripsi Proyek',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Deskripsi proyek tidak boleh kosong!';
                    }
                    return null;
                  },
                  onSaved: (value) => _description = (value ?? '').trim(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Teknologi yang Digunakan',
                    hintText: 'Contoh: Flutter, Django, Figma',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Teknologi tidak boleh kosong!';
                    }
                    return null;
                  },
                  onSaved: (value) => _techStack = (value ?? '').trim(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  keyboardType: TextInputType.url,
                  decoration: const InputDecoration(
                    labelText: 'Tautan Proyek',
                    hintText: 'URL proyek (opsional)',
                    border: OutlineInputBorder(),
                  ),
                  validator: _validateUrl,
                  onSaved: (value) => _projectUrl = (value ?? '').trim(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  keyboardType: TextInputType.url,
                  decoration: const InputDecoration(
                    labelText: 'URL Gambar Proyek (opsional)',
                    border: OutlineInputBorder(),
                  ),
                  validator: _validateUrl,
                  onSaved: (value) => _projectImageUrl = (value ?? '').trim(),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: _isSubmitting ? null : _submit,
                    child: Text(_isSubmitting ? 'Menyimpan...' : 'Save'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
