import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<bool> createTable(String email) async {
  await Future.delayed(Duration(seconds: 2));
  return true;
}
