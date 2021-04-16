import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:mybooks/models/user_provider.dart';

class AboutmeInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<MyUserModel>(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      color: Theme.of(context).primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AboutmeInfItem(title: '书籍数', hint: userProvider.books.toString()),
          AboutmeInfItem(title: '关注', hint: userProvider.following.toString()),
          AboutmeInfItem(title: '被关注', hint: userProvider.followers.toString()),
        ],
      ),
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
            Text(
              hint,
              style: GoogleFonts.jua(
                textStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: GoogleFonts.exo(
                textStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
