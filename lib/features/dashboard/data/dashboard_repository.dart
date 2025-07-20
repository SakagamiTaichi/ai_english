import 'package:ai_english/core/http/iapi_client.dart';
import 'package:ai_english/features/dashboard/models/dashboard_api_models.dart';

abstract class IDashboardRepository {
  Future<HomeResponseModel> getHomeData();
}

class DashboardRepository implements IDashboardRepository {
  final IApiClient _apiClient;

  DashboardRepository(this._apiClient);

  @override
  Future<HomeResponseModel> getHomeData() async {
    try {
      final response = await _apiClient.get('/home');
      return HomeResponseModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}