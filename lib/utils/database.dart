import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class Book {
  final String isbn;
  final String? isbn10;
  final String? title;
  final String? subtitle;
  final String? author;
  final String? ph;
  final String? publishdate;
  final double? price;
  final Uint8List? cover;
  final String? content;
  final String? category;
  final int? pages;
  final double? rate;
  final String? binding;
  Book({
    required this.isbn,
    this.isbn10,
    this.title,
    this.subtitle,
    this.author,
    this.ph,
    this.publishdate,
    this.price,
    this.cover,
    this.content,
    this.category,
    this.pages,
    this.rate,
    this.binding,
  });
  Map<String, dynamic> toMap() {
    return {
      'isbn': isbn,
      'isbn10': isbn10,
      'title': title,
      'subtitle': subtitle,
      'author': author,
      'ph': ph,
      'publishdate': publishdate,
      'price': price,
      'cover': cover,
      'content': content,
      'category': category,
      'pages': pages,
      'rate': rate,
      'binding': binding,
    };
  }
}

class UserBook {
  final String isbn;
  final String touchdate;
  final int? read;
  final String? description;
  final String? tags;
  final double? rate;
  UserBook({
    required this.isbn,
    required this.touchdate,
    this.read,
    this.description,
    this.tags,
    this.rate,
  });
  Map<String, dynamic> toMap() {
    return {
      'isbn': isbn,
      'touchdate': touchdate,
      'read': read,
      'description': description,
      'tags': tags,
      'rate': rate,
    };
  }
}

class DataBaseUtil {
  static late final Database db;
  static final String _databaseName = 'mybooks.db';
  static final String _booksTableName = 'books';
  static late final String _userTableName;

  /// 进入app初始化数据库和表
  static Future<void> initDataBase() async {
    try {
      db = await openDatabase(
        join(await getDatabasesPath(), _databaseName),
        onCreate: (db, version) {
          // 书籍表: isbn(主) isbn10 题目 副标题 作者 出版社 出版日期 价格 封面 内容简介 类别 页数 评价 装订方式
          db.execute(
            "CREATE TABLE $_booksTableName(isbn TEXT PRIMARY KEY UNIQUE, isbn10 TEXT, title TEXT, subtitle TEXT, author TEXT, ph TEXT, publishdate TEXT, price REAL, cover BLOB, content TEXT, category TEXT, pages INTEGER, rate REAL, binding TEXT)",
          );
        },
        version: 1,
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<void> initUserTable(String? email) async {
    if (email != null) {
      try {
        _userTableName =
            'user_' + md5.convert(Utf8Encoder().convert(email)).toString();
        // 用户存储书籍表: isbn(主) 最后一次操作日期 是否读过 描述 自定义类别 自己的评价
        await db.execute(
          "CREATE TABLE $_userTableName(isbn TEXT PRIMARY KEY UNIQUE, touchdate TEXT NOT NULL, read INTEGER, description TEXT, tags TEXT, rate TEXT)",
        );
      } catch (e) {
        print(e);
      }
    }
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
        tags: maps[i]['tags'],
        rate: maps[i]['rate'],
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
        isbn10: maps[i]['isbn10'],
        title: maps[i]['title'],
        subtitle: maps[i]['subtitle'],
        author: maps[i]['author'],
        ph: maps[i]['ph'],
        publishdate: maps[i]['publishdate'],
        price: maps[i]['price'],
        cover: maps[i]['cover'],
        content: maps[i]['content'],
        category: maps[i]['category'],
        pages: maps[i]['pages'],
        rate: maps[i]['rate'],
        binding: maps[i]['binding'],
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
