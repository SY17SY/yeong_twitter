import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yeong_twitter/constants/sizes.dart';

class CodeField extends StatefulWidget {
  final List<TextEditingController> codeControllers;
  final List<FocusNode> focusNodes;
  final VoidCallback onTextFieldTap;
  final VoidCallback checkCodeComplete;
  const CodeField({
    super.key,
    required this.codeControllers,
    required this.focusNodes,
    required this.onTextFieldTap,
    required this.checkCodeComplete,
  });

  @override
  State<CodeField> createState() => _CodeFieldState();
}

class _CodeFieldState extends State<CodeField> {
  void _onTextChanged(String value, int index) {
    if (value.length > 1) {
      var chars = value.split('');
      int i = index;
      for (var char in chars) {
        if (i >= widget.codeControllers.length) break;
        widget.codeControllers[i].text = char;
        i++;
      }

      if (i < widget.codeControllers.length) {
        FocusScope.of(context).requestFocus(widget.focusNodes[i - 1]);
      } else {
        FocusScope.of(context).unfocus();
      }
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(widget.focusNodes[index - 1]);
    }
    widget.checkCodeComplete();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTextFieldTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: Sizes.d8,
        children: List.generate(
          6,
          (index) => Expanded(
            child: TextField(
              controller: widget.codeControllers[index],
              focusNode: widget.focusNodes[index],
              ignorePointers: true,
              maxLength: 6,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(fontSize: Sizes.d24),
              decoration: InputDecoration(
                counterText: "",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                    width: Sizes.d2,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                    width: Sizes.d2,
                  ),
                ),
              ),
              onChanged: (value) => _onTextChanged(value, index),
            ),
          ),
        ),
      ),
    );
  }
}
