import 'dart:math';

enum SimilarityAlgorithm {
  levenshteinDistance,
  jaroWinkler,
  cosine,
  fuzzy;

  String get displayName {
    switch (this) {
      case SimilarityAlgorithm.levenshteinDistance:
        return 'Levenshtein Distance';
      case SimilarityAlgorithm.jaroWinkler:
        return 'Jaro-Winkler';
      case SimilarityAlgorithm.cosine:
        return 'Cosine Similarity';
      case SimilarityAlgorithm.fuzzy:
        return 'Fuzzy Matching';
    }
  }
}

class SimilarityCalculator {
  static SimilarityAlgorithm _selectedAlgorithm = SimilarityAlgorithm.jaroWinkler;
  
  static SimilarityAlgorithm get selectedAlgorithm => _selectedAlgorithm;
  static set selectedAlgorithm(SimilarityAlgorithm algorithm) {
    _selectedAlgorithm = algorithm;
  }

  static double calculateSimilarity(String original, String result) {
    final cleanOriginal = _cleanString(original);
    final cleanResult = _cleanString(result);
    
    if (cleanOriginal.isEmpty || cleanResult.isEmpty) return 0.0;
    if (cleanOriginal == cleanResult) return 1.0;

    switch (_selectedAlgorithm) {
      case SimilarityAlgorithm.levenshteinDistance:
        return _levenshteinSimilarity(cleanOriginal, cleanResult);
      case SimilarityAlgorithm.jaroWinkler:
        return _jaroWinklerSimilarity(cleanOriginal, cleanResult);
      case SimilarityAlgorithm.cosine:
        return _cosineSimilarity(cleanOriginal, cleanResult);
      case SimilarityAlgorithm.fuzzy:
        return _fuzzySimilarity(cleanOriginal, cleanResult);
    }
  }

  static String _cleanString(String input) {
    return input
        .toLowerCase()
        .replaceAll(RegExp(r'[^\w\s]'), '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  static double _levenshteinSimilarity(String a, String b) {
    final distance = _levenshteinDistance(a, b);
    final maxLength = max(a.length, b.length);
    if (maxLength == 0) return 1.0;
    return 1.0 - (distance / maxLength);
  }

  static int _levenshteinDistance(String a, String b) {
    if (a.isEmpty) return b.length;
    if (b.isEmpty) return a.length;

    final matrix = List.generate(
      a.length + 1,
      (i) => List.filled(b.length + 1, 0),
    );

    for (int i = 0; i <= a.length; i++) {
      matrix[i][0] = i;
    }
    for (int j = 0; j <= b.length; j++) {
      matrix[0][j] = j;
    }

    for (int i = 1; i <= a.length; i++) {
      for (int j = 1; j <= b.length; j++) {
        final cost = a[i - 1] == b[j - 1] ? 0 : 1;
        matrix[i][j] = [
          matrix[i - 1][j] + 1, // deletion
          matrix[i][j - 1] + 1, // insertion
          matrix[i - 1][j - 1] + cost, // substitution
        ].reduce(min);
      }
    }

    return matrix[a.length][b.length];
  }

  static double _jaroWinklerSimilarity(String a, String b) {
    if (a.isEmpty || b.isEmpty) return 0.0;
    
    final jaro = _jaroSimilarity(a, b);
    if (jaro < 0.7) return jaro;
    
    // Calculate common prefix (up to 4 characters)
    int prefix = 0;
    final maxPrefix = min(4, min(a.length, b.length));
    for (int i = 0; i < maxPrefix; i++) {
      if (a[i] == b[i]) {
        prefix++;
      } else {
        break;
      }
    }
    
    return jaro + (0.1 * prefix * (1 - jaro));
  }

  static double _jaroSimilarity(String a, String b) {
    final len1 = a.length;
    final len2 = b.length;
    
    if (len1 == 0 && len2 == 0) return 1.0;
    if (len1 == 0 || len2 == 0) return 0.0;
    
    final matchDistance = (max(len1, len2) / 2 - 1).floor();
    if (matchDistance < 0) return 0.0;
    
    final s1Matches = List.filled(len1, false);
    final s2Matches = List.filled(len2, false);
    
    int matches = 0;
    int transpositions = 0;
    
    // Identify matches
    for (int i = 0; i < len1; i++) {
      final start = max(0, i - matchDistance);
      final end = min(i + matchDistance + 1, len2);
      
      for (int j = start; j < end; j++) {
        if (s2Matches[j] || a[i] != b[j]) continue;
        s1Matches[i] = true;
        s2Matches[j] = true;
        matches++;
        break;
      }
    }
    
    if (matches == 0) return 0.0;
    
    // Count transpositions
    int k = 0;
    for (int i = 0; i < len1; i++) {
      if (!s1Matches[i]) continue;
      while (!s2Matches[k]) k++;
      if (a[i] != b[k]) transpositions++;
      k++;
    }
    
    return (matches / len1 + matches / len2 + (matches - transpositions / 2) / matches) / 3.0;
  }

  static double _cosineSimilarity(String a, String b) {
    final set1 = _createNGrams(a, 2);
    final set2 = _createNGrams(b, 2);
    
    if (set1.isEmpty || set2.isEmpty) return 0.0;
    
    final intersection = set1.keys.toSet().intersection(set2.keys.toSet());
    double dotProduct = 0.0;
    
    for (final gram in intersection) {
      dotProduct += set1[gram]! * set2[gram]!;
    }
    
    double norm1 = 0.0;
    double norm2 = 0.0;
    
    for (final count in set1.values) {
      norm1 += count * count;
    }
    for (final count in set2.values) {
      norm2 += count * count;
    }
    
    norm1 = sqrt(norm1);
    norm2 = sqrt(norm2);
    
    if (norm1 == 0 || norm2 == 0) return 0.0;
    
    return dotProduct / (norm1 * norm2);
  }

  static Map<String, int> _createNGrams(String text, int n) {
    final ngrams = <String, int>{};
    
    if (text.length < n) {
      ngrams[text] = 1;
      return ngrams;
    }
    
    for (int i = 0; i <= text.length - n; i++) {
      final gram = text.substring(i, i + n);
      ngrams[gram] = (ngrams[gram] ?? 0) + 1;
    }
    
    return ngrams;
  }

  static double _fuzzySimilarity(String a, String b) {
    // Combine multiple similarity measures for fuzzy matching
    final levenshtein = _levenshteinSimilarity(a, b);
    final jaro = _jaroSimilarity(a, b);
    final cosine = _cosineSimilarity(a, b);
    
    // Also check for substring matches
    double substringScore = 0.0;
    if (a.contains(b) || b.contains(a)) {
      substringScore = 0.8;
    } else {
      // Check for partial matches
      final words1 = a.split(' ');
      final words2 = b.split(' ');
      int commonWords = 0;
      
      for (final word1 in words1) {
        for (final word2 in words2) {
          if (word1.isNotEmpty && word2.isNotEmpty && 
              (word1.contains(word2) || word2.contains(word1))) {
            commonWords++;
            break;
          }
        }
      }
      
      if (words1.isNotEmpty && words2.isNotEmpty) {
        substringScore = commonWords / max(words1.length, words2.length);
      }
    }
    
    // Weighted combination
    return (levenshtein * 0.3 + jaro * 0.3 + cosine * 0.2 + substringScore * 0.2);
  }
}