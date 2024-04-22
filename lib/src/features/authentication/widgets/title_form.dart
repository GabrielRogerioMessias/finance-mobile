import 'package:finance_mobile/src/constants/text_constants.dart';
import 'package:flutter/material.dart';

class TitleForm extends StatelessWidget {
  const TitleForm({
    super.key,
    required this.titleText,
  });

  final String titleText;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        titleText,
        style: kTitleTextStyle,
      ),
    );
  }
}
