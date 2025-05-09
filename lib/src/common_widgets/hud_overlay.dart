// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hud_overlay.g.dart';

/// For testing purpose only!
@visibleForTesting
bool forceShowHUD = false;

@Riverpod(keepAlive: true)
class ShowHudOverlay extends _$ShowHudOverlay {
  @override
  bool build() => false;
  void show() => state = true;
  void hide() => state = false;
}

/// A Head-Up display overlay that aims to be lightweight by utilizing state management with riverpod,
/// and lightweight fade-in animation. This widget should be wrapped on top of a widget that needs
/// to show the HUD overlay.
class HudOverlay extends StatelessWidget {
  const HudOverlay({
    super.key,
    required this.child,
    this.withDelay = true,
  });

  final Widget child;

  /// Intended for testing purpose.
  final bool withDelay;

  static const loadingHudKey = Key("hud-loading");
  static const bgHudKey = Key("hud-bg");

  // Not using a getter, to be easily configured if there's a need for arguments.
  Widget _showOverlayBackground() {
    return Center(
      key: bgHudKey, // ! Whatever the widget is, this key needs to be adapted.
      child: Container(color: Colors.black.withAlpha(120)),
    );
  }

  Widget _showOverlayContent() {
    return const Center(
      key: loadingHudKey, // ! Whatever the widget is, this key needs to be adapted.
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // The content of the widget
        child,
        // Use StatefulBuilder as a Lightweight component.
        StatefulBuilder(
          builder: (context, setState) {
            /// Triggers the sizedBox widget return.
            bool shouldRender = false;

            return Consumer(
              builder: (context, ref, child) {
                final show = ref.watch(showHudOverlayProvider);
                final duration = Duration(milliseconds: (withDelay) ? 800 : 0);

                // If not testing whatsoever, the condition below will apply.
                if (!forceShowHUD) {
                  // Returns nothing when animation ends and show is false.
                  if (!show && !shouldRender) return const SizedBox.shrink();
                }

                return IgnorePointer(
                  child: AnimatedOpacity(
                    opacity: (show) ? 1 : 0,
                    onEnd: () {
                      shouldRender = show;
                      if (!shouldRender) setState(() {});
                    },
                    duration: duration,
                    child: Stack(
                      children: [
                        _showOverlayBackground(),
                        _showOverlayContent(),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
