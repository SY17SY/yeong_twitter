import 'package:flutter/material.dart';
import 'package:yeong_twitter/constants/sizes.dart';
import 'package:yeong_twitter/constants/text.dart';

class FormButton extends StatelessWidget {
  final String? title;
  final bool customize;
  final bool disabled;
  final VoidCallback onTap;

  const FormButton({
    super.key,
    this.title = "Next",
    this.customize = false,
    required this.disabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(
          vertical: Sizes.d14,
          horizontal: Sizes.d24,
        ),
        decoration: BoxDecoration(
          color:
              disabled
                  ? Colors.grey.shade500
                  : customize
                  ? Theme.of(context).primaryColor
                  : Colors.black,
          borderRadius: BorderRadius.circular(Sizes.d32),
        ),
        child: TtitleLarge(
          customize ? "Sign up" : title!,
          color: disabled ? Colors.grey.shade300 : Colors.white,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
