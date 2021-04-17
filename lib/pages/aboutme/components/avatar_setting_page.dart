import 'package:flutter/material.dart';
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
import 'package:mybooks/pages/components/toast.dart';
import 'package:mybooks/pages/components/wait_action_icon_button.dart';

class AvatarSettingPage extends StatefulWidget {
  @override
  _AvatarSettingPageState createState() => _AvatarSettingPageState();
}

class _AvatarSettingPageState extends State<AvatarSettingPage> {
  final picker = ImagePicker();
  Uint8List? _localImgByte;
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
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  color: Theme.of(context).primaryColor,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          CachedNetworkImage(
                            imageUrl: _localImgByte == null
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
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              onPressed: () async {
                                try {
                                  final pickedFile = await picker.getImage(
                                      source: ImageSource.gallery);
                                  if (pickedFile != null) {
                                    _localImgByte = await _compressImgFile(
                                        File(pickedFile.path));
                                    if (_localImgByte != null) {
                                      print(_localImgByte!.length);
                                      _isSave = false;
                                      setState(() {});
                                    }
                                  } else {
                                    _localImgByte = null;
                                  }
                                } catch (_) {
                                  showToast(context, '请设置权限',
                                      type: ToastType.ERROR);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      WaitActionIconButton(
                        iconSize: 18,
                        startIcon: Icons.cloud_circle,
                        action: () async {
                          if (_isSave == true) {
                            showToast(context, '已经成功，请重新选择图片');
                            return true;
                          }
                          if (_localImgByte == null) {
                            showToast(context, '未选择图片');
                            return true;
                          }

                          //
                          // 服务器
                          //
                          await Future.delayed(Duration(seconds: 2));
                          _isSave = true;
                          showToast(context, '上传成功');
                          //showToast(context, '上传失败', type: ToastType.ERROR);
                          return true;
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
        image: _localImgByte == null
            ? null
            : DecorationImage(
                image: MemoryImage(_localImgByte!),
                fit: BoxFit.cover,
              ),
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
