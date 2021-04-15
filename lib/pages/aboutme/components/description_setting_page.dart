import 'package:flutter/material.dart';
import 'package:mybooks/pages/aboutme/components/appBar_setting.dart';
import 'package:provider/provider.dart';
import 'package:mybooks/models/user_provider.dart';
import 'package:mybooks/pages/components/icon_button.dart';
import 'package:mybooks/pages/aboutme/components/setting_textfield.dart';

class DescriptionSettingPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  DescriptionSettingPage() {
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<MyUserModel>(context);
    _controller.text =
        userProvider.description == null ? '' : userProvider.description!;
    return Scaffold(
      appBar: appBarForSettingPage(context, title: '个性签名设置'),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.only(left: 20),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '个性签名',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 20),
            Expanded(
              child: AboutmeSettingTextField(
                controller: _controller,
                focusNode: _focusNode,
              ),
            ),
            SizedBox(width: 20),
            MyIconButton(
              onPressed: () {
                _focusNode.unfocus();
                if (userProvider.description != _controller.text) {
                  userProvider.description = _controller.text;
                  if (_controller.text.isEmpty) userProvider.description = null;
                }
                Navigator.of(context).pop(true);
              },
              icon: Icon(Icons.check, size: 17),
            ),
          ],
        ),
      ),
    );
  }
}