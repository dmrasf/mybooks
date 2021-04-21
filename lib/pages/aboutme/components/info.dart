import 'package:flutter/material.dart';
import 'package:mybooks/models/userbooks_provider.dart';
import 'package:provider/provider.dart';
import 'package:mybooks/models/user_provider.dart';

class AboutmeInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<MyUserBooksModel, MyUserModel>(
      builder: (context, myUserBooksModel, myUserModel, child) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          color: Theme.of(context).primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AboutmeInfItem(
                  title: '书籍数',
                  hint: myUserBooksModel.userBooks.length.toString()),
              AboutmeInfItem(
                title: '关注',
                hint: myUserModel.following.toString(),
              ),
              AboutmeInfItem(
                title: '被关注',
                hint: myUserModel.followers.toString(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class AboutmeInfItem extends StatelessWidget {
  final String title;
  final String hint;
  final GestureTapCallback? onPressed;
  AboutmeInfItem({
    Key? key,
    required this.title,
    required this.hint,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(hint, style: Theme.of(context).textTheme.headline1),
            SizedBox(height: 10),
            Text(title, style: Theme.of(context).textTheme.headline1),
          ],
        ),
      ),
    );
  }
}
