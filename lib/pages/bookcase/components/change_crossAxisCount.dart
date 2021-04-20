import 'package:flutter/material.dart';

const _ChineseNumer = {
  1: '壹',
  2: '贰',
  3: '叁',
  4: '肆',
  5: '伍',
  6: '陆',
  7: '柒',
  8: '捌',
  9: '玖',
  0: '零',
};

class ChangeCrossAxisCount extends StatelessWidget {
  final int crossAxisCount;
  final VoidCallback? onPressed;
  ChangeCrossAxisCount({
    this.onPressed,
    required this.crossAxisCount,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(_ChineseNumer[crossAxisCount]!),
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        ),
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        minimumSize: MaterialStateProperty.all(Size.zero),
        foregroundColor: MaterialStateProperty.all(
          Theme.of(context).buttonColor.withOpacity(0.5),
        ),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
    );
  }
}
