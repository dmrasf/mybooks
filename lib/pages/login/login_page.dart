import 'package:flutter/material.dart';
import 'package:mybooks/utils/location.dart';
import 'package:mybooks/pages/login/components/button.dart';
import 'package:mybooks/pages/login/components/textfield.dart';
import 'package:mybooks/pages/login/components/login.dart';
import 'package:mybooks/utils/change_page.dart';

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
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('创建新用户'),
              Column(
                children: [
                  LoginTextField(
                    controller: _controllerEmail,
                    focusNode: _focusNodeEmail,
                    labelStr: '邮箱',
                    reg: RegExp(
                        r"^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$"),
                    errorStr: 'xxx@example.com',
                  ),
                  LoginTextField(
                    controller: _controllerPassword,
                    focusNode: _focusNodePassword,
                    labelStr: '密码',
                    hintStr: '6~16位数字和字母',
                    reg: RegExp(r"(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$"),
                    obscure: true,
                  ),
                  LoginTextField(
                    controller: _controllerPassword2,
                    focusNode: _focusNodePassword2,
                    labelStr: '确认密码',
                    hintStr: '重新输入确认密码',
                    reg: RegExp('^' + _controllerPassword.text + '\$'),
                    errorStr: '不一致',
                    obscure: true,
                  ),
                ],
              ),
              Column(
                children: [
                  LoginButton(() {
                    _unfocus();
                    Navigator.of(context).pushReplacementNamed('/home');
                    return;
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).pushReplacementNamed('/home');
                    }
                  }, '注册'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('已有账户 ？'),
                      LoginInButton(() {
                        _formKey.currentState!.reset();
                        _clearInput();
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

  void _clearInput() {
    _controllerPassword.clear();
    _controllerPassword2.clear();
    _controllerEmail.clear();
  }
}
