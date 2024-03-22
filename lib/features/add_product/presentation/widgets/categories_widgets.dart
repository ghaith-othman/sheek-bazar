import 'package:flutter/material.dart';
import 'package:sheek/Locale/app_localization.dart';

class CategorySelection extends StatefulWidget {
  final String firstTitle, secondTitle, thirdTitle;

  const CategorySelection(
      {super.key,
      required this.firstTitle,
      required this.secondTitle,
      required this.thirdTitle});

  @override
  State<CategorySelection> createState() => _CategorySelectionState();
}

class _CategorySelectionState extends State<CategorySelection> {
  bool isSelectedMan = false;
  bool isSelectedWoman = false;
  bool isSelectedKids = false;

  void handleCheckboxChange(bool value, String option) {
    setState(() {
      if (option == widget.firstTitle) {
        isSelectedMan = !isSelectedMan;
      } else if (option == widget.secondTitle) {
        isSelectedWoman = !isSelectedWoman;
      } else if (option == widget.thirdTitle) {
        isSelectedKids = !isSelectedKids;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  value: isSelectedMan,
                  onChanged: (value) =>
                      handleCheckboxChange(value!, widget.firstTitle),
                ),
                Text(widget.firstTitle.tr(context)),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: isSelectedWoman,
                  onChanged: (value) =>
                      handleCheckboxChange(value!, widget.secondTitle),
                ),
                Text(widget.secondTitle.tr(context)),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: isSelectedKids,
                  onChanged: (value) =>
                      handleCheckboxChange(value!, widget.thirdTitle),
                ),
                Text(widget.thirdTitle.tr(context)),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
