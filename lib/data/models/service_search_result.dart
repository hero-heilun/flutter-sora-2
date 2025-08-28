import 'package:flutter/foundation.dart';
import 'search_result.dart';

enum ServiceSearchStatus {
  loading,
  completed,
  error,
}

class ServiceSearchResult {
  final String serviceId;
  final String serviceName;
  final String serviceIcon;
  final ServiceSearchStatus status;
  final List<SearchItem> results;
  final String? errorMessage;

  ServiceSearchResult({
    required this.serviceId,
    required this.serviceName,
    required this.serviceIcon,
    required this.status,
    this.results = const [],
    this.errorMessage,
  });

  ServiceSearchResult copyWith({
    String? serviceId,
    String? serviceName,
    String? serviceIcon,
    ServiceSearchStatus? status,
    List<SearchItem>? results,
    String? errorMessage,
  }) {
    return ServiceSearchResult(
      serviceId: serviceId ?? this.serviceId,
      serviceName: serviceName ?? this.serviceName,
      serviceIcon: serviceIcon ?? this.serviceIcon,
      status: status ?? this.status,
      results: results ?? this.results,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ServiceSearchResult &&
        other.serviceId == serviceId &&
        other.serviceName == serviceName &&
        other.serviceIcon == serviceIcon &&
        other.status == status &&
        listEquals(other.results, results) &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode {
    return serviceId.hashCode ^
        serviceName.hashCode ^
        serviceIcon.hashCode ^
        status.hashCode ^
        results.hashCode ^
        errorMessage.hashCode;
  }
}

class ServiceSearchProgress {
  final int totalServices;
  final int completedServices;
  final List<ServiceSearchResult> serviceResults;

  ServiceSearchProgress({
    required this.totalServices,
    required this.completedServices,
    required this.serviceResults,
  });

  bool get isCompleted => completedServices >= totalServices;
  
  double get progress => totalServices > 0 ? completedServices / totalServices : 0.0;

  int get totalResultsCount {
    return serviceResults.fold(0, (sum, service) => sum + service.results.length);
  }

  ServiceSearchProgress copyWith({
    int? totalServices,
    int? completedServices,
    List<ServiceSearchResult>? serviceResults,
  }) {
    return ServiceSearchProgress(
      totalServices: totalServices ?? this.totalServices,
      completedServices: completedServices ?? this.completedServices,
      serviceResults: serviceResults ?? this.serviceResults,
    );
  }
}