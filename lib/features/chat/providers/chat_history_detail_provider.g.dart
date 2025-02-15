// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_history_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$asyncChatHistoryDetailHash() =>
    r'5cdfb5501865cebc3228a2cd8f772c0a79458523';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$AsyncChatHistoryDetail
    extends BuildlessAutoDisposeAsyncNotifier<List<ChatHistoryDetail>> {
  late final String id;

  FutureOr<List<ChatHistoryDetail>> build(
    String id,
  );
}

/// See also [AsyncChatHistoryDetail].
@ProviderFor(AsyncChatHistoryDetail)
const asyncChatHistoryDetailProvider = AsyncChatHistoryDetailFamily();

/// See also [AsyncChatHistoryDetail].
class AsyncChatHistoryDetailFamily
    extends Family<AsyncValue<List<ChatHistoryDetail>>> {
  /// See also [AsyncChatHistoryDetail].
  const AsyncChatHistoryDetailFamily();

  /// See also [AsyncChatHistoryDetail].
  AsyncChatHistoryDetailProvider call(
    String id,
  ) {
    return AsyncChatHistoryDetailProvider(
      id,
    );
  }

  @override
  AsyncChatHistoryDetailProvider getProviderOverride(
    covariant AsyncChatHistoryDetailProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'asyncChatHistoryDetailProvider';
}

/// See also [AsyncChatHistoryDetail].
class AsyncChatHistoryDetailProvider
    extends AutoDisposeAsyncNotifierProviderImpl<AsyncChatHistoryDetail,
        List<ChatHistoryDetail>> {
  /// See also [AsyncChatHistoryDetail].
  AsyncChatHistoryDetailProvider(
    String id,
  ) : this._internal(
          () => AsyncChatHistoryDetail()..id = id,
          from: asyncChatHistoryDetailProvider,
          name: r'asyncChatHistoryDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$asyncChatHistoryDetailHash,
          dependencies: AsyncChatHistoryDetailFamily._dependencies,
          allTransitiveDependencies:
              AsyncChatHistoryDetailFamily._allTransitiveDependencies,
          id: id,
        );

  AsyncChatHistoryDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  FutureOr<List<ChatHistoryDetail>> runNotifierBuild(
    covariant AsyncChatHistoryDetail notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(AsyncChatHistoryDetail Function() create) {
    return ProviderOverride(
      origin: this,
      override: AsyncChatHistoryDetailProvider._internal(
        () => create()..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<AsyncChatHistoryDetail,
      List<ChatHistoryDetail>> createElement() {
    return _AsyncChatHistoryDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AsyncChatHistoryDetailProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AsyncChatHistoryDetailRef
    on AutoDisposeAsyncNotifierProviderRef<List<ChatHistoryDetail>> {
  /// The parameter `id` of this provider.
  String get id;
}

class _AsyncChatHistoryDetailProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<AsyncChatHistoryDetail,
        List<ChatHistoryDetail>> with AsyncChatHistoryDetailRef {
  _AsyncChatHistoryDetailProviderElement(super.provider);

  @override
  String get id => (origin as AsyncChatHistoryDetailProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
