import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../data/models/search_result.dart';
import '../providers/app_state_provider.dart';

class DetailsPage extends ConsumerWidget {
  final String href;
  final String title;
  final String imageUrl;

  const DetailsPage({
    super.key,
    required this.href,
    required this.title,
    required this.imageUrl,
  });

  Future<void> _playEpisode(BuildContext context, WidgetRef ref, EpisodeLink episode) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      final streamData = await ref.read(detailsProvider(href).notifier).getStreamData(episode.href);
      
      if (context.mounted) {
        Navigator.pop(context);

        if (streamData != null && streamData.streams.isNotEmpty) {
          final streamSource = streamData.streams.first;
          final headers = streamSource.headers ?? {};
          final headersJson = Uri.encodeComponent(json.encode(headers));
          context.push(
            '/player/${Uri.encodeComponent(streamSource.url)}?title=${Uri.encodeComponent('$title - ${episode.title}')}&headers=$headersJson',
          );
        } else {
          _showErrorDialog(context, 'No stream available for this episode');
        }
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        _showErrorDialog(context, 'Failed to get stream URL: $e');
      }
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailsState = ref.watch(detailsProvider(href));
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with image and basic info
            SizedBox(
              height: 300,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey[300],
                            child: const Icon(
                              Icons.movie,
                              size: 50,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          if (detailsState.isLoadingDetails)
                            const CircularProgressIndicator()
                          else if (detailsState.details.isNotEmpty)
                            ...detailsState.details.map((detail) => Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (detail.description.isNotEmpty) ...[
                                    const Text(
                                      'Description:',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text(detail.description),
                                    const SizedBox(height: 8),
                                  ],
                                  if (detail.aliases.isNotEmpty) ...[
                                    const Text(
                                      'Aliases:',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text(detail.aliases),
                                    const SizedBox(height: 8),
                                  ],
                                  if (detail.airdate.isNotEmpty) ...[
                                    const Text(
                                      'Air Date:',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text(detail.airdate),
                                  ],
                                ],
                              ),
                            )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Episodes section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Episodes',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (detailsState.errorMessage != null)
                    Text(
                      detailsState.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    )
                  else if (detailsState.isLoadingEpisodes)
                    const Center(child: CircularProgressIndicator())
                  else if (detailsState.episodes.isEmpty)
                    const Text('No episodes available')
                  else
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: detailsState.episodes.length,
                      itemBuilder: (context, index) {
                        final episode = detailsState.episodes[index];
                        return ElevatedButton(
                          onPressed: () => _playEpisode(context, ref, episode),
                          child: Text(
                            'EP ${episode.number}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}