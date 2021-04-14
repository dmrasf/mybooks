import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String labelStr;
  final String? hintStr;
  final RegExp reg;
  final String? errorStr;
  final bool? obscure;
  LoginTextField({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.labelStr,
    this.hintStr,
    required this.reg,
    this.errorStr,
    this.obscure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        maxLines: 1,
        textAlign: TextAlign.left,
        style: GoogleFonts.exo(textStyle: TextStyle()),
        validator: (value) {
          if (value == null || value.isEmpty) return '请输入内容';
          if (!reg.hasMatch(controller.text))
            return errorStr == null ? '格式错误' : errorStr;
          return null;
        },
        obscureText: obscure == null ? false : obscure!,
        decoration: InputDecoration(
          labelText: labelStr,
          hintText: hintStr == null ? '' : hintStr,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          suffixIcon: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () => controller.clear(),
            icon: Icon(Icons.clear),
          ),
        ),
      ),
    );
  }
}
