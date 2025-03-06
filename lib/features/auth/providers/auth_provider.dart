import 'package:ai_english/features/auth/data/auth_repository_provider.dart';
import 'package:ai_english/features/auth/models/auth_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_provider.g.dart';

const String _authTokenKey = 'auth_token';
const String _refreshTokenKey = 'refresh_token';

@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthState build() {
    // Initialize and try to restore session
    _restoreSession();
    return const AuthState();
  }

  Future<void> _restoreSession() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(_authTokenKey);
      final refreshToken = prefs.getString(_refreshTokenKey);

      if (token != null && refreshToken != null) {
        state = state.copyWith(
          token: Token(
            access_token: token,
            refresh_token: refreshToken,
            token_type: 'bearer',
          ),
          isLoading: true,
        );

        // Validate token by getting user info
        await getCurrentUser();
      }
    } catch (e) {
      await _clearSession();
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: false,
        errorMessage: 'Session expired. Please sign in again.',
      );
    }
  }

  Future<void> _saveSession(Token token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_authTokenKey, token.access_token);
    await prefs.setString(_refreshTokenKey, token.refresh_token);
  }

  Future<void> _clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_authTokenKey);
    await prefs.remove(_refreshTokenKey);
  }

  // Modified: Now returns String for email to display on verification page
  Future<String> signUp(String email, String password) async {
    try {
      state = state.copyWith(isLoading: true, errorMessage: null);

      final repository = ref.read(authRepositoryProvider);
      await repository.signUp(email, password);

      // No longer signing in automatically after registration
      state = state.copyWith(
        isLoading: false,
        // Keep isAuthenticated as false
      );

      // Return the email for display in the verification page
      return email;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to sign up: ${e.toString()}',
      );
      rethrow;
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      state = state.copyWith(isLoading: true, errorMessage: null);

      final repository = ref.read(authRepositoryProvider);
      final token = await repository.signIn(email, password);

      await _saveSession(token);

      state = state.copyWith(
        token: token,
        isLoading: false,
        isAuthenticated: true,
      );

      // Get user info
      await getCurrentUser();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to sign in: ${e.toString()}',
      );
    }
  }

  Future<void> signOut() async {
    await _clearSession();
    state = const AuthState();
  }

  Future<void> refreshToken() async {
    if (state.token == null) return;

    try {
      final repository = ref.read(authRepositoryProvider);
      final newToken =
          await repository.refreshToken(state.token!.refresh_token);

      await _saveSession(newToken);

      state = state.copyWith(token: newToken);
    } catch (e) {
      // If refresh fails, sign out
      await signOut();
    }
  }

  Future<void> getCurrentUser() async {
    if (state.token == null) return;

    try {
      final repository = ref.read(authRepositoryProvider);
      final user = await repository.getCurrentUser(state.token!.access_token);

      state = state.copyWith(
        user: user,
        isAuthenticated: true,
        isLoading: false,
      );
    } catch (e) {
      // If token is invalid, try to refresh
      try {
        await refreshToken();
        // Try again with new token
        final repository = ref.read(authRepositoryProvider);
        final user = await repository.getCurrentUser(state.token!.access_token);

        state = state.copyWith(
          user: user,
          isAuthenticated: true,
          isLoading: false,
        );
      } catch (e) {
        // If refresh fails, sign out
        await signOut();
      }
    }
  }
}
