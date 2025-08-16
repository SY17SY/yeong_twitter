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
            child: CallbackShortcuts(
              bindings: {
                const SingleActivator(LogicalKeyboardKey.backspace): () {
                  if (widget.codeControllers[index].text.isEmpty && index > 0) {
                    widget.codeControllers[index - 1].clear();
                    FocusScope.of(
                      context,
                    ).requestFocus(widget.focusNodes[index - 1]);
                    widget.checkCodeComplete();
                  }
                },
                const SingleActivator(LogicalKeyboardKey.delete): () {
                  if (widget.codeControllers[index].text.isEmpty && index > 0) {
                    widget.codeControllers[index - 1].clear();
                    FocusScope.of(
                      context,
                    ).requestFocus(widget.focusNodes[index - 1]);
                    widget.checkCodeComplete();
                  }
                },
              },
              child: TextField(
                controller: widget.codeControllers[index],
                focusNode: widget.focusNodes[index],
                onTap: widget.onTextFieldTap,
                maxLength: 1,
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
                      color: Colors.black,
                      width: Sizes.d2,
                    ),
                  ),
                ),
                onChanged: (value) {
                  widget.checkCodeComplete();
                  if (value.isNotEmpty && index < 5) {
                    FocusScope.of(context).nextFocus();
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
