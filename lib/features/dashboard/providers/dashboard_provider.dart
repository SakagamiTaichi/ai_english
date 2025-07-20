import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ai_english/features/dashboard/models/dashboard_api_models.dart';
import 'package:ai_english/features/dashboard/data/dashboard_repository_provider.dart';

part '../../../generated/features/dashboard/providers/dashboard_provider.g.dart';

@riverpod
class DashboardNotifier extends _$DashboardNotifier {
  @override
  AsyncValue<HomeResponseModel> build() {
    loadHomeData();
    return const AsyncValue.loading();
  }

  Future<void> loadHomeData() async {
    try {
      state = const AsyncValue.loading();
      final repository = ref.read(dashboardRepositoryProvider);
      final data = await repository.getHomeData();
      state = AsyncValue.data(data);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await loadHomeData();
  }
}