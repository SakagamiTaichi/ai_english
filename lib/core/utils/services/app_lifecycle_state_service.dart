import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../../../generated/core/utils/services/app_lifecycle_state_service.g.dart';

@riverpod
class AppLifecycleService extends _$AppLifecycleService
    with WidgetsBindingObserver {
  @override
  AppLifecycleState build() {
    // プロバイダ構築時に監視を開始。
    final binding = WidgetsBinding.instance..addObserver(this);
    // プロバイダが破棄された時に監視を解除。
    ref.onDispose(() => binding.removeObserver(this));
    // 初期値として `resumed` を返している。
    return AppLifecycleState.resumed;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // `AppLifecycleState` の変更を検知してNotifierが持つ状態を更新。
    this.state = state;
    super.didChangeAppLifecycleState(state);
  }
}
