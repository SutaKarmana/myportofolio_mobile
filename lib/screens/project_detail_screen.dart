import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/project.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(project.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (project.projectImageUrl.isNotEmpty)
            Image.network(
              project.projectImageUrl,
              errorBuilder: (_, _, _) => const Text('Gambar gagal dimuat.'),
            ),
          Text(project.title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 12),
          Text(project.techStack),
          const SizedBox(height: 12),
          Text(project.description),
          if (project.projectUrl.isNotEmpty) ...[
            const SizedBox(height: 12),
            SelectableText(project.projectUrl),
          ],
        ],
      ),
    );
  }
}
