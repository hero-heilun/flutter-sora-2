# Sora Flutter

Cross-platform streaming app with JavaScript service support.

## Preview
![](/image/home.png)
![](/image/search.png)

## Features

- **Cross-platform**: Runs on iOS, Android, macOS, Windows, and Linux
- **JavaScript-based services**: Support for dynamic service loading via JavaScript
- **Video streaming**: HLS and other streaming formats support
- **Service management**: Add, remove, and switch between streaming services
- **Responsive UI**: Material Design 3 with dark mode support

## Architecture

```
lib/
├── data/
│   └── models/          # Data models (Freezed/JSON serializable)
├── presentation/
│   └── pages/           # UI pages
├── services/            # Core services
│   ├── http_service.dart       # HTTP client
│   ├── javascript_service.dart # JavaScript execution
│   └── service_manager.dart    # Service management
└── main.dart           # App entry point
```

## Dependencies

- **flutter_js**: JavaScript runtime for service execution
- **dio**: HTTP client for network requests
- **chewie**: Video player component
- **go_router**: Declarative routing
- **flutter_riverpod**: State management
- **freezed**: Immutable data classes
- **cached_network_image**: Image caching

## Getting Started

1. **Install dependencies**:
   ```bash
   flutter pub get
   ```

2. **Generate code**:
   ```bash
   dart run build_runner build
   ```

3. **Run the app**:
   ```bash
   flutter run
   ```

## Adding Services

1. Go to Settings page
2. Enter the JSON metadata URL for a streaming service
3. Tap "Add Service"
4. Activate the service to start using it

### Service Format

Services are defined by JSON metadata and JavaScript implementation:

```json
{
  "sourceName": "Example Service",
  "author": {
    "name": "Developer",
    "icon": "https://example.com/icon.png"
  },
  "iconUrl": "https://example.com/service-icon.png",
  "version": "1.0.0",
  "language": "en",
  "baseUrl": "https://example.com",
  "streamType": "HLS",
  "quality": "1080p",
  "searchBaseUrl": "https://example.com/search",
  "scriptUrl": "https://example.com/service.js"
}
```

The JavaScript file should implement:
- `searchResults(keyword)`: Search for content
- `extractDetails(url)`: Get content details
- `extractEpisodes(url)`: Get episode list
- `extractStreamUrl(url)`: Get streaming URL

## Platform Support

- ✅ Android
- ✅ iOS
- ✅ macOS
- ✅ Windows
- ✅ Linux
- ✅ Web (limited video player support)
