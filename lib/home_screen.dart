import 'package:flutter/material.dart';
import 'package:flutter_badge_generator/badge.dart';
import 'package:flutter_badge_generator/functions.dart';

import 'config/config.dart';
import 'constants.dart';
import 'data/badge_collection.dart';
import 'widgets/badge_widget.dart';
import 'widgets/generate_button.dart';
import 'widgets/output_code_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Badge? currentBadge;
  String? outputCodeText;
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: appBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            badgeCollection(),
            const SizedBox(height: 15),
            badgeBadgetitle(),
            const SizedBox(height: 30),
            currentBadgeSection(),
            const SizedBox(height: 30),
            generateButton(),
            const SizedBox(height: 15),
            OutputCodeSection(outputCodeText),
          ],
        ),
      ),
    );
  }

  Widget currentBadgeSection() {
    return SizedBox(
      width: sectionWidth,
      height: 200,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: currentBadgeWidget()),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: currentBadgeDescription()),
                Expanded(child: currentBadgeLinkInputSection()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget currentBadgeDescription() {
    return Text(
      currentBadge?.description ?? "",
      textAlign: TextAlign.left,
    );
  }

  Widget currentBadgeLinkInputSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(strings.badgeLink),
        const SizedBox(height: 5),
        TextField(
          maxLines: 1,
          controller: textController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  Widget badgeBadgetitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(strings.currentBadge),
    );
  }

  AppBar appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: const Text(
        appTitle,
        style: TextStyle(color: Colors.blue),
      ),
    );
  }

  Widget badgeCollection() {
    return badgeCollectionPlaceHolder();
  }

  Widget badgeCollectionPlaceHolder() {
    return Container(
      height: 120,
      width: sectionWidth,
      color: Colors.grey.shade200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ...badgeCollectionItems
              .map((curBadge) => badgeCollectionItemWidget(curBadge))
              .toList(),
        ],
      ),
    );
  }

  Widget currentBadgeWidget() {
    return SizedBox(
      height: 220,
      child: BadgeWidget(
        imagePath: currentBadge?.imagePath,
        label: currentBadge?.label,
        themeColor: appThemeColor,
        type: currentBadge != null
            ? BadgeWidgetType.selected
            : BadgeWidgetType.none,
        fontSize: 16,
      ),
    );
  }

  Widget badgeCollectionItemWidget(Badge badge) {
    return GestureDetector(
      child: BadgeWidget(
        imagePath: badge.imagePath,
        label: badge.label,
        themeColor: appThemeColor,
        type: BadgeWidgetType.collection,
        fontSize: 10,
      ),
      onTap: () {
        setState(() {
          currentBadge = badge;
        });
      },
    );
  }

  Widget generateButton() {
    return GenerateButton(
      onPressed: () {
        if (currentBadge != null) {
          setState(() {
            outputCodeText = createOutputCode(
              currentBadge!,
              textController.text,
            );
          });
        }
      },
    );
  }
}
