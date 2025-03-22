import 'package:cipher_dove/src/features/cipher/data/cipher_action.dart';
import 'package:cipher_dove/src/features/cipher/presentation/cipher_mode_state.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../../common_widgets/generic_title.dart';
import '../../../../core/_core.dart';
import '../../../../util/context_shortcut.dart';

class CipherActionSwitch extends ConsumerWidget {
  const CipherActionSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cipherMode = ref.watch(cipherModeStateProvider);
    final cipherAction = cipherMode.action;

    return ToggleSwitch(
      initialLabelIndex: cipherAction.index,
      activeBorders: [Border.all(color: PRIMARY_COLOR_L0)],
      inactiveBgColor: kColor(context).surfaceDim,
      minHeight: 30,
      totalSwitches: 2,
      animationDuration: 500,
      animate: true,
      customWidths: [kScreenWidth(context) * 0.5, kScreenWidth(context) * 0.5],
      customWidgets: [
        Transform.scale(
          scale: 0.9,
          child: GenericTitle(
            title: "Encrypt ",
            titleColor: (cipherAction == CipherAction.encrypt) ? Colors.white : null,
            iconColor: (cipherAction == CipherAction.encrypt) ? Colors.white : null,
            icon: Icons.lock,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
        Transform.scale(
          scale: 0.9,
          child: GenericTitle(
            title: "Decrypt ",
            titleColor: (cipherAction == CipherAction.decrypt) ? Colors.white : null,
            iconColor: (cipherAction == CipherAction.decrypt) ? Colors.white : null,
            icon: Icons.key,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ],
      onToggle: (index) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          ref.read(cipherModeStateProvider.notifier).mode =
              cipherMode.copyWith(action: CipherAction.values[index ?? 0]);
        });
      },
    );
  }
}
