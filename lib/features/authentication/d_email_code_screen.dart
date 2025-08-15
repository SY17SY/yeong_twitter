import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yeong_twitter/constants/gaps.dart';
import 'package:yeong_twitter/constants/sizes.dart';
import 'package:yeong_twitter/constants/text.dart';
import 'package:yeong_twitter/features/authentication/e_password_screen.dart';
import 'package:yeong_twitter/features/authentication/widgets/form_button.dart';

class EmailCodeScreen extends StatefulWidget {
  final Map<String, String> userData;
  const EmailCodeScreen({super.key, required this.userData});

  @override
  State<EmailCodeScreen> createState() => _EmailCodeScreenState();
}

class _EmailCodeScreenState extends State<EmailCodeScreen> {
  final List<TextEditingController> _codeControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  bool _codeValid = false;

  @override
  void initState() {
    super.initState();
    for (var codeController in _codeControllers) {
      codeController.addListener(() {
        setState(() {});
      });
    }
  }

  void _onTextFieldTap() {
    final firstEmptyIndex = _codeControllers.indexWhere(
      (c) => c.text.trim().isEmpty,
    );
    final targetIndex =
        (firstEmptyIndex == -1) ? _focusNodes.length - 1 : firstEmptyIndex;
    FocusScope.of(context).requestFocus(_focusNodes[targetIndex]);
  }

  void _checkCodeComplete() {
    final code =
        _codeControllers.map((controller) => controller.text.trim()).join();
    setState(() {
      _codeValid = code.length == 6;
    });
  }

  @override
  void dispose() {
    for (var codeController in _codeControllers) {
      codeController.dispose();
    }
    super.dispose();
    for (var node in _focusNodes) {
      node.dispose();
    }
  }

  void _onNextTap() {
    if (_codeValid) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PasswordScreen()),
      );
    }
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(title: FaIcon(FontAwesomeIcons.twitter)),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.d24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.v20,
                  TtitleLarge("We sent you a code", fontSize: Sizes.d28),
                  Gaps.v20,
                  Opacity(
                    opacity: 0.5,
                    child: TbodyLarge(
                      "Enter it below to verify ${widget.userData["email"]}",
                      maxLines: 3,
                    ),
                  ),
                  Gaps.v40,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: Sizes.d8,
                    children: List.generate(
                      6,
                      (index) => Expanded(
                        child: TextField(
                          controller: _codeControllers[index],
                          focusNode: _focusNodes[index],
                          onTap: _onTextFieldTap,
                          maxLength: 1,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
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
                            _checkCodeComplete();
                            if (value.isNotEmpty && index < 5) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  Gaps.v20,
                  if (_codeValid)
                    Align(
                      alignment: Alignment.center,
                      child: FaIcon(
                        FontAwesomeIcons.solidCircleCheck,
                        size: Sizes.d32,
                        color: Colors.green,
                      ),
                    ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              child: BottomAppBar(
                elevation: 0,
                color: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: Sizes.d24,
                  vertical: Sizes.d10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text("Didn't receive email?"),
                    ),
                    Gaps.v4,
                    Row(
                      children: [
                        Expanded(
                          child: FormButton(
                            disabled: !_codeValid,
                            onTap: _onNextTap,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
