import 'package:flutter/material.dart';
import 'package:mybooks/pages/login/components/login_button.dart';
import 'package:mybooks/pages/login/components/textfield.dart';
import 'package:mybooks/pages/components/icon_button.dart';
import 'package:mybooks/utils/http_client.dart';
import 'package:provider/provider.dart';
import 'package:mybooks/models/user.dart';
import 'package:mybooks/models/secret.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:mybooks/models/user_provider.dart';
import 'package:mybooks/utils/database.dart';
import 'package:mybooks/pages/components/check_connect.dart';
import 'package:mybooks/pages/components/toast.dart';

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
              Text(
                '登录',
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
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                        final String token = md5
                            .convert(Utf8Encoder().convert(password))
                            .toString();

                        var loginInfo =
                            await HttpClientUtil.login(email, token);
                        if (loginInfo == null) {
                          showToast(context, '服务器失效', type: ToastType.ERROR);
                          return true;
                        }
                        if (loginInfo.containsKey('detail')) {
                          if (loginInfo['detail'] == 'logup')
                            showToast(context, '请注册', type: ToastType.ERROR);
                          showToast(context, '密码错误', type: ToastType.ERROR);
                          return true;
                        }

                        DataBaseUtil.initUserTable(email).then((value) {
                          Navigator.of(context).pop();
                          userProvider.secret = Secret(
                            books: int.parse(
                                loginInfo['books_secret']!.toString()),
                            email: int.parse(
                                loginInfo['email_secret']!.toString()),
                            following: int.parse(
                                loginInfo['following_secret']!.toString()),
                            followers: int.parse(
                                loginInfo['followers_secret']!.toString()),
                            location: int.parse(
                                loginInfo['location_secret']!.toString()),
                            birthday: int.parse(
                                loginInfo['birthday_secret']!.toString()),
                            gender: int.parse(
                                loginInfo['gender_secret']!.toString()),
                          );
                          userProvider.user = User(
                            email: email,
                            token: token,
                            avatarUrl: loginInfo['avatar_url'],
                            name: loginInfo['nick_name'],
                            description: loginInfo['description'],
                            location: loginInfo['location'],
                            birthday: loginInfo['birthday'],
                            gender: loginInfo['gender'],
                          );
                          userProvider.isLogin = true;
                        });
                      }
                      return true;
                    },
                    initWidget: Text('登录'),
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
  }

  void _clearText() {
    _controllerEmail.clear();
    _controllerPassword.clear();
  }
}
