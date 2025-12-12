import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'create_report_screen.dart';

class ReportListScreen extends StatefulWidget {
  final String? username;
  const ReportListScreen({Key? key, this.username}) : super(key: key);

  @override
  State<ReportListScreen> createState() => _ReportListScreenState();
}

class _ReportListScreenState extends State<ReportListScreen> {
  late Future<List<Map<String, dynamic>>> _reportsFuture;

  @override
  void initState() {
    super.initState();
    _reportsFuture = ApiService.getFeed();
  }

  Future<void> _refreshFeed() async {
    setState(() {
      _reportsFuture = ApiService.getFeed();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed de Reportes'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshFeed,
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _reportsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                  const SizedBox(height: 16),
                  Text(
                    'Error al cargar reportes',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.red[600],
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _refreshFeed,
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          }

          final reports = snapshot.data ?? [];

          if (reports.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inbox, size: 64, color: Colors.grey[300]),
                  const SizedBox(height: 16),
                  Text(
                    'No hay reportes aún',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Crea el primer reporte',
                    style: TextStyle(fontSize: 14, color: Colors.grey[400]),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: reports.length,
            itemBuilder: (context, index) {
              final report = reports[index];
              return ReportCard(
                report: report,
                username: widget.username,
                onRefresh: _refreshFeed,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateReportScreen(
                username: widget.username,
              ),
            ),
          );
          _refreshFeed();
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ReportCard extends StatefulWidget {
  final Map<String, dynamic> report;
  final String? username;
  final Function() onRefresh;

  const ReportCard({
    Key? key,
    required this.report,
    this.username,
    required this.onRefresh,
  }) : super(key: key);

  @override
  State<ReportCard> createState() => _ReportCardState();
}

class _ReportCardState extends State<ReportCard> {
  late int likes;
  late int comments;
  bool isLiked = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    likes = widget.report['likes'] ?? 0;
    comments = widget.report['comments'] ?? 0;
  }

  Future<void> _toggleLike() async {
    if (widget.username == null) return;
    
    setState(() {
      isLoading = true;
    });

    final result = await ApiService.likeReport(
      reportId: widget.report['id'],
      username: widget.username!,
    );

    if (mounted) {
      setState(() {
        isLoading = false;
        if (result['success'] == true) {
          isLiked = !isLiked;
          likes = result['likes'] ?? likes;
        }
      });
    }
  }

  void _showCommentDialog() {
    final commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Agregar comentario'),
        content: TextField(
          controller: commentController,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: 'Escribe tu comentario...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              if (commentController.text.isNotEmpty && widget.username != null) {
                final result = await ApiService.addComment(
                  reportId: widget.report['id'],
                  username: widget.username!,
                  text: commentController.text,
                );

                if (mounted) {
                  Navigator.pop(context);
                  if (result['success'] == true) {
                    setState(() {
                      comments = result['comments'] ?? comments;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Comentario agregado'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                }
              }
            },
            child: const Text('Enviar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFF6B4FA3),
                  child: Text(
                    (widget.report['author'] as String).isNotEmpty
                        ? widget.report['author'][0].toUpperCase()
                        : 'U',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.report['author'] ?? 'Usuario',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.report['timestamp'] ?? 'Hace poco',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              widget.report['title'] ?? 'Sin título',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.report['description'] ?? 'Sin descripción',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: isLoading ? null : _toggleLike,
                    icon: Icon(isLiked ? Icons.favorite : Icons.favorite_outline),
                    label: Text('$likes Me gusta'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6B4FA3),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _showCommentDialog,
                    icon: const Icon(Icons.comment_outlined),
                    label: Text('$comments Comentar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6B4FA3),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.share_outlined),
                    label: const Text('Compartir'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6B4FA3),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
