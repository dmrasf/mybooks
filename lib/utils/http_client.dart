import 'dart:typed_data';
import 'package:mybooks/utils/database.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';

class HttpClientUtil {
  static final String _key = '300568b3d56094309b477ffbf70db29d';
  static final String _directQueryUrl =
      'http://feedback.api.juhe.cn/ISBN?key=$_key&sub=';
  static final String _directQueryUrl2 = 'https://api.zuk.pw/situ/book/isbn/';
  static final _httpClient = HttpClient();

  static Future<Book?> getBookFromServer(final String isbn) async {
    String requestUrl = _directQueryUrl + isbn;
    try {
      HttpClientRequest request =
          await _httpClient.getUrl(Uri.parse(requestUrl));
      HttpClientResponse response = await request.close();
      var book;
      Uint8List? cover;
      if (response.statusCode == 200) {
        String result = await response.transform(utf8.decoder).join();
        book = json.decode(result);
        if (book['error_code'] != 0) return null;
        String? bookImgUrl = book['result']['images_large'];
        if (bookImgUrl == null) return null;
        cover = await _getImageFromServer(bookImgUrl);
        Book newBook = Book(
          isbn: book['result']['isbn13'].toString(),
          isbn10: book['result']['isbn10']?.toString(),
          title: book['result']['title']?.toString(),
          subtitle: book['result']['subtitle']?.toString(),
          author: book['result']['author']?.toString(),
          ph: book['result']['publisher']?.toString(),
          publishdate: book['result']['pubdate']?.toString(),
          cover: cover,
          price: book['result']['price']?.toString(),
          content: book['result']['summary']?.toString(),
          category: null,
          pages: book['result']['pages'] == null
              ? null
              : int.parse(book['result']['pages'].toString()),
          rate: null,
          binding: book['result']['binding']?.toString(),
        );
        print(newBook.toMap());
        return newBook;
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<Book?> getBookFromServer2(final String isbn) async {
    String requestUrl = _directQueryUrl2 + isbn;
    print(requestUrl);
    try {
      HttpClientRequest request =
          await _httpClient.getUrl(Uri.parse(requestUrl));
      HttpClientResponse response = await request.close();
      var book;
      Uint8List? cover;
      if (response.statusCode == 200) {
        String result = await response.transform(utf8.decoder).join();
        book = json.decode(result);
        if (book['ret'] != 0) return null;
        String? bookImgUrl = book['data']['photoUrl'];
        if (bookImgUrl == null) return null;
        cover = await _getImageFromServer(bookImgUrl);
        Book newBook = Book(
          isbn: book['data']['id'].toString(),
          isbn10: null,
          title: book['data']['name']?.toString(),
          subtitle: book['data']['subname']?.toString(),
          author: book['data']['author']?.toString(),
          ph: book['data']['publishing']?.toString(),
          publishdate: book['data']['published']?.toString(),
          cover: cover,
          price: book['data']['price']?.toString(),
          content: book['data']['description']?.toString(),
          category: null,
          pages: book['data']['pages'] == null
              ? null
              : int.parse(book['data']['pages'].toString()),
          rate: book['data']['doubanScore'] == null
              ? null
              : double.parse(book['data']['doubanScore'].toString()),
          binding: book['data']['designed']?.toString(),
        );
        print(newBook.toMap());
        return newBook;
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<Uint8List?> _getImageFromServer(final String imgUrl) async {
    try {
      return (await NetworkAssetBundle(
        Uri.parse(imgUrl),
      ).load(imgUrl))
          .buffer
          .asUint8List();
    } catch (e) {
      print(e);
      return null;
    }
  }
}
