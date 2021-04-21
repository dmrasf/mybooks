import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mybooks/pages/aboutme/components/setting_textfield.dart';
import 'package:mybooks/pages/components/icon_button.dart';

class AddTagTextfield extends StatelessWidget {
  final void Function(String)? listener;
  AddTagTextfield({this.listener});

  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 60,
      padding: EdgeInsets.only(left: 20, right: 20),
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '新标签 ：',
            style: GoogleFonts.jua(
              textStyle: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 15,
                color: Theme.of(context).buttonColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: AboutmeSettingTextField(
              controller: _controller,
              focusNode: _focusNode,
            ),
          ),
          SizedBox(width: 30),
          MyIconButton(
            onPressed: () {
              String newText = _controller.text;
              _controller.clear();
              _focusNode.unfocus();
              if (newText == '') return;
              if (listener == null) return;
              listener!(newText);
            },
            icon: Icon(
              Icons.check,
              color: Theme.of(context).buttonColor,
              size: 30,
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(9)),
      ),
    );
  }
}
