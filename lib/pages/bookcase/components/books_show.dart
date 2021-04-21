import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mybooks/utils/database.dart';
import 'package:mybooks/utils/global.dart';
import 'package:provider/provider.dart';
import 'package:mybooks/models/user_provider.dart';
import 'package:mybooks/pages/bookcase/components/bookcase_title_card.dart';
import 'package:mybooks/pages/bookcase/components/show_books_grid.dart';
import 'package:mybooks/pages/bookcase/components/show_books_controll_bar.dart';

class BooksShow extends StatefulWidget {
  final Map<String, UserBook> books;
  final Map<String, Set<String>> allTags;
  BooksShow({Key? key, required this.books, required this.allTags})
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
    List<String> showBooks = _getShowBooksFromTags(
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
          BooksShowControllerBar(
            sortCallBack: () => _isSort = !_isSort,
            listener: () => setState(() {}),
          ),
          ShowBooksGrid(key: ValueKey(_isSort), showBooks: showBooks),
        ],
      ),
    );
  }

  List<String> _getShowBooksFromTags(
    Map<String, bool> tags,
    SortType sortType,
    bool isTagsUnion,
  ) {
    List<String> showBooks = [];
    if (tags.isEmpty)
      showBooks = widget.books.keys.toList();
    else
      widget.books.values.forEach((userBook) {
        if (userBook.tags == null) {
          if (!tags.containsValue(true)) showBooks.add(userBook.isbn);
          return;
        }
        Set<String> sameTags = tags.keys.toSet().intersection(
              jsonDecode(userBook.tags!).toSet(),
            );
        if (sameTags.isEmpty) {
          if (!tags.containsValue(true)) showBooks.add(userBook.isbn);
        } else {
          if (sameTags.map((e) => tags[e]!).toSet().contains(true))
            showBooks.add(userBook.isbn);
        }
      });
    if (sortType == SortType.indateOrder)
      showBooks = showBooks.reversed.toList();
    showBooks.sort((a, b) {
      switch (sortType) {
        case SortType.dateOrder:
          return widget.books[a]!.touchdate
              .compareTo(widget.books[b]!.touchdate);
        case SortType.indateOrder:
          return widget.books[b]!.touchdate
              .compareTo(widget.books[a]!.touchdate);
        default:
          return 0;
      }
    });
    return showBooks;
  }
}

//class CustomAnimateGridView extends StatefulWidget {
//final SliverGridDelegate delegate;
//final IndexedWidgetBuilder itemBuilder;
//final int itemCount;
//final Axis scrollDirection;
//final ScrollPhysics physics;
//final bool reverse;
//final ScrollController? controller;
//final bool shrinkWrap;

//CustomAnimateGridView({
//Key? key,
//required this.delegate,
//required this.itemCount,
//required this.itemBuilder,
//this.physics = const BouncingScrollPhysics(
//parent: AlwaysScrollableScrollPhysics(),
//),
//this.scrollDirection = Axis.vertical,
//this.reverse = false,
//this.controller,
//this.shrinkWrap = false,
//}) : super(key: key);

//@override
//_CustomAnimateGridViewState createState() => _CustomAnimateGridViewState();
//}

//class _CustomAnimateGridViewState extends State<CustomAnimateGridView>
//with TickerProviderStateMixin {
//Size? _itemSize;
//late AnimationController _slideController;
//late AnimationController _scaleController;

//Map<int, Offset> _itemsOffset = {};
//Size? _itemOldSize;

//@override
//void initState() {
//_slideController = AnimationController(
//vsync: this,
//duration: Duration(milliseconds: 300),
//);
//_scaleController = AnimationController(
//vsync: this,
//duration: Duration(milliseconds: 3000),
//);
//WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
//print(context.size);
//});
//super.initState();
//}

//@override
//void dispose() {
//_slideController.dispose();
//_scaleController.dispose();
//super.dispose();
//}

//@override
//Widget build(BuildContext context) {
//return GridView.builder(
//gridDelegate: widget.delegate,
//itemCount: widget.itemCount,
//scrollDirection: widget.scrollDirection,
//shrinkWrap: widget.shrinkWrap,
//physics: widget.physics,
//reverse: widget.reverse,
//itemBuilder: (context, index) {
//_slideController.reset();
//_slideController.forward();
//_scaleController.reset();
//_scaleController.forward();
//Animation<Offset>? slideAnimation =
//createTargetItemSlideAnimation(index);
//Animation<double>? scaleAnimation =
//createTargetItemScaleAnimation(index);
//return _GridItem(
//index: index,
//itemSizeCallback: itemSizeCallback,
//child: widget.itemBuilder(context, index),
//slideAnimation: slideAnimation,
//scaleAnimation: scaleAnimation,
//);
//},
//);
//}

//Animation<double>? createTargetItemScaleAnimation(int index) {
//if (_itemSize == null) return null;
//if (_itemOldSize == null) {
//_itemOldSize = _itemSize;
//return null;
//}
//Tween<double> tween =
//Tween(begin: 1.0, end: _itemSize!.width / _itemOldSize!.width);
//_itemOldSize = _itemSize;
//return tween.animate(
//CurvedAnimation(
//parent: _scaleController,
//curve: Curves.easeOut,
//),
//);
//}

//Animation<Offset>? createTargetItemSlideAnimation(int index) {
//SliverGridDelegateWithFixedCrossAxisCount delegate =
//(widget.delegate as SliverGridDelegateWithFixedCrossAxisCount);
//if (_itemSize == null) return null;
//int horizionalSeparation = index % delegate.crossAxisCount;
//int verticalSeparation = index ~/ delegate.crossAxisCount;
//double dx = (delegate.crossAxisSpacing + _itemSize!.width) *
//horizionalSeparation /
//_itemSize!.width;
//double dy = (delegate.mainAxisSpacing + _itemSize!.height) *
//verticalSeparation /
//_itemSize!.width;
//Offset newOffset = Offset(dx, dy);
//if (!_itemsOffset.containsKey(index)) {
//_itemsOffset[index] = newOffset;
//return null;
//}
//if (_itemsOffset[index] == newOffset) return null;
//Tween<Offset> tween =
//Tween(begin: _itemsOffset[index]! - newOffset, end: Offset(0.0, 0.0));
//_itemsOffset[index] = newOffset;
//return tween.animate(
//CurvedAnimation(parent: _slideController, curve: Curves.easeOut),
//);
//}

//void itemSizeCallback(Size? size) {
//_itemSize = size;
//print(size);
//}
//}

//class _GridItem extends StatefulWidget {
//final int index;
//final Widget child;
//final Animation<Offset>? slideAnimation;
//final Animation<double>? scaleAnimation;
//final void Function(Size?) itemSizeCallback;
//_GridItem({
//required this.index,
//required this.child,
//required this.itemSizeCallback,
//this.slideAnimation,
//this.scaleAnimation,
//});

//@override
//__GridItemState createState() => __GridItemState();
//}

//class __GridItemState extends State<_GridItem> {
//@override
//void initState() {
//WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
//widget.itemSizeCallback(context.size);
//});
//super.initState();
//}

//@override
//void didUpdateWidget(covariant _GridItem oldWidget) {
//WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
//widget.itemSizeCallback(context.size);
//});
//super.didUpdateWidget(oldWidget);
//}

//@override
//Widget build(BuildContext context) {
//print(widget.slideAnimation);
//if (widget.slideAnimation == null && widget.scaleAnimation == null)
//return widget.child;
//if (widget.scaleAnimation != null) {
//if (widget.slideAnimation != null) {
//return SlideTransition(
//position: widget.slideAnimation!,
//child: ScaleTransition(
//scale: widget.scaleAnimation!,
//child: widget.child,
//),
//);
//}
//return ScaleTransition(
//scale: widget.scaleAnimation!,
//child: widget.child,
//);
//}
//return SlideTransition(
//position: widget.slideAnimation!,
//child: widget.child,
//);
//}
//}
