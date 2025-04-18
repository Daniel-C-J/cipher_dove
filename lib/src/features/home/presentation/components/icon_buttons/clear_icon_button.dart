import 'package:cipher_dove/src/features/home/presentation/input_output_form_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../../../common_widgets/custom_button.dart';
import '../../../../../util/context_shortcut.dart';

/// Used to only just clean the value of input text controller.
class ClearInputIconButton extends ConsumerWidget {
  const ClearInputIconButton({super.key});

  static const buttonKey = Key("ClearInputIconButton");

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomButton(
      key: buttonKey,
      msg: "Remove all Input".tr(),
      padding: const EdgeInsets.all(4),
      buttonColor: Colors.transparent,
      borderRadius: BorderRadius.circular(60),
      onTap: () {
        ref.read(inputTextFormStateProvider).clear();
      },
      child: Icon(
        BoxIcons.bxs_eraser,
        size: 20.5,
        color: kColor(context).inverseSurface,
      ),
    );
  }
}

/// Used to only just clean the value of output text controller.
class ClearOutputIconButton extends ConsumerWidget {
  const ClearOutputIconButton({super.key});

  static const buttonKey = Key("ClearOutputIconButton");

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomButton(
      key: buttonKey,
      msg: "Remove all Output".tr(),
      padding: const EdgeInsets.all(4),
      buttonColor: Colors.transparent,
      borderRadius: BorderRadius.circular(60),
      onTap: () {
        ref.read(outputTextFormStateProvider.notifier).clear();
      },
      child: Icon(
        BoxIcons.bxs_eraser,
        size: 20.5,
        color: kColor(context).inverseSurface,
      ),
    );
  }
}
