import 'package:flutter/material.dart';
import 'package:mybooks/pages/components/icon_button.dart';

AppBar appBarForSettingPage(BuildContext context, {String? title}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    shadowColor: Colors.transparent,
    leading: MyIconButton(
      onPressed: () => Navigator.of(context).maybePop(),
      icon: Icon(Icons.arrow_back),
    ),
    title: Text(
      title == null ? '' : title,
      style: Theme.of(context).textTheme.headline1,
    ),
    centerTitle: true,
  );
}
