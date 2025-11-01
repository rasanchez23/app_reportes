import 'package:flutter/material.dart';
import 'custom_button.dart';

class ReportCard extends StatelessWidget {
  final String authorName;
  final String location;
  final String timeAgo;
  final String description;
  final String? imageUrl;

  const ReportCard({
    super.key,
    required this.authorName,
    required this.location,
    required this.timeAgo,
    required this.description,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(child: Icon(Icons.person)),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(authorName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 2),
                      Text(location, style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
                Text(timeAgo, style: const TextStyle(fontSize: 12)),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: imageUrl == null
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.camera_alt, size: 36, color: Colors.grey),
                          SizedBox(height: 6),
                          Text('Imagen del reporte', style: TextStyle(color: Colors.grey))
                        ],
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(imageUrl!, fit: BoxFit.cover),
                    ),
            ),
            const SizedBox(height: 12),
            Text(description),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.thumb_up_alt_outlined, size: 18),
                    SizedBox(width: 8),
                    Icon(Icons.mode_comment_outlined, size: 18),
                    SizedBox(width: 8),
                    Icon(Icons.share_outlined, size: 18),
                  ],
                ),
                // Example of using the existing CustomButton for a small action
                CustomButton(
                  texto: 'Comentar',
                  onPressed: () {},
                  colorFondo: const Color.fromARGB(255, 33, 150, 243),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
