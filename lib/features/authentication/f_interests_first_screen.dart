import 'package:flutter/material.dart';
import 'package:yeong_twitter/constants/gaps.dart';
import 'package:yeong_twitter/constants/sizes.dart';
import 'package:yeong_twitter/constants/text.dart';
import 'package:yeong_twitter/features/authentication/g_interests_second_screen.dart';
import 'package:yeong_twitter/features/authentication/widgets/form_button.dart';

const interests = [
  "Fashion & beauty",
  "Outdoors",
  "Arts & culture",
  "Animation & comics",
  "Business & finance",
  "Food",
  "Travel",
  "Entertainment",
  "Music",
  "Gaming",
  "Family",
  "Fitness & Health",
  "Dance",
  "Home & Garden",
  "Daily Life",
  "Comedy",
  "Animals",
  "Learning",
  "Sports",
];

class InterestsFirstScreen extends StatefulWidget {
  const InterestsFirstScreen({super.key});

  @override
  State<InterestsFirstScreen> createState() => _InterestsFirstScreenState();
}

class _InterestsFirstScreenState extends State<InterestsFirstScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showTitle = false;
  final int _itemLength = 0;

  void _onScroll() {
    if (_scrollController.offset > 100) {
      if (_showTitle) return;
      setState(() {
        _showTitle = true;
      });
    } else {
      if (!_showTitle) return;
      setState(() {
        _showTitle = false;
      });
    }
  }

  String _showItemLength() {
    return "$_itemLength of 3 selected";
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _onScroll();
    });
  }

  void _onInterestTap() {}

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onNextTap() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InterestsSecondScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AnimatedOpacity(
          opacity: _showTitle ? 1 : 0,
          duration: Duration(milliseconds: 300),
          child: TtitleLarge("Choose your interests"),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(Sizes.d24, 0, Sizes.d24, Sizes.d24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TtitleLarge(
              "What do you want to see on Twitter?",
              fontSize: Sizes.d36,
              maxLines: 3,
            ),
            Gaps.v20,
            Opacity(
              opacity: 0.5,
              child: TbodyLarge(
                "Select at least 3 interests to personalize your Twitter experience. They will be visible on your profile.",
                maxLines: 5,
              ),
            ),
            Gaps.v64,
            Expanded(
              child: GridView.builder(
                controller: _scrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: Sizes.d10,
                  mainAxisSpacing: Sizes.d10,
                  childAspectRatio: 2,
                ),
                itemCount: interests.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: _onInterestTap,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Sizes.d10,
                        vertical: Sizes.d10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: Sizes.d2,
                        ),
                        borderRadius: BorderRadius.circular(Sizes.d10),
                      ),
                      alignment: Alignment.bottomLeft,
                      child: TtitleSmall(interests[index], maxLines: 3),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.d32,
          vertical: Sizes.d10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Opacity(opacity: 0.7, child: TbodySmall(_showItemLength())),
            FormButton(disabled: false, onTap: _onNextTap),
          ],
        ),
      ),
    );
  }
}
