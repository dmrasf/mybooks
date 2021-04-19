import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mybooks/utils/database.dart';
import 'package:provider/provider.dart';
import 'package:mybooks/models/user_provider.dart';
import 'package:mybooks/pages/bookcase/components/bookcase_title_card.dart';
import 'package:mybooks/pages/bookcase/components/book_list_item.dart';
import 'package:mybooks/pages/bookcase/components/book_tag.dart';

class BooksShow extends StatefulWidget {
  final List<UserBook> books;
  BooksShow({Key? key, required this.books}) : super(key: key);
  @override
  _BooksShowState createState() => _BooksShowState();
}

class _BooksShowState extends State<BooksShow> {
  int _crossAxisCount = 0;
  final List<String> list = [
    "0",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
  ];
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<MyUserModel>(context);
    userProvider.books = widget.books.length;
    return Container(
      color: Theme.of(context).backgroundColor,
      alignment: Alignment.center,
      child: Column(
        children: [
          BookcaseTitleCard(),
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 10),
            height: 43,
            child: Row(
              children: [
                Icon(
                  Icons.tag,
                  size: 12,
                  color: Theme.of(context).buttonColor,
                ),
                SizedBox(width: 10),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: [
                      BookTag(
                        activeColor: Theme.of(context).errorColor,
                        name: '艺术',
                        listener: (isToggle) {
                          print(isToggle);
                        },
                      ),
                      SizedBox(width: 10),
                      BookTag(
                        activeColor: Theme.of(context).hintColor,
                        name: '小说',
                        listener: (isToggle) {
                          print(isToggle);
                        },
                      ),
                    ],
                  ),
                ),
                Spacer(),
                TextButton(
                  child: Text('TT'),
                  onPressed: () {
                    setState(() {
                      _crossAxisCount = (_crossAxisCount + 1) % 4;
                    });
                  },
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.17,
                    padding: EdgeInsets.only(right: 10),
                    alignment: Alignment.centerRight,
                    height: 40,
                    child: Icon(
                      Icons.search,
                      size: 10,
                      color: Theme.of(context).buttonColor,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: CustomScrollView(
              physics: BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: [
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _crossAxisCount + 2,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) => BookShowListItem(
                      isbn: widget.books[index].isbn,
                    ),
                    childCount: widget.books.length,
                  ),
                ),
              ],
            ),
            //child: CustomAnimateGridView(
            //delegate: SliverGridDelegateWithFixedCrossAxisCount(
            //crossAxisCount: 2,
            //childAspectRatio: 3 / 2,
            //crossAxisSpacing: 1,
            //mainAxisSpacing: 1,
            //),
            //itemCount: list.length,
            //itemBuilder: (context, index) {
            //return Container(
            //margin: EdgeInsets.all(10),
            //alignment: Alignment.center,
            //child: Text('$index'),
            //color: Colors.blue,
            //);
            //}),
            //child: Container(),
          ),
        ],
      ),
    );
  }
}

class CustomAnimateGridView extends StatefulWidget {
  final SliverGridDelegate delegate;
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final Axis scrollDirection;
  final ScrollPhysics physics;
  final bool reverse;
  final ScrollController? controller;
  final bool shrinkWrap;

  CustomAnimateGridView({
    Key? key,
    required this.delegate,
    required this.itemCount,
    required this.itemBuilder,
    this.physics = const BouncingScrollPhysics(
      parent: AlwaysScrollableScrollPhysics(),
    ),
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.shrinkWrap = false,
  }) : super(key: key);

  @override
  _CustomAnimateGridViewState createState() => _CustomAnimateGridViewState();
}

class _CustomAnimateGridViewState extends State<CustomAnimateGridView>
    with TickerProviderStateMixin {
  Size? _itemSize;
  late AnimationController _slideController;
  late AnimationController _scaleController;

  Map<int, Offset> _itemsOffset = {};
  Size? _itemOldSize;

  @override
  void initState() {
    _slideController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _scaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3000),
    );
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      print(context.size);
    });
    super.initState();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: widget.delegate,
      itemCount: widget.itemCount,
      scrollDirection: widget.scrollDirection,
      shrinkWrap: widget.shrinkWrap,
      physics: widget.physics,
      reverse: widget.reverse,
      itemBuilder: (context, index) {
        _slideController.reset();
        _slideController.forward();
        _scaleController.reset();
        _scaleController.forward();
        Animation<Offset>? slideAnimation =
            createTargetItemSlideAnimation(index);
        Animation<double>? scaleAnimation =
            createTargetItemScaleAnimation(index);
        return _GridItem(
          index: index,
          itemSizeCallback: itemSizeCallback,
          child: widget.itemBuilder(context, index),
          slideAnimation: slideAnimation,
          scaleAnimation: scaleAnimation,
        );
      },
    );
  }

  Animation<double>? createTargetItemScaleAnimation(int index) {
    if (_itemSize == null) return null;
    if (_itemOldSize == null) {
      _itemOldSize = _itemSize;
      return null;
    }
    Tween<double> tween =
        Tween(begin: 1.0, end: _itemSize!.width / _itemOldSize!.width);
    _itemOldSize = _itemSize;
    return tween.animate(
      CurvedAnimation(
        parent: _scaleController,
        curve: Curves.easeOut,
      ),
    );
  }

  Animation<Offset>? createTargetItemSlideAnimation(int index) {
    SliverGridDelegateWithFixedCrossAxisCount delegate =
        (widget.delegate as SliverGridDelegateWithFixedCrossAxisCount);
    if (_itemSize == null) return null;
    int horizionalSeparation = index % delegate.crossAxisCount;
    int verticalSeparation = index ~/ delegate.crossAxisCount;
    double dx = (delegate.crossAxisSpacing + _itemSize!.width) *
        horizionalSeparation /
        _itemSize!.width;
    double dy = (delegate.mainAxisSpacing + _itemSize!.height) *
        verticalSeparation /
        _itemSize!.width;
    Offset newOffset = Offset(dx, dy);
    if (!_itemsOffset.containsKey(index)) {
      _itemsOffset[index] = newOffset;
      return null;
    }
    if (_itemsOffset[index] == newOffset) return null;
    Tween<Offset> tween =
        Tween(begin: _itemsOffset[index]! - newOffset, end: Offset(0.0, 0.0));
    _itemsOffset[index] = newOffset;
    return tween.animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOut),
    );
  }

  void itemSizeCallback(Size? size) {
    _itemSize = size;
    print(size);
  }
}

class _GridItem extends StatefulWidget {
  final int index;
  final Widget child;
  final Animation<Offset>? slideAnimation;
  final Animation<double>? scaleAnimation;
  final void Function(Size?) itemSizeCallback;
  _GridItem({
    required this.index,
    required this.child,
    required this.itemSizeCallback,
    this.slideAnimation,
    this.scaleAnimation,
  });

  @override
  __GridItemState createState() => __GridItemState();
}

class __GridItemState extends State<_GridItem> {
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      widget.itemSizeCallback(context.size);
    });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant _GridItem oldWidget) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      widget.itemSizeCallback(context.size);
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.slideAnimation);
    if (widget.slideAnimation == null && widget.scaleAnimation == null)
      return widget.child;
    if (widget.scaleAnimation != null) {
      if (widget.slideAnimation != null) {
        return SlideTransition(
          position: widget.slideAnimation!,
          child: ScaleTransition(
            scale: widget.scaleAnimation!,
            child: widget.child,
          ),
        );
      }
      return ScaleTransition(
        scale: widget.scaleAnimation!,
        child: widget.child,
      );
    }
    return SlideTransition(
      position: widget.slideAnimation!,
      child: widget.child,
    );
  }
}
