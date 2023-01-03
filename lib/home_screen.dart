import 'package:flutter/material.dart';
import 'package:flutter_badge_generator/badge.dart';
import 'package:flutter_badge_generator/functions.dart';
import 'package:url_launcher/url_launcher.dart';

import 'config/config.dart';
import 'constants.dart';
import 'data/badge_collection.dart';
import 'widgets/badge_widget.dart';
import 'widgets/output_code_section.dart';
import 'widgets/section_decoration.dart';
import 'widgets/section_padding.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Badge? currentBadge;
  String? outputCodeText;

  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: appBar(),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8.0),
        color: appThemeColor,
        child: GestureDetector(
          child: const Text(
            "by DC Flutter Community",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          onTap: () async {
            await launchUrl(
              Uri.parse(
                  "https://www.developerchallenge.org/dc-flutter-community"),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                badgeCollection(),
                const SizedBox(height: 20),
                badgeBadgetitle(),
                const SizedBox(height: 15),
                currentBadgeSection(),
                const SizedBox(height: 30),
                const SizedBox(height: 15),
                outputCodeSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget outputCodeSection() {
    return (currentBadge !=
            null /*  &&
            outputCodeText != null &&
            outputCodeText!.isNotEmpty */
        )
        ? Container(
            width: sectionWidth,
            padding: sectionPadding,
            decoration: sectionDecoration(Colors.white),
            child: OutputCodeSection(outputCodeText))
        : const SizedBox();
  }

  Widget currentBadgeSection() {
    return Container(
      width: sectionWidth,
      height: 250,
      padding: sectionPadding,
      decoration: sectionDecoration(Colors.white),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: currentBadgeWidget()),
              const SizedBox(width: 15),
              Expanded(
                flex: 2,
                child: currentBadge == null
                    ? const SizedBox()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          currentBadgeLinkInputSection(),
                          const Divider(
                            height: 24,
                          ),
                          currentBadgeDefinition(),
                        ],
                      ),
              ),
            ],
          ),
          if (currentBadge == null)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_upward_rounded,
                    size: 36,
                    color: Colors.grey.shade500,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    strings.selectBadge,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }

  Widget currentBadgeDefinition() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          strings.description,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Text(
          currentBadge?.description ?? "",
          textAlign: TextAlign.left,
        ),
      ],
    );
  }

  Widget currentBadgeLinkInputSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          strings.badgeLink,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextField(
          maxLines: 1,
          controller: textEditingController,
          onChanged: (final String newValue) {
            setState(() {
              outputCodeText = createOutputCode(
                currentBadge!,
                textEditingController.text,
              );
            });
          },
          decoration: InputDecoration(
            helperText: "Url should start with http/https",
            hintText: currentBadge?.linkHint ?? "",
            hintStyle: const TextStyle(fontSize: 14),
            border: const OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  Widget badgeBadgetitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        strings.currentBadge,
        style: const TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.blur_circular,
            color: appThemeColor,
          ),
          const SizedBox(width: 10),
          Text(
            appTitle,
            style: TextStyle(color: appThemeColor, fontWeight: FontWeight.w600),
          ),
        ],
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
      decoration: sectionDecoration(
        Colors.grey.shade200,
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: badgeCollectionItems.length,
        itemBuilder: (context, index) {
          Badge curBadge = badgeCollectionItems[index];
          return badgeCollectionItemWidget(curBadge);
        },
        separatorBuilder: (_, __) {
          return const VerticalDivider(
            indent: 15,
            endIndent: 15,
          );
        },
      ),
    );
  }

  Widget currentBadgeWidget() {
    return SizedBox(
      height: 220,
      child: BadgeWidget(
        imagePath: currentBadge?.imageName,
        label: currentBadge?.label,
        themeColor: appThemeColor,
        type: currentBadge == null
            ? BadgeWidgetType.none
            : textEditingController.text.isNotEmpty
                ? BadgeWidgetType.selected
                : BadgeWidgetType.collection,
        fontSize: 16,
      ),
    );
  }

  Widget badgeCollectionItemWidget(Badge badge) {
    return GestureDetector(
      child: BadgeWidget(
        imagePath: badge.imageName,
        label: badge.label,
        themeColor: appThemeColor,
        type: BadgeWidgetType.collection,
        fontSize: 10,
      ),
      onTap: () {
        setState(
          () {
            currentBadge = badge;
            textEditingController.clear();

            if (textEditingController.text.isNotEmpty) {
              outputCodeText = createOutputCode(
                currentBadge!,
                textEditingController.text,
              );
            } else {
              outputCodeText = "";
            }
          },
        );
      },
    );
  }
}
