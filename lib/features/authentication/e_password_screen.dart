import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yeong_twitter/constants/gaps.dart';
import 'package:yeong_twitter/constants/sizes.dart';
import 'package:yeong_twitter/constants/text.dart';
import 'package:yeong_twitter/features/onboarding/f_interests_first_screen.dart';
import 'package:yeong_twitter/features/authentication/widgets/form_button.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();

  String _password = "";
  bool _validatedLength = false;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
  }

  String? _isPasswordValid() {
    final baseRegExp = r"[A-Za-z0-9@$!%*#?&\^]";
    final regExpLen = r"{8,20}";
    String? result;

    final regExp = RegExp(r"^" + baseRegExp + regExpLen);
    if (!regExp.hasMatch(_password)) {
      _validatedLength = false;
      result = "비밀번호는 8~20자로 작성해주세요.";
    } else {
      _validatedLength = true;
    }
    setState(() {});
    return result;
  }

  void _toggleObscure() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _onNextTap() {
    if (!_validatedLength) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InterestsFirstScreen()),
    );
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
                  _buildHeader(),
                  if (_password.isNotEmpty) TbodyMedium("Password"),
                  _buildPasswordField(context),
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
        Gaps.v20,
        TtitleLarge("You'll need a password", fontSize: Sizes.d28),
        Gaps.v20,
        Opacity(
          opacity: 0.5,
          child: TbodyLarge(
            "Make sure it's 8 characters or more.",
            maxLines: 3,
          ),
        ),
        Gaps.v32,
      ],
    );
  }

  TextField _buildPasswordField(BuildContext context) {
    return TextField(
      controller: _passwordController,
      onEditingComplete: _onNextTap,
      autocorrect: false,
      obscureText: _obscureText,
      cursorColor: Theme.of(context).primaryColor,
      decoration: InputDecoration(
        hintText: "Password",
        errorText: _isPasswordValid(),
        suffix: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: _toggleObscure,
              child: FaIcon(
                _obscureText ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
                color: Colors.grey.shade400,
              ),
            ),
            Gaps.h16,
            if (_validatedLength) ...[
              FaIcon(FontAwesomeIcons.solidCircleCheck, color: Colors.green),
              Gaps.h8,
            ],
          ],
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
      ),
    );
  }

  Positioned _buildBottomSection(BuildContext context) {
    return Positioned(
      bottom: 0,
      width: MediaQuery.of(context).size.width,
      child: BottomAppBar(
        elevation: 0,
        color: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.d24,
          vertical: Sizes.d18,
        ),
        child: Row(
          children: [
            Expanded(
              child: FormButton(disabled: !_validatedLength, onTap: _onNextTap),
            ),
          ],
        ),
      ),
    );
  }
}
