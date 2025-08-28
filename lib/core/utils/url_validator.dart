class UrlValidator {
  static bool isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }

  static bool isValidJsonUrl(String url) {
    if (!isValidUrl(url)) return false;
    return url.toLowerCase().endsWith('.json') || 
           url.contains('json') || 
           url.contains('metadata');
  }

  static bool isValidJsUrl(String url) {
    if (!isValidUrl(url)) return false;
    return url.toLowerCase().endsWith('.js') || 
           url.contains('javascript') || 
           url.contains('.js');
  }

  static String cleanUrl(String url) {
    return url.trim();
  }

  static String encodeUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.toString();
    } catch (e) {
      return url;
    }
  }
}