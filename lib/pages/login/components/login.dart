import 'package:flutter/material.dart';
import 'package:mybooks/pages/login/components/button.dart';
import 'package:mybooks/pages/login/components/textfield.dart';
import 'package:mybooks/pages/components/icon_button.dart';
import 'package:provider/provider.dart';
import 'package:mybooks/models/user_provider.dart';
import 'package:mybooks/models/user.dart';

class LoginInPage extends StatelessWidget {
  final TextEditingController _controllerEmail = TextEditingController();
  final FocusNode _focusNodeEmail = FocusNode();
  final TextEditingController _controllerPassword = TextEditingController();
  final FocusNode _focusNodePassword = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<MyUserModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: MyIconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('登录'),
              Column(
                children: [
                  LoginTextField(
                    controller: _controllerEmail,
                    focusNode: _focusNodeEmail,
                    prefixIcon: Icons.email,
                    labelStr: '邮箱',
                    reg: RegExp(
                        r"^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$"),
                    errorStr: 'xxx@example.com',
                  ),
                  LoginTextField(
                    controller: _controllerPassword,
                    focusNode: _focusNodePassword,
                    prefixIcon: Icons.visibility,
                    labelStr: '密码',
                    hintStr: '6~16位数字和字母',
                    reg: RegExp(r"(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$"),
                    obscure: true,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  LoginButton(() {
                    _unfocus();
                    if (_formKey.currentState!.validate()) {
                      // 服务器 .then
                      userProvider.user = User(
                        email: _controllerEmail.text,
                        token: _controllerPassword.text,
                      );
                      userProvider.isLogin = true;
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacementNamed('/home');
                    }
                  }, '登录'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _unfocus() {
    _focusNodeEmail.unfocus();
    _focusNodePassword.unfocus();
  }
}
