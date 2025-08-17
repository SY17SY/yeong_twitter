import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yeong_twitter/constants/gaps.dart';
import 'package:yeong_twitter/constants/sizes.dart';
import 'package:yeong_twitter/constants/text.dart';
import 'package:yeong_twitter/constants/interest_details.dart';
import 'package:yeong_twitter/features/authentication/a_whats_happening_screen.dart';
import 'package:yeong_twitter/features/onboarding/widgets/next_button.dart';

class InterestsSecondScreen extends StatefulWidget {
  final List<int> selectedIndexes;
  const InterestsSecondScreen({super.key, required this.selectedIndexes});

  @override
  State<InterestsSecondScreen> createState() => _InterestsSecondScreenState();
}

class _InterestsSecondScreenState extends State<InterestsSecondScreen> {
  final ScrollController _scrollController = ScrollController();
  final Map<int, List<String>> _selectedDetails = {};
  int _itemLength = 0;
  bool _showTitle = false;

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

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _onScroll();
    });
  }

  void _onDetailTap(int index, String detail) {
    if (_selectedDetails.containsKey(index) &&
        _selectedDetails[index]!.contains(detail)) {
      _selectedDetails[index]!.remove(detail);
      _itemLength--;
    } else {
      if (!_selectedDetails.containsKey(index)) {
        _selectedDetails[index] = [];
      }
      _selectedDetails[index]!.add(detail);
      _itemLength++;
    }
    setState(() {});
  }

  bool _isSelected(int index, String detail) {
    if (!_selectedDetails.containsKey(index)) return false;
    return _selectedDetails[index]!.contains(detail);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onNextTap() {
    if (_itemLength < 3) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WhatsHappeningScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Scrollbar(
          controller: _scrollController,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                for (var index in widget.selectedIndexes)
                  _buildInterestDetailSection(index, context),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomSection(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
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
    );
  }

  Padding _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes.d24),
      child: Column(
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
              "Interests are used to personalize your experience and will be visible on your profile.",
              maxLines: 5,
            ),
          ),
          Gaps.v20,
          Divider(color: Colors.grey.shade400, thickness: 0.5),
        ],
      ),
    );
  }

  Column _buildInterestDetailSection(int index, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gaps.v20,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.d20),
          child: TtitleLarge(interests[index]),
        ),
        Gaps.v28,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: Sizes.d20),
          child: SizedBox(
            width: Sizes.d100 * 20,
            child: Wrap(
              spacing: Sizes.d10,
              runSpacing: Sizes.d10,
              children: [
                for (var detail in interestDetails[index])
                  _buildInterestDetailItem(index, detail, context),
              ],
            ),
          ),
        ),
        Gaps.v20,
        Divider(
          color: Colors.grey.shade400,
          thickness: 0.5,
          indent: Sizes.d16,
          endIndent: Sizes.d16,
        ),
      ],
    );
  }

  GestureDetector _buildInterestDetailItem(
    int index,
    String detail,
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () => _onDetailTap(index, detail),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.d20,
          vertical: Sizes.d16,
        ),
        decoration: BoxDecoration(
          color:
              _isSelected(index, detail)
                  ? Theme.of(context).primaryColor
                  : null,
          borderRadius: BorderRadius.circular(Sizes.d32),
          border: Border.all(
            color:
                _isSelected(index, detail)
                    ? Theme.of(context).primaryColor
                    : Colors.grey.shade300,
          ),
        ),
        child: AnimatedDefaultTextStyle(
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: _isSelected(index, detail) ? Colors.white : Colors.black,
          ),
          duration: Duration(milliseconds: 200),
          child: Text(detail),
        ),
      ),
    );
  }

  BottomAppBar _buildBottomSection() {
    return BottomAppBar(
      elevation: 1,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: Sizes.d32, vertical: Sizes.d10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [NextButton(disabled: _itemLength < 3, onTap: _onNextTap)],
      ),
    );
  }
}
