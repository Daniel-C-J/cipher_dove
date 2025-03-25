import 'package:cipher_dove/src/core/_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../common_widgets/custom_button.dart';
import '../../../../constants/_constants.dart';
import '../../../../routing/app_router.dart';
import '../../../../util/context_shortcut.dart';
import '../cipher_mode_state.dart';

class AlgorithmSelected extends ConsumerWidget {
  const AlgorithmSelected({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cipherAlgorithm = ref.watch(cipherModeStateProvider).algorithm;
    final brightness = ref.watch(platformBrightnessProvider);

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: kScreenWidth(context) * 0.55),
      child: CustomButton(
        msg: "Select Algorithm",
        onTap: () {
          context.pushNamed(AppRoute.algorithmSelection.name);
        },
        isOutlined: true,
        borderWidth: 1,
        borderColor: PRIMARY_COLOR_L0,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.hardEdge,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.asset(
                  "./assets/images/icon/binary.png",
                  width: 22.5,
                  height: 22.5,
                  color: (brightness == Brightness.light) ? PRIMARY_COLOR_D1 : PRIMARY_COLOR_L1,
                ),
              ),
              GAP_W8,
              Text(
                cipherAlgorithm.name,
                overflow: TextOverflow.fade,
                style: kTextStyle(context).bodyMedium?.copyWith(
                      color: (brightness == Brightness.light) ? PRIMARY_COLOR_D1 : PRIMARY_COLOR_L1,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
