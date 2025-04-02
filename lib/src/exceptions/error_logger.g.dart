// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_logger.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$errorLoggerHash() => r'7b218ca355d3a47fb1653e16bcbc688e6a5584b9';

/// Basic usage would be:
/// ```
/// try {}
/// catch (e, st) {
///    ref.read(errorLoggerProvider).logError(e, st);
/// }
/// ```
///
/// Copied from [errorLogger].
@ProviderFor(errorLogger)
final errorLoggerProvider = AutoDisposeProvider<ErrorLogger>.internal(
  errorLogger,
  name: r'errorLoggerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$errorLoggerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ErrorLoggerRef = AutoDisposeProviderRef<ErrorLogger>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
