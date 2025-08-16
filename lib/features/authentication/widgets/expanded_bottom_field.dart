import 'package:flutter/material.dart';
import 'package:yeong_twitter/constants/gaps.dart';
import 'package:yeong_twitter/features/authentication/widgets/form_button.dart';

class ExpandedBottomField extends StatelessWidget {
  final String textButtonTitle;
  final VoidCallback? onTextButtonTap;
  final bool disabled;
  final VoidCallback onTap;
  final bool customize;
  const ExpandedBottomField({
    super.key,
    this.textButtonTitle = "",
    this.onTextButtonTap,
    this.disabled = false,
    required this.onTap,
    this.customize = false,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (textButtonTitle.isNotEmpty) ...[
            TextButton(
              onPressed: onTextButtonTap ?? () {},
              child: Text(textButtonTitle),
            ),
            Gaps.v4,
          ],
          Row(
            children: [
              Expanded(
                child: FormButton(
                  disabled: disabled,
                  onTap: onTap,
                  customize: customize,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
