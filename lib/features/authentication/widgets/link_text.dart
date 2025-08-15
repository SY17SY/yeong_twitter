import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LinkTextItem {
  String text;
  bool isLinked;
  Function()? onTap;

  LinkTextItem({required this.text, this.isLinked = false, this.onTap});
}

class LinkText extends StatelessWidget {
  final List<LinkTextItem> items;
  const LinkText({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    TextStyle mainTextStyle = Theme.of(
      context,
    ).textTheme.bodyMedium!.copyWith(color: Colors.grey.shade700, height: 1.4);
    TextStyle linkedTextStyle = Theme.of(context).textTheme.bodyMedium!
        .copyWith(color: Theme.of(context).primaryColor, height: 1.4);

    TextSpan getTextSpan(LinkTextItem item) {
      if (item.isLinked) {
        return TextSpan(
          text: item.text,
          style: linkedTextStyle,
          recognizer: TapGestureRecognizer()..onTap = item.onTap,
        );
      } else {
        return TextSpan(text: item.text, style: mainTextStyle);
      }
    }

    return RichText(
      text: TextSpan(
        text: items[0].text,
        style: items[0].isLinked ? linkedTextStyle : mainTextStyle,
        recognizer:
            items[0].isLinked
                ? (TapGestureRecognizer()..onTap = items[0].onTap)
                : null,
        children: [for (var item in items.skip(1)) getTextSpan(item)],
      ),
    );
  }
}
