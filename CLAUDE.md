# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Commands

### Code Generation
- `dart run build_runner build` - Generate code for Riverpod providers, Freezed models, and JSON serialization
- `dart run build_runner build --delete-conflicting-outputs` - Force regenerate all generated files
- `dart run build_runner watch` - Watch for changes and auto-generate code

### Testing
- `flutter test` - Run all unit tests
- `flutter test test/features/chat/providers/` - Run specific test directory

### Linting and Analysis
- `flutter analyze` - Run static analysis
- `dart fix --apply` - Apply automated fixes for linting issues

### Build Commands
- `flutter build apk` - Build Android APK
- `flutter build ios` - Build iOS app
- `flutter build web` - Build web version
- `flutter run` - Run in debug mode
- `flutter run --release` - Run in release mode

## Architecture

This is a Flutter application for English learning with AI conversation practice, built using:

### State Management
- **Riverpod** with code generation for state management
- Generated providers in `lib/generated/` directory (auto-generated, do not edit)
- Provider files use `@riverpod` annotations and require code generation

### Code Generation
The app heavily uses code generation for:
- **Freezed**: Immutable data models (`.freezed.dart` files)
- **JSON Serialization**: API model serialization (`.g.dart` files)  
- **Riverpod**: Provider generation (`_provider.g.dart` files)

Generated files are placed in `lib/generated/` with the same directory structure as source files.

### Project Structure
- `lib/core/` - Shared utilities, themes, HTTP clients, constants
  - `http/` - API client with Dio, interceptors for auth and error handling
  - `theme/` - App theming
  - `utils/` - TTS, notifications, deep linking services
- `lib/features/` - Feature-based modules
  - `auth/` - Authentication (sign in/up, email verification, password reset)
  - `dashboard/` - Main dashboard with learning stats and recommendations
  - `practice/` - Conversation practice with AI, recall tests
  - `settings/` - App settings and theme selection
- `lib/firebase_options.dart` - Firebase configuration
- `lib/main.dart` - App entry point with Firebase initialization

### Key Technologies
- **Firebase**: Crashlytics, messaging, core services
- **Dio**: HTTP client with custom interceptors
- **TTS**: Text-to-speech functionality
- **Deep Linking**: App links for navigation
- **Local Notifications**: Push notification handling

### API Integration
- Base API client in `core/http/api_client.dart`
- Authentication interceptor automatically adds tokens
- Error interceptor handles API errors globally
- Repository pattern for data layer

### Models and Serialization
All data models use Freezed for immutability and JSON serialization:
- API models in `models/*_api_models.dart`
- Domain models in `models/*.dart`
- Generated serialization methods handle JSON conversion

## Important Notes

- Always run `dart run build_runner build` after modifying models or providers
- Generated files are excluded from analysis in `analysis_options.yaml`
- The app uses Firebase for crash reporting and messaging
- Authentication tokens are automatically managed by interceptors
- All state is managed through Riverpod providers with code generation