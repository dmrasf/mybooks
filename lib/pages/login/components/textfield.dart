import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextEditingController? controller2;
  final FocusNode focusNode;
  final IconData prefixIcon;
  final String labelStr;
  final String? hintStr;
  final RegExp? reg;
  final String? errorStr;
  final bool? obscure;
  LoginTextField({
    Key? key,
    required this.controller,
    this.controller2,
    required this.focusNode,
    required this.prefixIcon,
    required this.labelStr,
    this.hintStr,
    this.reg,
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
        style: GoogleFonts.geo(
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w100,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return '请输入内容';
          RegExp? r = reg;
          if (r == null && controller2 != null)
            r = RegExp('\^' + controller2!.text + '\$');
          if (!r!.hasMatch(controller.text))
            return errorStr == null ? '格式错误' : errorStr;
          return null;
        },
        obscureText: obscure == null ? false : obscure!,
        cursorWidth: 1,
        cursorHeight: 17,
        cursorColor: Theme.of(context).buttonColor.withOpacity(0.7),
        decoration: InputDecoration(
          labelText: labelStr,
          labelStyle: TextStyle(
            fontSize: 13,
            color: Theme.of(context).buttonColor.withOpacity(0.6),
            fontWeight: FontWeight.bold,
          ),
          hintText: hintStr == null ? '' : hintStr,
          hintStyle: TextStyle(
            fontSize: 10,
            color: Theme.of(context).buttonColor.withOpacity(0.3),
          ),
          prefixIcon: Icon(
            prefixIcon,
            size: 16,
            color: Theme.of(context).buttonColor.withOpacity(0.6),
          ),
          border: InputBorder.none,
          fillColor: Theme.of(context).primaryColor,
          filled: true,
        ),
      ),
    );
  }
}
