import 'package:flutter/material.dart';
import 'package:mybooks/pages/aboutme/components/appBar_setting.dart';
import 'package:provider/provider.dart';
import 'package:mybooks/models/user_provider.dart';
import 'package:mybooks/pages/components/icon_button.dart';
import 'package:mybooks/pages/aboutme/components/setting_textfield.dart';

class NameSettingPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  NameSettingPage() {
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<MyUserModel>(context);
    _controller.text = userProvider.name == null ? '' : userProvider.name!;
    return Scaffold(
      appBar: appBarForSettingPage(context, title: '昵称设置'),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.only(left: 20),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('新的昵称', style: Theme.of(context).textTheme.headline2),
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
                if (userProvider.name != _controller.text) {
                  userProvider.name = _controller.text;
                  if (_controller.text.isEmpty) userProvider.name = null;
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
