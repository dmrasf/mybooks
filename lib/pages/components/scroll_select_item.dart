import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScrollSelectItems extends StatefulWidget {
  final List<dynamic> items;
  final void Function(dynamic)? listener;
  final String? title;
  ScrollSelectItems({
    Key? key,
    required this.items,
    this.listener,
    this.title,
  }) : super(key: key);
  @override
  _ScrollSelectItemsState createState() => _ScrollSelectItemsState();
}

class _ScrollSelectItemsState extends State<ScrollSelectItems> {
  int _currentIndex = 0;
  ScrollController _controller = ScrollController();
  final _itemHeigth = 40.0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_listenr);
  }

  @override
  void dispose() {
    _controller.removeListener(_listenr);
    _controller.dispose();
    super.dispose();
  }

  void _listenr() {
    setState(() {
      _currentIndex =
          (_controller.offset / _itemHeigth).round() % widget.items.length;
    });
    if (widget.listener != null) widget.listener!(_currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.title == null
            ? SizedBox()
            : Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  widget.title!,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.none,
                    color: Theme.of(context).buttonColor.withOpacity(0.7),
                  ),
                ),
              ),
        Container(
          width: 50,
          height: _itemHeigth * 3,
          child: NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification is ScrollEndNotification) if (_controller
                  .hasClients)
                Future.delayed(
                  Duration(milliseconds: 0),
                  () => _controller.animateTo(
                    _currentIndex * _itemHeigth,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                );
              return false;
            },
            child: CustomScrollView(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              controller: _controller,
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [Container(height: _itemHeigth)] +
                        List.generate(
                          widget.items.length,
                          (index) => Container(
                            alignment: Alignment.center,
                            height: _itemHeigth,
                            padding: EdgeInsets.symmetric(vertical: 6),
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                widget.items[index].toString(),
                                maxLines: 1,
                                style: GoogleFonts.jua(
                                  textStyle: TextStyle(
                                    fontSize: _currentIndex == index ? 17 : 13,
                                    fontWeight: FontWeight.w700,
                                    decoration: TextDecoration.none,
                                    color: _currentIndex == index
                                        ? Theme.of(context).hintColor
                                        : Theme.of(context)
                                            .buttonColor
                                            .withOpacity(0.6),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ) +
                        [Container(height: _itemHeigth)],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
