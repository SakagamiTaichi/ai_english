import 'package:ai_english/core/http/api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_client_provider.g.dart';

// グローバルで唯一の ApiClient インスタンスを提供するプロバイダー
// keepAlive を true にすることで、アプリケーション全体でインスタンスが保持される
@Riverpod(keepAlive: true)
ApiClient apiClient(Ref ref) {
  return ApiClient();
}
