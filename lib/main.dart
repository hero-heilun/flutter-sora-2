import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/search_page.dart';
import 'presentation/pages/details_page.dart';
import 'presentation/pages/tmdb_details_page.dart';
import 'presentation/pages/player_page.dart';
import 'presentation/pages/video_player_page.dart';
import 'presentation/pages/settings_page.dart';
import 'services/service_manager.dart';
import 'services/javascript_service.dart';
import 'services/http_service.dart';
import 'services/tmdb_service.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final GoRouter _router = GoRouter(
  navigatorKey: navigatorKey,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) => const SearchPage(),
    ),
    GoRoute(
      path: '/details/:href',
      builder: (context, state) {
        final href = state.pathParameters['href']!;
        final title = state.uri.queryParameters['title'] ?? '';
        final imageUrl = state.uri.queryParameters['imageUrl'] ?? '';
        return DetailsPage(
          href: href,
          title: title,
          imageUrl: imageUrl,
        );
      },
    ),
    GoRoute(
      path: '/tmdb/:type/:id',
      builder: (context, state) {
        final type = state.pathParameters['type']!;
        final id = int.parse(state.pathParameters['id']!);
        final title = state.uri.queryParameters['title'] ?? '';
        final posterPath = state.uri.queryParameters['posterPath'];
        final seasonNumber = state.uri.queryParameters['seasonNumber'] != null 
            ? int.tryParse(state.uri.queryParameters['seasonNumber']!) 
            : null;
        final episodeNumber = state.uri.queryParameters['episodeNumber'] != null 
            ? int.tryParse(state.uri.queryParameters['episodeNumber']!) 
            : null;
        return TMDBDetailsPage(
          id: id,
          type: type,
          title: title,
          posterPath: posterPath,
          highlightSeasonNumber: seasonNumber,
          highlightEpisodeNumber: episodeNumber,
        );
      },
    ),
    GoRoute(
      path: '/player/:url',
      builder: (context, state) {
        final url = state.pathParameters['url']!;
        final title = state.uri.queryParameters['title'] ?? '';
        final headersJson = state.uri.queryParameters['headers'] ?? '{}';
        Map<String, String> headers = {};
        try {
          final decoded = json.decode(headersJson) as Map<String, dynamic>;
          headers = decoded.map((k, v) => MapEntry(k, v.toString()));
        } catch (e) {
          // Use default headers if parsing fails
          headers = {};
        }
        return PlayerPage(
          streamUrl: url,
          title: title,
          headers: headers,
        );
      },
    ),
    GoRoute(
      path: '/video_player',
      builder: (context, state) {
        final encodedStreamUrl = state.uri.queryParameters['streamUrl'] ?? '';
        final streamUrl = Uri.decodeComponent(encodedStreamUrl);
        final encodedTitle = state.uri.queryParameters['title'] ?? 'Unknown';
        final title = Uri.decodeComponent(encodedTitle);
        final encodedSubtitle = state.uri.queryParameters['subtitle'];
        final subtitle = encodedSubtitle != null ? Uri.decodeComponent(encodedSubtitle) : null;
        final encodedEpisodeTitle = state.uri.queryParameters['episodeTitle'];
        final episodeTitle = encodedEpisodeTitle != null ? Uri.decodeComponent(encodedEpisodeTitle) : null;
        return VideoPlayerPage(
          streamUrl: streamUrl,
          title: title,
          subtitle: subtitle,
          episodeTitle: episodeTitle,
        );
      },
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsPage(),
    ),
  ],
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize services
  HttpService.instance.initialize();
  await TMDBService.instance.initialize();
  await JavaScriptService.instance.initialize();
  await ServiceManager.instance.initialize();

  runApp(const ProviderScope(child: SoraApp()));
}

class SoraApp extends StatelessWidget {
  const SoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Sora',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}
