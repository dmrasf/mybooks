import 'package:flutter/material.dart';
import 'package:mybooks/pages/login/components/button.dart';
import 'package:mybooks/pages/login/components/textfield.dart';
import 'package:mybooks/pages/login/components/login.dart';
import 'package:mybooks/utils/change_page.dart';
import 'package:provider/provider.dart';
import 'package:mybooks/models/user_provider.dart';
import 'package:mybooks/models/user.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controllerEmail = TextEditingController();
  final FocusNode _focusNodeEmail = FocusNode();
  final TextEditingController _controllerPassword = TextEditingController();
  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController _controllerPassword2 = TextEditingController();
  final FocusNode _focusNodePassword2 = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<MyUserModel>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        alignment: Alignment.center,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '创建新用户',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
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
                  LoginTextField(
                    controller: _controllerPassword2,
                    focusNode: _focusNodePassword2,
                    prefixIcon: Icons.visibility,
                    labelStr: '确认密码',
                    hintStr: '重新输入确认密码',
                    controller2: _controllerPassword,
                    errorStr: '不一致',
                    obscure: true,
                  ),
                ],
              ),
              Column(
                children: [
                  LoginButton(() {
                    _unfocus();
                    if (_formKey.currentState!.validate()) {
                      //
                      // 服务器 .then
                      //
                      userProvider.user = User(
                        email: _controllerEmail.text,
                        token: md5
                            .convert(Utf8Encoder().convert(
                              _controllerPassword.text,
                            ))
                            .toString(),
                      );
                      userProvider.isLogin = true;
                      _formKey.currentState!.reset();
                      Navigator.of(context).pushReplacementNamed('/home');
                    }
                  }, '注册'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('已有账户 ？'),
                      LoginInButton(() {
                        _unfocus();
                        _formKey.currentState!.reset();
                        ChangePage.fadeChangePage(context, LoginInPage());
                      }, '登录')
                    ],
                  ),
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
    _focusNodePassword2.unfocus();
  }
}
