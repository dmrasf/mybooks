import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:mybooks/models/user_provider.dart';
import 'dart:io';
import 'dart:convert';

class BookcaseTitleCard extends StatefulWidget {
  final int? booksNum;
  BookcaseTitleCard({this.booksNum});
  @override
  _BookcaseTitleCardState createState() => _BookcaseTitleCardState();
}

class _BookcaseTitleCardState extends State<BookcaseTitleCard> {
  Map<String, dynamic>? dailyPoetry;
  final _httpClient = HttpClient();
  String _showPoetry = '';
  Map<String, dynamic> _poetry = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(
      (timeStamp) => _getDailyPoetry(context),
    );
  }

  /// 获取token
  Future<void> _getToken(BuildContext cnt) async {
    if (cnt.read<MyUserModel>().dailyPoetryToken != null) return;
    final String getTokenUrl = 'https://v2.jinrishici.com/token';
    try {
      HttpClientRequest request =
          await _httpClient.getUrl(Uri.parse(getTokenUrl));
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String result = await response.transform(utf8.decoder).join();
        var tokenData = json.decode(result);
        if (tokenData['status'] == null || tokenData['status'] != 'success')
          return;
        cnt.read<MyUserModel>().dailyPoetryToken = tokenData['data'];
      }
    } catch (e) {
      print(e);
      return;
    }
  }

  Future<void> _getDailyPoetry(BuildContext cnt) async {
    if (cnt.read<MyUserModel>().dailyPoetryToken == null) return;

    final _httpClient = HttpClient();
    final String getPoetryUrl = 'https://v2.jinrishici.com/sentence';

    try {
      HttpClientRequest request =
          await _httpClient.getUrl(Uri.parse(getPoetryUrl));
      request.headers.add(
        'X-User-Token',
        cnt.read<MyUserModel>().dailyPoetryToken!,
      );
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String result = await response.transform(utf8.decoder).join();
        var poetryData = json.decode(result);
        if (poetryData['status'] == null || poetryData['status'] != 'success')
          return;
        _poetry.addAll(poetryData['data']);
        setState(() => _showPoetry = poetryData['data']['content'].toString());
      }
    } catch (e) {
      print(e);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<MyUserModel>(context);
    if (userProvider.dailyPoetryToken == null) _getToken(context);
    return Container(
      height: 120,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 30,
            bottom: 20,
            child: Text(
              widget.booksNum == null ? '0' : widget.booksNum!.toString(),
              style: GoogleFonts.jua(
                textStyle: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).buttonColor.withOpacity(0.9),
                ),
              ),
            ),
          ),
          Positioned(
            right: 5,
            top: 15,
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.45),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  _showPoetry,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: Theme.of(context).buttonColor.withOpacity(0.7),
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.7),
        //gradient: LinearGradient(
        //colors: [Color(0xff7080e7), Color(0xff90eaff)],
        //begin: Alignment.topCenter,
        //end: Alignment.bottomRight,
        //),

        //borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
    );
  }
}
