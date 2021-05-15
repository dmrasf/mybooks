import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mybooks/pages/bookcase/components/add_tags_tag.dart';
import 'package:mybooks/pages/bookcase/components/choose_tags.dart';
import 'package:mybooks/utils/database.dart';
import 'package:mybooks/pages/aboutme/components/appBar_setting.dart';
import 'package:provider/provider.dart';
import 'package:mybooks/models/userbooks_provider.dart';

class BookShow extends StatefulWidget {
  final Book book;
  final String isbn;
  final VoidCallback? update;
  BookShow({Key? key, required this.isbn, required this.book, this.update})
      : super(key: key);
  @override
  _BookShowState createState() => _BookShowState();
}

class _BookShowState extends State<BookShow> {
  @override
  Widget build(BuildContext context) {
    Set<String>? tags =
        context.read<MyUserBooksModel>().userBooksTag[widget.isbn];
    return Scaffold(
      appBar: appBarForSettingPage(context, title: widget.book.title),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 5),
        child: Column(
          children: [
            Container(
              constraints: BoxConstraints(maxHeight: 260),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Hero(
                    tag: widget.isbn,
                    child: AspectRatio(
                      aspectRatio: 2 / 3,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          image: widget.book.cover == null
                              ? null
                              : DecorationImage(
                                  image: MemoryImage(widget.book.cover!),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment(-0.7, -0.8),
                          child: RichText(
                            text: TextSpan(
                              text: widget.book.title!,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: '  ',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                                TextSpan(
                                  text: widget.book.author!,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: CustomScrollView(
                physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Text(
                        '简介',
                        style: GoogleFonts.jua(
                          textStyle: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w100,
                            color:
                                Theme.of(context).buttonColor.withOpacity(0.7),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      widget.book.content == null
                          ? Container()
                          : Text(
                              widget.book.content!.trim(),
                              style: GoogleFonts.jua(
                                textStyle: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w100,
                                  color: Theme.of(context)
                                      .buttonColor
                                      .withOpacity(0.7),
                                ),
                              ),
                            ),
                    ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
