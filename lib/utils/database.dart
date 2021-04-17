import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class Book {
  final String isbn;
  final String? title;
  final String? author;
  final String? ph;
  final String? publishdate;
  final double? price;
  final Uint8List? cover;
  final String? content;
  final String? category;
  Book({
    required this.isbn,
    this.title,
    this.author,
    this.ph,
    this.publishdate,
    this.price,
    this.cover,
    this.content,
    this.category,
  });
  Map<String, dynamic> toMap() {
    return {
      'isbn': isbn,
      'title': title,
      'author': author,
      'ph': ph,
      'publishdate': publishdate,
      'cover': cover,
      'content': content,
      'category': category,
    };
  }
}

class UserBook {
  final String isbn;
  final String? touchdate;
  final int? read;
  final String? description;
  final String? tag;
  UserBook({
    required this.isbn,
    this.touchdate,
    this.read,
    this.description,
    this.tag,
  });
  Map<String, dynamic> toMap() {
    return {
      'isbn': isbn,
      'touchdate': touchdate,
      'read': read,
      'description': description,
      'tag': tag,
    };
  }
}

class DataBaseUtil {
  static late final Database db;
  static final String _databaseName = 'mybooks.db';
  static final String _booksTableName = 'books';
  static late final String _userTableName;

  /// 进入app初始化数据库和表
  static Future<bool> initDataBase(String? email) async {
    try {
      db = await openDatabase(
        join(await getDatabasesPath(), _databaseName),
        onCreate: (db, version) {
          // 书籍表: isbn(主) 题目 作者 出版社 出版日期 价格 封面 内容简介 类别
          db.execute(
            "CREATE TABLE $_booksTableName(isbn TEXT PRIMARY KEY UNIQUE, title TEXT, author TEXT, ph TEXT, publishdate TEXT, price REAL, cover BLOB, content TEXT, category TEXT)",
          );
        },
        version: 1,
      );
    } catch (_) {}
    try {
      if (email != null) {
        _userTableName =
            'user_' + md5.convert(Utf8Encoder().convert(email)).toString();
        // 用户存储书籍表: isbn(主) 最后一次操作日期 是否读过 描述 自定义类别
        await db.execute(
          "CREATE TABLE $_userTableName(isbn TEXT PRIMARY KEY UNIQUE, touchdate TEXT, read INTEGER, description TEXT, tag TEXT)",
        );
      }
    } catch (_) {}
    return true;
  }

  /// 删除用户表 注销用户需要  谨慎使用
  static Future<void> deleteUserTable() async {
    return await db.execute("DROP TABLE $_userTableName");
  }

  /// 用户添加书籍
  static Future<bool> addUserBook(UserBook userBook) async {
    int i = await db.insert(
      _userTableName,
      userBook.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    if (i == 0) return false;
    return true;
  }

  /// 查询用户是否有这本书
  static Future<bool> queryUserBook({required String isbn}) async {
    final List<Map<String, dynamic>> maps = await db.query(
      _userTableName,
      where: "isbn = ?",
      whereArgs: [isbn],
    );
    if (maps.isEmpty) return false;
    return true;
  }

  /// 删除用户的一个书籍
  static Future<bool> deleteUserBook({required String isbn}) async {
    int d = await db.delete(
      _userTableName,
      where: "isbn = ?",
      whereArgs: [isbn],
    );
    if (d == 0) return false;
    return true;
  }

  /// 获取用户所有书籍
  static Future<List<UserBook>> getUserBooks() async {
    final List<Map<String, dynamic>> maps = await db.query(_userTableName);
    List<UserBook> userBooks = List.generate(maps.length, (i) {
      return UserBook(
        isbn: maps[i]['isbn'],
        touchdate: maps[i]['touchdate'],
        read: maps[i]['read'],
        description: maps[i]['description'],
        tag: maps[i]['tag'],
      );
    });
    return userBooks;
  }

  /// 从缓存提取图书
  static Future<Book?> getBook({required String isbn}) async {
    final List<Map<String, dynamic>> maps = await db.query(
      _booksTableName,
      where: "isbn = ?",
      whereArgs: [isbn],
    );
    if (maps.isEmpty) return null;
    List<Book> books = List.generate(maps.length, (i) {
      return Book(
        isbn: maps[i]['isbn'],
        title: maps[i]['title'],
        author: maps[i]['author'],
        ph: maps[i]['ph'],
        publishdate: maps[i]['publishdate'],
        price: maps[i]['price'],
        cover: maps[i]['cover'],
        content: maps[i]['content'],
        category: maps[i]['category'],
      );
    });
    return books[0];
  }

  /// 向缓存添加图书
  static Future<void> insertBook(Book book) async {
    await db.insert(
      _booksTableName,
      book.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// 清除图书数据
  static Future<int> clearCache() async {
    return await db.delete(_booksTableName);
  }

  /// 获取数据库大小
  static Future<String> getCacheSize() async {
    File databaseFile = File(join(await getDatabasesPath(), _databaseName));
    if (databaseFile.existsSync()) {
      double len = databaseFile.lengthSync() / 1024 / 1024;
      return len.toStringAsFixed(2) + ' MB';
    }
    return '0 MB';
  }
}
