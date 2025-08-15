import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yeong_twitter/constants/gaps.dart';
import 'package:yeong_twitter/constants/sizes.dart';
import 'package:yeong_twitter/constants/text.dart';
import 'package:yeong_twitter/features/authentication/b_sign_up_screen.dart';
import 'package:yeong_twitter/features/authentication/widgets/auth_button.dart';
import 'package:yeong_twitter/features/authentication/widgets/link_text.dart';

class WhatsHappeningScreen extends StatelessWidget {
  const WhatsHappeningScreen({super.key});

  void onSignUpTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignUpScreen(userData: {}, customize: false),
      ),
    );
  }

  void _onLinkTextTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WhatsHappeningScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: FaIcon(FontAwesomeIcons.twitter)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.d40),
        child: Column(
          children: [
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: Center(
                child: Text(
                  "See what's happening\nin the world right now.",
                  style: TextStyle(
                    fontSize: Sizes.d28,
                    fontWeight: FontWeight.w900,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Flexible(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AuthButton(
                    image: "google.png",
                    text: "Continue with Google",
                    mode: Mode.light,
                  ),
                  Gaps.v10,
                  AuthButton(
                    image: "apple.png",
                    text: "Continue with Apple",
                    mode: Mode.light,
                  ),
                  Gaps.v20,
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey.shade600,
                          thickness: 0.5,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Sizes.d10),
                        child: TlabelSmall("or", color: Colors.grey.shade700),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey.shade600,
                          thickness: 0.5,
                        ),
                      ),
                    ],
                  ),
                  Gaps.v8,
                  GestureDetector(
                    onTap: () => onSignUpTap(context),
                    child: AuthButton(text: "Create account", mode: Mode.dark),
                  ),
                  Gaps.v28,
                  LinkText(
                    items: [
                      LinkTextItem(text: "By signing up, you agree to our "),
                      LinkTextItem(
                        text: "Terms",
                        isLinked: true,
                        onTap: () => _onLinkTextTap(context),
                      ),
                      LinkTextItem(text: ", "),
                      LinkTextItem(
                        text: "Privacy Policy",
                        isLinked: true,
                        onTap: () => _onLinkTextTap(context),
                      ),
                      LinkTextItem(text: ", and "),
                      LinkTextItem(
                        text: "Cookie use",
                        isLinked: true,
                        onTap: () => _onLinkTextTap(context),
                      ),
                      LinkTextItem(text: "."),
                    ],
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Row(
                children: [
                  TbodyMedium(
                    "Have an account already?",
                    color: Colors.grey.shade700,
                  ),
                  Gaps.h4,
                  TbodyMedium("Log in", color: Theme.of(context).primaryColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
