// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appRouter)
final appRouterProvider = AppRouterProvider._();

final class AppRouterProvider
    extends $FunctionalProvider<GoRouter, GoRouter, GoRouter>
    with $Provider<GoRouter> {
  AppRouterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appRouterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appRouterHash();

  @$internal
  @override
  $ProviderElement<GoRouter> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GoRouter create(Ref ref) {
    return appRouter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoRouter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoRouter>(value),
    );
  }
}

String _$appRouterHash() => r'b292f82b084cfa918acbf425c7fa2378d8520428';

@ProviderFor(appDeepLinkSubscription)
final appDeepLinkSubscriptionProvider = AppDeepLinkSubscriptionProvider._();

final class AppDeepLinkSubscriptionProvider
    extends
        $FunctionalProvider<
          StreamSubscription<Uri>,
          StreamSubscription<Uri>,
          StreamSubscription<Uri>
        >
    with $Provider<StreamSubscription<Uri>> {
  AppDeepLinkSubscriptionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDeepLinkSubscriptionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDeepLinkSubscriptionHash();

  @$internal
  @override
  $ProviderElement<StreamSubscription<Uri>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  StreamSubscription<Uri> create(Ref ref) {
    return appDeepLinkSubscription(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StreamSubscription<Uri> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StreamSubscription<Uri>>(value),
    );
  }
}

String _$appDeepLinkSubscriptionHash() =>
    r'77bb2bc312ee85f3d2fbe37eabb5ddc9775b68b4';
