import 'package:flutter/material.dart';
import 'package:mybooks/pages/login/components/login_button.dart';
import 'package:mybooks/pages/login/components/textfield.dart';
import 'package:mybooks/pages/components/icon_button.dart';
import 'package:provider/provider.dart';
import 'package:mybooks/models/user_provider.dart';
import 'package:mybooks/utils/database.dart';
import 'package:mybooks/pages/components/toast.dart';
import 'package:mybooks/pages/components/check_connect.dart';

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
                        final String passed = _controllerPassword.text;
                        _clearText();
                        _formKey.currentState!.reset();

                        //
                        // 服务器 .then
                        await Future.delayed(Duration(milliseconds: 200));
                        //
                        userProvider.isLogin = true;

                        if (!successed) return true;

                        successed = await createTable(email);
                        if (successed)
                          Navigator.of(context).pushReplacementNamed('/home');
                        else
                          showToast(context, '创建数据库表错误', type: ToastType.ERROR);
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
