import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cipher_dove/src/features/cipher/presentation/components/cipher_action_switch.dart';
import 'package:cipher_dove/src/features/cipher/presentation/components/algorithm_selected.dart';
import 'package:cipher_dove/src/features/cipher/presentation/components/process_button.dart';
import 'package:cipher_dove/src/features/home/presentation/components/home_appbar.dart';
import 'package:cipher_dove/src/features/home/presentation/components/home_screen_input.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../constants/_constants.dart';
import '../../version_check/domain/version_check.dart';
import '../../version_check/presentation/version_check_controller.dart';
import '../../version_check/presentation/version_update_dialog.dart';
import 'components/home_screen_output.dart';

// To prevent multi checking.
bool _updateIsChecked = false;

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      // Check the version when the app starts.
      if (mounted && !_updateIsChecked) await _checkVersionUpdate();
    });
  }

  Future<void> _checkVersionUpdate() async {
    _updateIsChecked = true; // Flagging.

    final controller = ref.read(versionCheckControllerProvider.notifier);
    await controller.checkData(
      onSuccess: (VersionCheck ver) async {
        // Do nothing if there's no update available.
        if (!ver.canUpdate || !mounted) return;
        return await VersionUpdateDialog.show(context, ver);
      },
      onError: (e, st) async {
        if (!mounted) return;
        return await VersionUpdateDialog.showErrorInstead(context, e: e);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // To prevent future already completed error.
    // ignore: unused_local_variable
    final versionCheck = ref.watch(versionCheckControllerProvider);

    return Scaffold(
      appBar: HomeAppBar(),
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
          content: Text("Tap again to exit.".tr()),
          dismissDirection: DismissDirection.horizontal,
        ),
        child: const SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeScreenInput(),
              GAP_H32,
              CipherActionSwitch(),
              GAP_H12,
              Row(children: [AlgorithmSelected(), Spacer(), ProcessButton()]),
              GAP_H32,
              HomeScreenOutput(),
            ],
          ),
        ),
      ),
    );
  }
}
