import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yeong_twitter/constants/gaps.dart';
import 'package:yeong_twitter/constants/sizes.dart';
import 'package:yeong_twitter/constants/text.dart';
import 'package:yeong_twitter/features/authentication/a_whats_happening_screen.dart';
import 'package:yeong_twitter/features/authentication/b_sign_up_screen.dart';
import 'package:yeong_twitter/features/authentication/widgets/expanded_bottom_field.dart';
import 'package:yeong_twitter/features/authentication/widgets/link_text.dart';

class CustomizeScreen extends StatefulWidget {
  final Map<String, String> userData;
  const CustomizeScreen({super.key, required this.userData});

  @override
  State<CustomizeScreen> createState() => _CustomizeScreenState();
}

class _CustomizeScreenState extends State<CustomizeScreen> {
  bool _customize = false;

  void _onCustomizeChanged(bool? newValue) {
    if (newValue == null) return;
    setState(() {
      _customize = newValue;
    });
  }

  void _onLinkTextTap() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WhatsHappeningScreen()),
    );
  }

  void _onNextTap() {
    if (!_customize) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) =>
                SignUpScreen(userData: widget.userData, customize: true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: FaIcon(FontAwesomeIcons.twitter)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.d24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Gaps.v20,
                _buildHeader(),
                Gaps.v20,
                _buildMainSection(),
                Gaps.v32,
              ],
            ),
            _buildLinkText(),
          ],
        ),
      ),
      bottomNavigationBar: ExpandedBottomField(
        disabled: !_customize,
        onTap: _onNextTap,
      ),
    );
  }

  Column _buildHeader() {
    return Column(
      children: [
        TtitleLarge(
          "Customize your experience",
          fontSize: Sizes.d28,
          maxLines: 2,
        ),
        Gaps.v36,
        Opacity(
          opacity: 0.6,
          child: TtitleLarge(
            "Track where you see Twitter content across the web",
            fontSize: Sizes.d20,
            maxLines: 2,
          ),
        ),
      ],
    );
  }

  SwitchListTile _buildMainSection() {
    return SwitchListTile.adaptive(
      value: _customize,
      onChanged: _onCustomizeChanged,
      title: TbodyLarge(
        "Twitter uses this data to personalize your experience. This web browsing history will never be stored with your name, email, or phone number.",
        maxLines: 10,
      ),
      contentPadding: EdgeInsets.zero,
    );
  }

  LinkText _buildLinkText() {
    return LinkText(
      items: [
        LinkTextItem(text: "By signing up, you agree to our "),
        LinkTextItem(text: "Terms", isLinked: true, onTap: _onLinkTextTap),
        LinkTextItem(text: ", "),
        LinkTextItem(
          text: "Privacy Policy",
          isLinked: true,
          onTap: _onLinkTextTap,
        ),
        LinkTextItem(text: ", and "),
        LinkTextItem(text: "Cookie use", isLinked: true, onTap: _onLinkTextTap),
        LinkTextItem(text: ". "),
        LinkTextItem(
          text:
              "Twitter may use your contact information, including your email address and phone number for purposes outlined in our Privacy Policy. ",
        ),
        LinkTextItem(text: "Learn more", isLinked: true, onTap: _onLinkTextTap),
      ],
    );
  }
}
