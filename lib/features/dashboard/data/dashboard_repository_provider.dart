import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ai_english/core/http/api_client_provider.dart';
import 'package:ai_english/features/dashboard/data/dashboard_repository.dart';

part '../../../generated/features/dashboard/data/dashboard_repository_provider.g.dart';

@riverpod
IDashboardRepository dashboardRepository(Ref ref) {
  return DashboardRepository(ref.watch(apiClientProvider));
}
