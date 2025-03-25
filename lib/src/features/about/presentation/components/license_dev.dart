import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../common_widgets/custom_button.dart';
import '../../../../constants/_constants.dart';
import '../../../../core/_core.dart';
import '../../../../routing/app_router.dart';
import '../../../../util/context_shortcut.dart';

class LicenseDev extends StatelessWidget {
  const LicenseDev({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Licenses",
          textAlign: TextAlign.center,
          style: kTextStyle(context).bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        GAP_H4,
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("Licensed under", textAlign: TextAlign.center, style: kTextStyle(context).bodySmall),
            GAP_W6,
            Text(
              "MIT License.",
              textAlign: TextAlign.center,
              style: kTextStyle(context).bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        GAP_H4,
        CustomButton(
          onTap: () async {
            context.pushNamed(AppRoute.license.name);
          },
          msg: "See dependencies",
          buttonColor: PRIMARY_COLOR_D1,
          borderRadius: BorderRadius.circular(8),
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.open_in_new, size: 16, color: Colors.white),
              GAP_W6,
              Text(
                "See dependencies",
                textAlign: TextAlign.center,
                style: kTextStyle(context).bodySmall?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
