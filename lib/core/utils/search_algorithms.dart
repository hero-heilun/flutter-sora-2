import 'dart:math';

enum SearchAlgorithm {
  hybrid,
  jaroWinkler,
  levenshtein,
}

class SearchAlgorithms {
  // Hybrid algorithm combining multiple similarity measures
  static double hybridSimilarity(String s1, String s2) {
    if (s1.isEmpty && s2.isEmpty) return 1.0;
    if (s1.isEmpty || s2.isEmpty) return 0.0;

    final normalized1 = s1.toLowerCase().trim();
    final normalized2 = s2.toLowerCase().trim();

    // Exact match
    if (normalized1 == normalized2) return 1.0;

    // Contains check (higher weight)
    if (normalized1.contains(normalized2) || normalized2.contains(normalized1)) {
      final lengthDiff = (s1.length - s2.length).abs();
      final maxLength = max(s1.length, s2.length);
      return 0.9 - (lengthDiff / maxLength) * 0.2;
    }

    // Combine Jaro-Winkler and Levenshtein
    final jaro = jaroWinklerSimilarity(normalized1, normalized2);
    final leven = 1.0 - (levenshteinDistance(normalized1, normalized2) / max(normalized1.length, normalized2.length));

    return (jaro * 0.6 + leven * 0.4);
  }

  // Jaro-Winkler similarity algorithm
  static double jaroWinklerSimilarity(String s1, String s2) {
    if (s1.isEmpty && s2.isEmpty) return 1.0;
    if (s1.isEmpty || s2.isEmpty) return 0.0;

    final jaroSim = _jaroSimilarity(s1, s2);
    if (jaroSim < 0.7) return jaroSim;

    // Calculate common prefix (up to 4 characters)
    final prefix = _commonPrefix(s1, s2);
    return jaroSim + (0.1 * prefix * (1 - jaroSim));
  }

  static double _jaroSimilarity(String s1, String s2) {
    final len1 = s1.length;
    final len2 = s2.length;

    if (len1 == 0 && len2 == 0) return 1.0;
    if (len1 == 0 || len2 == 0) return 0.0;

    final matchWindow = (max(len1, len2) / 2 - 1).floor();
    if (matchWindow < 0) return 0.0;

    final s1Matches = List.filled(len1, false);
    final s2Matches = List.filled(len2, false);

    var matches = 0;
    var transpositions = 0;

    // Find matches
    for (var i = 0; i < len1; i++) {
      final start = max(0, i - matchWindow);
      final end = min(i + matchWindow + 1, len2);

      for (var j = start; j < end; j++) {
        if (s2Matches[j] || s1[i] != s2[j]) continue;
        s1Matches[i] = true;
        s2Matches[j] = true;
        matches++;
        break;
      }
    }

    if (matches == 0) return 0.0;

    // Find transpositions
    var k = 0;
    for (var i = 0; i < len1; i++) {
      if (!s1Matches[i]) continue;
      while (!s2Matches[k]) {
        k++;
      }
      if (s1[i] != s2[k]) transpositions++;
      k++;
    }

    return (matches / len1 + matches / len2 + (matches - transpositions / 2) / matches) / 3;
  }

  static int _commonPrefix(String s1, String s2) {
    final minLen = min(min(s1.length, s2.length), 4);
    for (var i = 0; i < minLen; i++) {
      if (s1[i] != s2[i]) return i;
    }
    return minLen;
  }

  // Levenshtein distance algorithm
  static int levenshteinDistance(String s1, String s2) {
    if (s1.isEmpty) return s2.length;
    if (s2.isEmpty) return s1.length;

    final len1 = s1.length;
    final len2 = s2.length;

    // Create a matrix
    final matrix = List.generate(len1 + 1, (i) => List.filled(len2 + 1, 0));

    // Initialize first row and column
    for (var i = 0; i <= len1; i++) {
      matrix[i][0] = i;
    }
    for (var j = 0; j <= len2; j++) {
      matrix[0][j] = j;
    }

    // Fill the matrix
    for (var i = 1; i <= len1; i++) {
      for (var j = 1; j <= len2; j++) {
        final cost = s1[i - 1] == s2[j - 1] ? 0 : 1;
        matrix[i][j] = min(
          min(matrix[i - 1][j] + 1, matrix[i][j - 1] + 1),
          matrix[i - 1][j - 1] + cost,
        );
      }
    }

    return matrix[len1][len2];
  }

  // Levenshtein similarity (normalized)
  static double levenshteinSimilarity(String s1, String s2) {
    if (s1.isEmpty && s2.isEmpty) return 1.0;
    if (s1.isEmpty || s2.isEmpty) return 0.0;

    final maxLen = max(s1.length, s2.length);
    final distance = levenshteinDistance(s1, s2);
    return 1.0 - (distance / maxLen);
  }

  // Get similarity based on algorithm choice
  static double getSimilarity(String s1, String s2, SearchAlgorithm algorithm) {
    switch (algorithm) {
      case SearchAlgorithm.hybrid:
        return hybridSimilarity(s1, s2);
      case SearchAlgorithm.jaroWinkler:
        return jaroWinklerSimilarity(s1, s2);
      case SearchAlgorithm.levenshtein:
        return levenshteinSimilarity(s1, s2);
    }
  }

  // Find best matches from a list
  static List<T> findBestMatches<T>(
    String query,
    List<T> items,
    String Function(T) getTitleFunction, {
    SearchAlgorithm algorithm = SearchAlgorithm.hybrid,
    double threshold = 0.3,
    int maxResults = 10,
  }) {
    if (query.isEmpty) return items;

    final matches = <MapEntry<T, double>>[];

    for (final item in items) {
      final title = getTitleFunction(item);
      final similarity = getSimilarity(query, title, algorithm);
      
      if (similarity >= threshold) {
        matches.add(MapEntry(item, similarity));
      }
    }

    // Sort by similarity (highest first)
    matches.sort((a, b) => b.value.compareTo(a.value));

    return matches.take(maxResults).map((e) => e.key).toList();
  }

  // Normalize text for better matching
  static String normalizeText(String text) {
    return text
        .toLowerCase()
        .trim()
        .replaceAll(RegExp(r'[^\w\s]'), '') // Remove punctuation
        .replaceAll(RegExp(r'\s+'), ' '); // Normalize whitespace
  }

  // Extract year from text if present
  static int? extractYear(String text) {
    final yearRegex = RegExp(r'\b(19|20)\d{2}\b');
    final match = yearRegex.firstMatch(text);
    return match != null ? int.tryParse(match.group(0)!) : null;
  }

  // Remove year from text
  static String removeYear(String text) {
    return text.replaceAll(RegExp(r'\b(19|20)\d{2}\b'), '').trim();
  }
}