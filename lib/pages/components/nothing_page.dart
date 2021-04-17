import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NothingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Spacer(),
          Text(
            '你一本书都没有',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).buttonColor.withOpacity(0.6),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.2),
          SvgPicture.asset(
            'assets/images/nothing.svg',
            color: Theme.of(context).buttonColor.withOpacity(0.6),
            width: MediaQuery.of(context).size.width * 0.4,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.25)
        ],
      ),
    );
  }
}
