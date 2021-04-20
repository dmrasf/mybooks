import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mybooks/pages/bookcase/components/newtag_page.dart';
import 'package:mybooks/utils/change_page.dart';

class TagsChoosePage extends StatefulWidget {
  final Map<String, bool> userTags;
  final Set<String>? notDeleteTags;
  TagsChoosePage({required this.userTags, this.notDeleteTags});
  @override
  _TagsChoosePageState createState() => _TagsChoosePageState();
}

class _TagsChoosePageState extends State<TagsChoosePage> {
  Map<String, bool> _newTags = {};

  @override
  void initState() {
    _newTags.addAll(widget.userTags);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 50, right: 20),
      color: Theme.of(context).backgroundColor,
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Hero(
                tag: '#',
                child: Text(
                  '# 标签 #',
                  style: GoogleFonts.jua(
                    textStyle: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 50,
                      color: Theme.of(context).buttonColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(_newTags),
                child: Text('ok'),
                style: ButtonStyle(
                  textStyle: MaterialStateProperty.all(
                    GoogleFonts.jua(
                      textStyle: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 40,
                        color: Theme.of(context).buttonColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  foregroundColor: MaterialStateProperty.all(
                    Theme.of(context).buttonColor,
                  ),
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: List<Widget>.generate(
                    _newTags.length,
                    (i) {
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          color: Colors.blue,
                          child: Text(_newTags.keys.toList()[i]),
                        ),
                      );
                    },
                  ) +
                  [
                    GestureDetector(
                      onTap: () {
                        ChangePage.slideChangePage(context, NewTagPage())
                            .then((value) {
                          if (value == null) return;
                          if (value == '') return;
                          setState(() {
                            _newTags[value] = false;
                          });
                        });
                      },
                      child: Container(
                        height: 100,
                        color: Colors.red,
                        alignment: Alignment.center,
                        child: Icon(Icons.add),
                      ),
                    ),
                  ],
            ),
          ),
        ],
      ),
    );
  }
}
