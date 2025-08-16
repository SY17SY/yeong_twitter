import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yeong_twitter/constants/gaps.dart';
import 'package:yeong_twitter/constants/sizes.dart';
import 'package:yeong_twitter/constants/text.dart';
import 'package:yeong_twitter/features/onboarding/g_interests_second_screen.dart';
import 'package:yeong_twitter/features/onboarding/widgets/next_button.dart';

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
  final GlobalKey<NestedScrollViewState> nestedScrollViewKey =
      GlobalKey<NestedScrollViewState>();
  final List<int> _selectedIndexes = [];
  bool _showTitle = false;

  bool _onNotification(ScrollNotification notification) {
    double outer = notification.metrics.pixels;
    double inner = 0.0;
    double totalOffset = outer;
    final NestedScrollViewState? nestedScrollViewState =
        nestedScrollViewKey.currentState;
    if (nestedScrollViewState != null) {
      inner = nestedScrollViewState.innerController.position.pixels;
      if (inner > 0) {
        totalOffset = outer + inner + 100;
      }
    }
    if (notification is ScrollUpdateNotification) {
      if (totalOffset > 100) {
        if (_showTitle) return false;
        setState(() {
          _showTitle = true;
        });
      } else {
        if (!_showTitle) return false;
        setState(() {
          _showTitle = false;
        });
      }
    }
    return true;
  }

  void _onInterestTap(int index) {
    if (_selectedIndexes.contains(index)) {
      _selectedIndexes.remove(index);
    } else {
      _selectedIndexes.add(index);
    }
    setState(() {});
  }

  String _showItemLength() {
    return "${_selectedIndexes.length} of 3 selected";
  }

  void _onNextTap() {
    if (_selectedIndexes.length < 3) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) =>
                InterestsSecondScreen(selectedIndexes: _selectedIndexes),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child:
              _showTitle
                  ? TtitleLarge(
                    "Choose your interests",
                    color: Theme.of(context).primaryColor,
                  )
                  : FaIcon(FontAwesomeIcons.twitter),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.d24),
          child: NotificationListener<ScrollNotification>(
            onNotification: _onNotification,
            child: NestedScrollView(
              key: nestedScrollViewKey,
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gaps.v20,
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
                        Gaps.v20,
                      ],
                    ),
                  ),
                ];
              },
              body: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: Sizes.d10,
                  mainAxisSpacing: Sizes.d10,
                  childAspectRatio: 2,
                ),
                padding: EdgeInsets.zero,
                itemCount: interests.length,
                itemBuilder: (context, index) {
                  bool isSelected = _selectedIndexes.contains(index);
                  return GestureDetector(
                    onTap: () => _onInterestTap(index),
                    child: Stack(
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          padding: EdgeInsets.symmetric(
                            horizontal: Sizes.d10,
                            vertical: Sizes.d10,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? Theme.of(context).primaryColor
                                    : null,
                            border: Border.all(
                              color:
                                  isSelected
                                      ? Theme.of(context).primaryColor
                                      : Colors.grey.shade300,
                              width: Sizes.d2,
                            ),
                            borderRadius: BorderRadius.circular(Sizes.d10),
                          ),
                          alignment: Alignment.bottomLeft,
                          child: AnimatedDefaultTextStyle(
                            style: Theme.of(
                              context,
                            ).textTheme.titleSmall!.copyWith(
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                            duration: Duration(milliseconds: 200),
                            child: Text(interests[index]),
                          ),
                        ),
                        if (isSelected)
                          Positioned(
                            top: Sizes.d12,
                            right: Sizes.d12,
                            child: FaIcon(
                              FontAwesomeIcons.solidCircleCheck,
                              color: Colors.white,
                              size: Sizes.d20,
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
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
            NextButton(
              disabled: _selectedIndexes.length < 3,
              onTap: _onNextTap,
            ),
          ],
        ),
      ),
    );
  }
}
