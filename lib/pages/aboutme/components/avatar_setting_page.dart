import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mybooks/pages/aboutme/components/appBar_setting.dart';
import 'package:provider/provider.dart';
import 'package:mybooks/models/user_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mybooks/pages/components/icon_button.dart';
import 'package:mybooks/pages/components/confirm_dialog.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'dart:typed_data';

class AvatarSettingPage extends StatefulWidget {
  @override
  _AvatarSettingPageState createState() => _AvatarSettingPageState();
}

class _AvatarSettingPageState extends State<AvatarSettingPage> {
  final picker = ImagePicker();
  File? _localImg;
  bool? _isSave;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<MyUserModel>(context);
    return WillPopScope(
      child: Scaffold(
        appBar: appBarForSettingPage(context, title: '头像设置'),
        backgroundColor: Theme.of(context).backgroundColor,
        body: CustomScrollView(
          physics: BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  padding:
                      EdgeInsets.only(left: 30, right: 10, top: 15, bottom: 15),
                  color: Theme.of(context).primaryColor,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          CachedNetworkImage(
                            imageUrl: _localImg == null
                                ? userProvider.avatarUrl == null
                                    ? ''
                                    : userProvider.avatarUrl!
                                : '',
                            placeholder: (context, url) => _getAvatar(),
                            errorWidget: (context, url, error) => _getAvatar(),
                            imageBuilder: (context, imageProvider) => Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -20,
                            right: -20,
                            child: MyIconButton(
                              icon: Text(
                                '更改',
                                style: GoogleFonts.jua(
                                  textStyle: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).buttonColor,
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                final pickedFile = await picker.getImage(
                                    source: ImageSource.gallery);
                                setState(() {
                                  if (pickedFile != null) {
                                    _localImg = File(pickedFile.path);
                                    _isSave = false;
                                  } else
                                    _localImg = null;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      MyIconButton(
                        icon: Icon(
                          Icons.check,
                          size: 20,
                          color: Theme.of(context).buttonColor,
                        ),
                        onPressed: () async {
                          if (_localImg == null) return;
                          Uint8List? newAvatat =
                              await _compressImgFile(_localImg!);
                          //
                          // 服务器
                          //
                          if (newAvatat == null) return;
                          _isSave = true;
                          print(newAvatat.length);
                        },
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
      onWillPop: () async {
        if (_isSave == false) {
          showDialog(
            context: context,
            builder: (context) => ConfirmDialog(content: '未保存，确认退出？'),
            barrierColor: Colors.transparent,
          ).then((value) {
            if (value == null) return;
            Navigator.of(context).pop();
          });
          return false;
        }
        return true;
      },
    );
  }

  Widget _getAvatar() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 1000),
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade200, Colors.teal.shade300],
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
        ),
        image: _localImg == null
            ? null
            : DecorationImage(image: FileImage(_localImg!), fit: BoxFit.cover),
        shape: BoxShape.circle,
      ),
    );
  }

  Future<Uint8List?> _compressImgFile(File file) async {
    var result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 200,
      minHeight: 200,
    );
    print(file.lengthSync());
    if (result != null) print(result.length);
    return result;
  }
}
