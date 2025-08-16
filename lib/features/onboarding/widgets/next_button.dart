import 'package:flutter/material.dart';
import 'package:yeong_twitter/constants/sizes.dart';

class NextButton extends StatelessWidget {
  final String? title;
  final bool disabled;
  final VoidCallback onTap;

  const NextButton({
    super.key,
    this.title = "Next",
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
          color: disabled ? Colors.grey.shade500 : Colors.black,
          borderRadius: BorderRadius.circular(Sizes.d32),
        ),
        child: AnimatedDefaultTextStyle(
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: disabled ? Colors.grey.shade300 : Colors.white,
          ),
          duration: Duration(milliseconds: 200),
          textAlign: TextAlign.center,
          child: Text(title!),
        ),
      ),
    );
  }
}
