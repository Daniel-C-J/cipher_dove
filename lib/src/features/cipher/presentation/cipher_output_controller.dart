import 'package:cipher_dove/src/features/cipher/data/local/local_cipher_repo.dart';
import 'package:cipher_dove/src/util/delay.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/cipher_action.dart';
import '../domain/cipher_algorithm.dart';
import '../domain/cipher_mode.dart';

part 'cipher_output_controller.g.dart';

@Riverpod(keepAlive: true)
class CipherOutputController extends _$CipherOutputController {
  @override
  FutureOr<void> build() {}

  Future<String> process(
    String input,
    String secretKey, {
    required CipherMode mode,
  }) async {
    final repo = ref.read(localCipherRepositoryProvider);
    String output = "";

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      // Small delay
      await delay(true, 400);

      if (mode.action == CipherAction.encrypt) {
        //
        if (mode.algorithm.type == CipherAlgorithmType.symmetric) {
          output = await repo.encryptSymmetric(
            input,
            secretKey,
            algorithm: mode.algorithm,
          );
          return;
        }

        if (mode.algorithm.type == CipherAlgorithmType.asymmetric) {
          output = await repo.encryptAsymmetric(input, mode: mode);
          return;
        }

        if (mode.algorithm.type == CipherAlgorithmType.hash) {
          output = await repo.hash(input, mode: mode);
          return;
        }
      }

      // Expected to be CipherAction.decrypt
      if (mode.algorithm.type == CipherAlgorithmType.symmetric) {
        output = await repo.decryptSymmetric(
          input,
          secretKey,
          algorithm: mode.algorithm,
        );
        return;
      }

      if (mode.algorithm.type == CipherAlgorithmType.asymmetric) {
        output = await repo.decryptAsymmetric(input, mode: mode);
        return;
      }

      // Hash cannot be decrypted.
    });

    return output;
  }
}
