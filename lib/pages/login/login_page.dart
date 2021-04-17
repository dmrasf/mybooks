import 'package:flutter/material.dart';
import 'package:mybooks/pages/login/components/login_button.dart';
import 'package:mybooks/pages/login/components/login_text_button.dart';
import 'package:mybooks/pages/login/components/textfield.dart';
import 'package:mybooks/pages/login/components/login.dart';
import 'package:mybooks/utils/change_page.dart';
import 'package:provider/provider.dart';
import 'package:mybooks/models/user_provider.dart';
import 'package:mybooks/models/user.dart';
import 'package:mybooks/models/secret.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:mybooks/utils/database.dart';
import 'package:mybooks/pages/components/toast.dart';
import 'package:mybooks/pages/components/check_connect.dart';

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
                    hintStr: '邮箱',
                    reg: RegExp(
                        r"^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$"),
                    errorStr: 'xxx@example.com',
                  ),
                  LoginTextField(
                    controller: _controllerPassword,
                    focusNode: _focusNodePassword,
                    prefixIcon: Icons.visibility,
                    hintStr: '密码',
                    reg: RegExp(r"(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$"),
                    obscure: true,
                  ),
                  LoginTextField(
                    controller: _controllerPassword2,
                    focusNode: _focusNodePassword2,
                    prefixIcon: Icons.visibility,
                    hintStr: '重新输入确认密码',
                    controller2: _controllerPassword,
                    errorStr: '不一致',
                    obscure: true,
                  ),
                ],
              ),
              Column(
                children: [
                  LoginActionButton(
                    action: () async {
                      _unfocus();
                      bool successed = true;
                      successed = await checkConnect(context);
                      if (!successed) return true;
                      if (_formKey.currentState!.validate()) {
                        final String email = _controllerEmail.text;
                        final String password = _controllerPassword.text;
                        final String password2 = _controllerPassword2.text;
                        _clearText();
                        _formKey.currentState!.reset();

                        //
                        // 服务器 .then
                        await Future.delayed(Duration(milliseconds: 300));
                        //
                        userProvider.isLogin = true;
                        userProvider.secret = Secret();
                        userProvider.user = User(
                          email: email,
                          token: md5
                              .convert(Utf8Encoder().convert(password))
                              .toString(),
                        );

                        if (!successed) return true;

                        successed = await DataBaseUtil.initDataBase(email);
                        if (successed)
                          Navigator.of(context).pushReplacementNamed('/home');
                        else
                          showToast(context, '创建数据库表错误', type: ToastType.ERROR);
                      }
                      return true;
                    },
                    initWidget: Text('注册'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('已有账户 ？'),
                      LoginTextButton(() {
                        _unfocus();
                        _clearText();
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

  void _clearText() {
    _controllerEmail.clear();
    _controllerPassword.clear();
    _controllerPassword2.clear();
  }
}
