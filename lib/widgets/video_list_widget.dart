import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/video_data.dart';
import '../models/video_model.dart';

class VideoListWidget extends StatelessWidget {
  const VideoListWidget({super.key});

  Future<void> _launchVideo(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: videosList.map((VideoModel video) {
        return InkWell(
          onTap: () => _launchVideo(video.videoUrl),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    video.thumbnailUrl,
                    width: 100,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        video.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        video.description,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(left: 8, right: 4, top: 10),
                  child: Icon(
                    Icons.play_circle_fill,
                    color: Colors.redAccent,
                    size: 32,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
