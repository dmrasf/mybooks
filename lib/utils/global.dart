import 'package:flutter/material.dart';
import 'package:mybooks/pages/record/record_page.dart';
import 'package:mybooks/pages/bookcase/bookcase_page.dart';

final GlobalKey<RecordPageState> recordPageGlobalKey = GlobalKey();
final GlobalKey<BookcasePageState> bookcasePageGlobalKey = GlobalKey();

enum SortType { letterOrder, inletterOrder, dateOrder, indateOrder }
