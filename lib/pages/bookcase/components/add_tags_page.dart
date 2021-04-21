import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mybooks/pages/aboutme/components/setting_textfield.dart';
import 'package:mybooks/pages/bookcase/components/add_tag_quit_text.dart';
import 'package:mybooks/pages/bookcase/components/add_tags_tag.dart';
import 'package:mybooks/pages/components/confirm_dialog.dart';
import 'package:mybooks/pages/components/icon_button.dart';

class TagsChoosePage extends StatefulWidget {
  final Map<String, bool> userTags;
  final Set<String>? notDeleteTags;
  TagsChoosePage({required this.userTags, this.notDeleteTags});
  @override
  _TagsChoosePageState createState() => _TagsChoosePageState();
}

class _TagsChoosePageState extends State<TagsChoosePage> {
  Map<String, bool> _newTags = {};

  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _newTags.addAll(widget.userTags);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 10, top: 50, right: 10, bottom: 20),
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
                SizedBox(width: 30),
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
                Spacer(),
                AddTagQuitTextButton(
                  text: 'ok',
                  onPressed: () => Navigator.of(context).pop(_newTags),
                ),
                Text(
                  '/',
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 60,
                    color: Theme.of(context).buttonColor,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                AddTagQuitTextButton(
                  text: 'no',
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => ConfirmDialog(content: '确认退出'),
                  ).then((value) {
                    if (value != null) if (value == true)
                      Navigator.of(context).pop();
                  }),
                ),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(height: 40),
            Expanded(
              child: CustomScrollView(
                physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Wrap(
                        spacing: 10,
                        runSpacing: 12,
                        alignment: WrapAlignment.center,
                        children: List.generate(
                          _newTags.length,
                          (index) => AddTagsTag(
                            tagName: _newTags.keys.toList()[index],
                          ),
                        ),
                      ),
                    ]),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              height: 60,
              padding: EdgeInsets.only(left: 20, right: 20),
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '新标签 ：',
                    style: GoogleFonts.jua(
                      textStyle: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 15,
                        color: Theme.of(context).buttonColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: AboutmeSettingTextField(
                      controller: _controller,
                      focusNode: _focusNode,
                    ),
                  ),
                  SizedBox(width: 30),
                  MyIconButton(
                    onPressed: () {
                      String newText = _controller.text;
                      _controller.clear();
                      _focusNode.unfocus();
                      if (newText == '') return;
                      if (_newTags.containsKey(newText)) return;
                      setState(() {
                        _newTags[newText] = false;
                      });
                    },
                    icon: Icon(
                      Icons.check,
                      color: Theme.of(context).buttonColor,
                      size: 30,
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(9)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
