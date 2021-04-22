import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:mybooks/models/userbooks_provider.dart';
import 'package:mybooks/pages/bookcase/components/add_tag_quit_text.dart';
import 'package:mybooks/pages/bookcase/components/add_tags_tag.dart';
import 'package:mybooks/pages/bookcase/components/add_tag_textfield.dart';
import 'package:mybooks/pages/components/confirm_dialog.dart';
import 'dart:convert';

class TagsChoosePage extends StatefulWidget {
  final Map<String, bool> userTags;
  final bool isTagsUnion;
  TagsChoosePage({
    required this.userTags,
    required this.isTagsUnion,
  });
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
    Set<String> existTags = Set();
    context.read<MyUserBooksModel>().userBooksTag.values.forEach((tags) {
      existTags.addAll(tags);
    });
    return WillPopScope(
      child: Scaffold(
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
                    onPressed: () => Navigator.of(context).pop([
                      _newTags,
                      widget.isTagsUnion,
                    ]),
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
                    onPressed: () => Navigator.of(context).pop(),
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
                              isToggle:
                                  _newTags[_newTags.keys.toList()[index]]!,
                              listener: (isToggle) =>
                                  _newTags[_newTags.keys.toList()[index]] =
                                      isToggle,
                              clear: existTags
                                      .contains(_newTags.keys.toList()[index])
                                  ? null
                                  : () {
                                      setState(() {
                                        _newTags.remove(
                                            _newTags.keys.toList()[index]);
                                      });
                                    },
                            ),
                          ),
                        ),
                      ]),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              AddTagTextfield(
                listener: (newTag) {
                  if (!_newTags.containsKey(newTag))
                    setState(() {
                      _newTags[newTag] = false;
                    });
                },
              )
            ],
          ),
        ),
      ),
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (context) => ConfirmDialog(content: '请点ok/no退出'),
        );
        return false;
      },
    );
  }
}
