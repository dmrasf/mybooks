import 'package:flutter/material.dart';

class AboutmeSettingTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final int? maxLength;

  AboutmeSettingTextField({
    Key? key,
    required this.controller,
    required this.focusNode,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
      controller: controller,
      focusNode: focusNode,
      cursorColor: Theme.of(context).buttonColor,
      cursorWidth: 3,
      cursorRadius: Radius.circular(3),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: maxLength == null ? '' : '最多${maxLength!}个字符',
        hintStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w800,
          color: Theme.of(context).buttonColor.withOpacity(0.1),
        ),
        counterText: '',
      ),
      maxLength: maxLength,
    );
  }
}
