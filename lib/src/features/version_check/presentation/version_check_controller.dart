import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../exceptions/_exceptions.dart';
import '../../../util/notifier_mounted.dart';
import '../data/remote_version_repo.dart';
import '../domain/version_check.dart';

part 'version_check_controller.g.dart';

@riverpod
class VersionCheckController extends _$VersionCheckController with NotifierMounted {
  @override
  FutureOr<void> build() {
    ref.onDispose(setUnmounted);
  }

  Future<void> checkData({
    required void Function(VersionCheck val) onSuccess,
    required void Function(Object e, StackTrace? st) onError,
  }) async {
    if (!mounted) return;

    final versionRepo = ref.read(versionCheckRepoProvider);
    late final VersionCheck versionCheck;

    state = const AsyncLoading();
    // For some good reason, AsyncGuard doesn't catch the error.
    try {
      versionCheck = await versionRepo.getVersionCheck();
      state = const AsyncData(null);

      // Typically calls for a showDialog widget.
      return onSuccess(versionCheck);
    } catch (e, st) {
      state = AsyncError(e, st);

      // Throws custom exception.
      final error = state.asError?.error;
      return _handleErrors(error, onError: onError);
    }
  }

  void _handleErrors(
    Object? error, {
    required void Function(AppException e, StackTrace? st) onError,
  }) {
    if (error is DioException) {
      final netError = ref.read(netErrorHandlerProvider).handle(error);
      return onError(netError, state.stackTrace);
    }

    // Doesn't care what kind of exception, just return the formatted one.
    return onError(UpdateCheckException(), state.stackTrace);
  }

  @visibleForTesting
  void handleErrors(Object? error, {required void Function(Object e, StackTrace? st) onError}) =>
      _handleErrors(error, onError: onError);
}
