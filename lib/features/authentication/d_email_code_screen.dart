import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yeong_twitter/constants/gaps.dart';
import 'package:yeong_twitter/constants/sizes.dart';
import 'package:yeong_twitter/constants/text.dart';
import 'package:yeong_twitter/features/authentication/e_password_screen.dart';
import 'package:yeong_twitter/features/authentication/widgets/code_field.dart';
import 'package:yeong_twitter/features/authentication/widgets/expanded_bottom_field.dart';

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
    int targetIndex = (firstEmptyIndex == 0) ? 0 : firstEmptyIndex - 1;
    if (firstEmptyIndex == -1) targetIndex = 5;
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
                  _buildHeader(),
                  Gaps.v40,
                  _buildCodeSection(),
                ],
              ),
            ),
            _buildBottomSection(context),
          ],
        ),
      ),
    );
  }

  Column _buildHeader() {
    return Column(
      children: [
        TtitleLarge("We sent you a code", fontSize: Sizes.d28),
        Gaps.v20,
        Opacity(
          opacity: 0.5,
          child: TbodyLarge(
            "Enter it below to verify ${widget.userData["email"]}",
            maxLines: 3,
          ),
        ),
      ],
    );
  }

  Column _buildCodeSection() {
    return Column(
      children: [
        CodeField(
          codeControllers: _codeControllers,
          focusNodes: _focusNodes,
          onTextFieldTap: _onTextFieldTap,
          checkCodeComplete: _checkCodeComplete,
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
    );
  }

  Positioned _buildBottomSection(BuildContext context) {
    return Positioned(
      bottom: 0,
      width: MediaQuery.of(context).size.width,
      child: ExpandedBottomField(
        textButtonTitle: "Didn't receive email?",
        disabled: !_codeValid,
        onTap: _onNextTap,
      ),
    );
  }
}
