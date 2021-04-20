import 'package:flutter/material.dart';
import 'package:mybooks/pages/aboutme/components/appBar_setting.dart';
import 'package:mybooks/pages/components/icon_button.dart';
import 'package:mybooks/pages/aboutme/components/setting_textfield.dart';

class NewTagPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  NewTagPage() {
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarForSettingPage(context, title: '新标签'),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.only(left: 20),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('新标签', style: Theme.of(context).textTheme.headline2),
            SizedBox(width: 20),
            Expanded(
              child: AboutmeSettingTextField(
                controller: _controller,
                focusNode: _focusNode,
                maxLength: 10,
              ),
            ),
            SizedBox(width: 20),
            MyIconButton(
              onPressed: () {
                _focusNode.unfocus();
                Navigator.of(context).pop(_controller.text);
              },
              icon: Icon(Icons.check, size: 17),
            ),
          ],
        ),
      ),
    );
  }
}
