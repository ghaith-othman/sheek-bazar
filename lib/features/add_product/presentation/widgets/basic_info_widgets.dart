import 'package:flutter/material.dart';
import 'package:sheek/Locale/app_localization.dart';
import 'package:sheek/core/utils/app_constants.dart';

import '../../../../core/utils/app_colors.dart';

class TextFormFieldWithTitle extends StatelessWidget {
  final String hint;
  final Function onChange;
  final bool maxLines;
  const TextFormFieldWithTitle(
      {super.key,
      required this.hint,
      required this.onChange,
      this.maxLines = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppConstant.customSizedBox(0, 10),
        TextFormField(
          maxLines: maxLines ? 2 : 1,
          decoration: InputDecoration(
            labelText: hint.tr(context),
            labelStyle: const TextStyle(color: AppColors.primaryColor),
          ),
          onChanged: (value) {
            onChange(value);
          },
        ),
      ],
    );
  }
}

class SelectProductType extends StatefulWidget {
  final String titleForFirstRadio,
      valueForFirstRadio,
      titleForSecondRadio,
      valueForSecondRadio;
  const SelectProductType({
    super.key,
    required this.valueForFirstRadio,
    required this.valueForSecondRadio,
    required this.titleForFirstRadio,
    required this.titleForSecondRadio,
  });

  @override
  State<SelectProductType> createState() => _SelectProductTypeState();
}

class _SelectProductTypeState extends State<SelectProductType> {
  String selectedGender = "";

  void onGenderSelected(String? value) {
    setState(() {
      selectedGender = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Radio(
              value: widget.valueForFirstRadio,
              groupValue: selectedGender,
              onChanged: onGenderSelected,
            ),
            Text(widget.titleForFirstRadio.tr(context)),
          ],
        ),
        Row(
          children: [
            Radio(
              value: widget.valueForSecondRadio,
              groupValue: selectedGender,
              onChanged: onGenderSelected,
            ),
            Text(widget.titleForSecondRadio.tr(context)),
          ],
        ),
      ],
    );
  }
}
