import 'package:flutter/material.dart';
import 'package:mybooks/pages/components/select_dialog.dart';
import 'package:mybooks/utils/global.dart';

const SortTypeName = {
  SortType.dateOrder: '时间正序',
  SortType.indateOrder: '时间倒序',
  SortType.letterOrder: '字母正序',
  SortType.inletterOrder: '字母倒序',
};

class SetOrder extends StatelessWidget {
  final SortType sortType;
  final void Function(SortType)? listener;
  SetOrder({required this.sortType, this.listener});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => SelectDialog(
            content: '排序方式',
            selected: SortTypeName,
            defaultIndex: sortType,
          ),
        ).then((value) {
          if (listener == null) return;
          listener!(value);
        });
      },
      child: Text(SortTypeName[sortType]!),
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        ),
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        minimumSize: MaterialStateProperty.all(Size.zero),
        foregroundColor: MaterialStateProperty.all(
          Theme.of(context).buttonColor.withOpacity(0.5),
        ),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
    );
  }
}
