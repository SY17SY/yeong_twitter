import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yeong_twitter/constants/gaps.dart';
import 'package:yeong_twitter/constants/sizes.dart';
import 'package:yeong_twitter/constants/text.dart';

enum Mode { light, dark }

class AuthButton extends StatelessWidget {
  final IconData? icon;
  final String? image;
  final String text;
  final Mode mode;
  const AuthButton({
    super.key,
    this.icon,
    this.image,
    required this.text,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: Sizes.d20),
        decoration: BoxDecoration(
          color: mode == Mode.dark ? Colors.black : null,
          borderRadius: BorderRadius.circular(Sizes.d32),
          border:
              mode == Mode.light
                  ? Border.all(color: Colors.grey.shade300, width: Sizes.d1)
                  : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null || image != null) ...[
              icon != null
                  ? FaIcon(icon, size: Sizes.d20)
                  : Image.asset("assets/images/$image", width: Sizes.d20),
              Gaps.h8,
            ],
            TtitleSmall(
              text,
              textAlign: TextAlign.center,
              color: mode == Mode.dark ? Colors.white : null,
            ),
          ],
        ),
      ),
    );
  }
}
