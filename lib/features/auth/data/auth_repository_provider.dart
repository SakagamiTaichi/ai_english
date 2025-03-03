import 'package:ai_english/core/http/api_client.dart';
import 'package:ai_english/features/auth/data/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository_provider.g.dart';

@riverpod
IAuthRepository authRepository(Ref ref) {
  return AuthRepository(ApiClient());
}
