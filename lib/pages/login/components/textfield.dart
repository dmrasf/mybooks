import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextEditingController? controller2;
  final FocusNode focusNode;
  final IconData prefixIcon;
  final String hintStr;
  final RegExp? reg;
  final String? errorStr;
  final bool? obscure;
  LoginTextField({
    Key? key,
    required this.controller,
    this.controller2,
    required this.focusNode,
    required this.prefixIcon,
    required this.hintStr,
    this.reg,
    this.errorStr,
    this.obscure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.center,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        maxLines: 1,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: 20,
          textBaseline: TextBaseline.alphabetic,
          fontWeight: FontWeight.w300,
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
        cursorColor: Theme.of(context).buttonColor.withOpacity(0.7),
        decoration: InputDecoration(
          labelText: null,
          hintText: hintStr,
          hintStyle: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            textBaseline: TextBaseline.alphabetic,
            color: Theme.of(context).buttonColor.withOpacity(0.6),
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
