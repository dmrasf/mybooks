import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mybooks/utils/change_page.dart';
import 'package:mybooks/utils/database.dart';
import 'package:mybooks/utils/global.dart';
import 'package:provider/provider.dart';
import 'package:mybooks/models/user_provider.dart';
import 'package:mybooks/pages/bookcase/components/bookcase_title_card.dart';
import 'package:mybooks/pages/bookcase/components/book_list_item.dart';
import 'package:mybooks/pages/bookcase/components/book_tag.dart';
import 'package:mybooks/pages/bookcase/components/book_search.dart';
import 'package:mybooks/pages/bookcase/components/change_crossAxisCount.dart';
import 'package:mybooks/pages/bookcase/components/add_tags_page.dart';
import 'package:mybooks/pages/bookcase/components/choose_tags.dart';
import 'package:mybooks/pages/bookcase/components/set_order.dart';

class BooksShow extends StatefulWidget {
  final List<UserBook> books;
  final Set<String> existTags;
  BooksShow({Key? key, required this.books, required this.existTags})
      : super(key: key);
  @override
  _BooksShowState createState() => _BooksShowState();
}

class _BooksShowState extends State<BooksShow> {
  bool _isSort = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<MyUserModel>(context);
    List<UserBook> showBooks = _getShowBooksFromTags(
      userProvider.tags,
      userProvider.sortType,
      userProvider.isTagsUnion,
    );
    return Container(
      color: Theme.of(context).backgroundColor,
      alignment: Alignment.center,
      child: Column(
        children: [
          BookcaseTitleCard(booksNum: showBooks.length),
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
            height: 40,
            child: Row(
              children: [
                AddTags(
                  onTap: () => ChangePage.fadeChangePage(
                      context,
                      TagsChoosePage(
                        userTags: userProvider.tags,
                        notDeleteTags: widget.existTags,
                        isTagsUnion: userProvider.isTagsUnion,
                      )).then((value) {
                    if (value == null) return;
                    setState(() {
                      userProvider.tags = value[0];
                      userProvider.isTagsUnion = value[1];
                    });
                  }),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    shrinkWrap: true,
                    children: List.generate(
                      userProvider.tags.length,
                      (i) => BookTag(
                        key: UniqueKey(),
                        activeColor: Theme.of(context).hintColor,
                        name: userProvider.tags.keys.toList()[i],
                        isToggle: userProvider
                            .tags[userProvider.tags.keys.toList()[i]],
                        listener: (isToggle) {
                          if (userProvider
                                  .tags[userProvider.tags.keys.toList()[i]] ==
                              isToggle) return;
                          userProvider.tag = MapEntry(
                              userProvider.tags.keys.toList()[i], isToggle);
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ),
                Spacer(),
                SetOrder(
                  sortType: userProvider.sortType,
                  listener: (sortType) {
                    if (userProvider.sortType == sortType) return;
                    _isSort = !_isSort;
                    setState(() => userProvider.sortType = sortType);
                  },
                ),
                ChangeCrossAxisCount(
                  crossAxisCount: userProvider.crossAxisCount,
                  onPressed: () {
                    setState(() {
                      userProvider.crossAxisCount =
                          (userProvider.crossAxisCount - 1) % 3 + 2;
                    });
                  },
                ),
                BookSearch(width: MediaQuery.of(context).size.width * 0.17),
              ],
            ),
          ),
          Expanded(
            child: CustomScrollView(
              key: ValueKey(_isSort),
              physics: BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: [
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: userProvider.crossAxisCount,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) => BookShowListItem(
                      isbn: showBooks[index].isbn,
                      crossAxisCount: userProvider.crossAxisCount,
                    ),
                    childCount: showBooks.length,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<UserBook> _getShowBooksFromTags(
    Map<String, bool> tags,
    SortType sortType,
    bool isTagsUnion,
  ) {
    List<UserBook> showBooks = [];
    if (tags.isEmpty)
      showBooks = widget.books;
    else
      widget.books.forEach((userBook) {
        if (userBook.tags == null) {
          if (!tags.containsValue(true)) showBooks.add(userBook);
          return;
        }
        Set<String> sameTags = tags.keys.toSet().intersection(
              jsonDecode(userBook.tags!).toSet(),
            );
        if (sameTags.isEmpty) {
          if (!tags.containsValue(true)) showBooks.add(userBook);
        } else {
          if (sameTags.map((e) => tags[e]!).toSet().contains(true))
            showBooks.add(userBook);
        }
      });
    if (sortType == SortType.indateOrder)
      showBooks = showBooks.reversed.toList();
    showBooks.sort((a, b) {
      switch (sortType) {
        case SortType.dateOrder:
          return a.touchdate.compareTo(b.touchdate);
        case SortType.indateOrder:
          return b.touchdate.compareTo(a.touchdate);
        default:
          return 0;
      }
    });
    return showBooks;
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
