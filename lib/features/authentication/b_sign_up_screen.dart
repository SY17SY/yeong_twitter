import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yeong_twitter/constants/gaps.dart';
import 'package:yeong_twitter/constants/sizes.dart';
import 'package:yeong_twitter/constants/text.dart';
import 'package:yeong_twitter/features/authentication/a_whats_happening_screen.dart';
import 'package:yeong_twitter/features/authentication/c_customize_screen.dart';
import 'package:yeong_twitter/features/authentication/d_email_code_screen.dart';
import 'package:yeong_twitter/features/authentication/widgets/form_button.dart';
import 'package:yeong_twitter/features/authentication/widgets/link_text.dart';

final _greenColor = Color(0xFF6FB686);

class SignUpScreen extends StatefulWidget {
  final Map<String, String> userData;
  final bool customize;
  const SignUpScreen({
    super.key,
    required this.userData,
    required this.customize,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();

  final DateTime maxDate = DateTime.now().add(
    const Duration(days: -(12 * 365)),
  );
  final int maxYear = DateTime.now().year - 12;
  String _name = "";
  String _email = "";
  String _birthday = "";

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() {
        _email = _emailController.text;
      });
    });
    _nameController.addListener(() {
      setState(() {
        _name = _nameController.text;
      });
    });
    if (widget.customize) {
      _name = widget.userData["name"]!;
      _email = widget.userData["email"]!;
      _birthday = widget.userData["birthday"]!;
      _nameController.value = TextEditingValue(text: _name);
      _emailController.value = TextEditingValue(text: _email);
      _birthdayController.value = TextEditingValue(text: _birthday);
    }
  }

  bool _isNameValid() {
    if (_name.isEmpty) return false;
    return true;
  }

  String? _isEmailValid() {
    if (_email.isEmpty) return null;
    final regExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    if (!regExp.hasMatch(_email)) {
      return "Email not valid";
    }
    return null;
  }

  void _setTextFieldDate(DateTime date) {
    final textDate = date.toString().split(" ").first;
    _birthday = textDate;
    _birthdayController.value = TextEditingValue(text: textDate);
  }

  void _onBirthdayTap() {
    FocusScope.of(context).unfocus();
    showCupertinoModalPopup(
      context: context,
      builder:
          (context) => Container(
            height: 280,
            color: Colors.white,
            child: SafeArea(
              top: false,
              child: SizedBox(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  maximumYear: maxYear,
                  initialDateTime: maxDate,
                  onDateTimeChanged: _setTextFieldDate,
                ),
              ),
            ),
          ),
    );
  }

  void _onLinkTextTap() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WhatsHappeningScreen()),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _birthdayController.dispose();
    super.dispose();
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onNextTap() {
    if (_isEmailValid() != null) return;
    widget.userData["name"] = _name;
    widget.userData["email"] = _email;
    widget.userData["birthday"] = _birthday;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomizeScreen(userData: widget.userData),
      ),
    );
  }

  void _onSignUpTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EmailCodeScreen(userData: widget.userData),
      ),
    );
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
                  TtitleLarge("Create your account", fontSize: Sizes.d28),
                  Gaps.v36,
                  if (_isNameValid()) TbodyMedium("Name"),
                  TextField(
                    controller: _nameController,
                    autocorrect: false,
                    cursorColor: Theme.of(context).primaryColor,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                    decoration: InputDecoration(
                      hintText: "Name",
                      suffix:
                          _isNameValid()
                              ? FaIcon(
                                FontAwesomeIcons.solidCircleCheck,
                                size: Sizes.d20,
                                color: _greenColor,
                              )
                              : null,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                    ),
                  ),
                  Gaps.v32,
                  if (_email.isNotEmpty) TbodyMedium("Email"),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    cursorColor: Theme.of(context).primaryColor,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                    decoration: InputDecoration(
                      hintText: "Email",
                      errorText: _isEmailValid(),
                      suffix:
                          _email.isNotEmpty && _isEmailValid() == null
                              ? FaIcon(
                                FontAwesomeIcons.solidCircleCheck,
                                size: Sizes.d20,
                                color: _greenColor,
                              )
                              : null,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                    ),
                  ),
                  Gaps.v32,
                  if (_birthday.isNotEmpty) TbodyMedium("Date of birth"),
                  TextField(
                    onTap: _onBirthdayTap,
                    controller: _birthdayController,
                    readOnly: true,
                    showCursor: false,
                    cursorColor: Theme.of(context).primaryColor,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                    decoration: InputDecoration(
                      hintText: "Date of birth",
                      suffix:
                          _isNameValid()
                              ? FaIcon(
                                FontAwesomeIcons.solidCircleCheck,
                                size: Sizes.d20,
                                color: _greenColor,
                              )
                              : null,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                    ),
                  ),
                  Gaps.v10,
                  if (!widget.customize)
                    Opacity(
                      opacity: 0.5,
                      child: TbodyMedium(
                        "This will not be shown publicly. Confirm your own age, even if this account is for a business, a pet, or something else.",
                        maxLines: 3,
                      ),
                    ),
                  if (widget.customize)
                    LinkText(
                      items: [
                        LinkTextItem(text: "By signing up, you agree to our "),
                        LinkTextItem(
                          text: "Terms",
                          isLinked: true,
                          onTap: _onLinkTextTap,
                        ),
                        LinkTextItem(text: ", "),
                        LinkTextItem(
                          text: "Privacy Policy",
                          isLinked: true,
                          onTap: _onLinkTextTap,
                        ),
                        LinkTextItem(text: ", and "),
                        LinkTextItem(
                          text: "Cookie use",
                          isLinked: true,
                          onTap: _onLinkTextTap,
                        ),
                        LinkTextItem(text: ". "),
                        LinkTextItem(
                          text:
                              "Twitter may use your contact information, including your email address and phone number for purposes outlined in our Privacy Policy. ",
                        ),
                        LinkTextItem(
                          text: "Learn more",
                          isLinked: true,
                          onTap: _onLinkTextTap,
                        ),
                        LinkTextItem(
                          text:
                              "Others will be able to find you by email or phone number, when provided, unless you choose otherwise ",
                        ),
                        LinkTextItem(
                          text: "here",
                          isLinked: true,
                          onTap: _onLinkTextTap,
                        ),
                        LinkTextItem(text: ". "),
                      ],
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
                  horizontal: Sizes.d40,
                  vertical: Sizes.d10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    widget.customize
                        ? Expanded(
                          child: FormButton(
                            customize: widget.customize,
                            disabled: false,
                            onTap: _onSignUpTap,
                          ),
                        )
                        : FormButton(
                          disabled:
                              !_isNameValid() ||
                              _email.isEmpty ||
                              _isEmailValid() != null ||
                              _birthday.isEmpty,
                          onTap: _onNextTap,
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
