import 'package:flutter/material.dart';
import 'package:mybooks/utils/database.dart';
import 'package:mybooks/utils/check_isbn.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:mybooks/pages/aboutme/components/appBar_setting.dart';
import 'package:mybooks/pages/components/toast.dart';
import 'package:mybooks/pages/scan/components/scan_books_list.dart';
import 'package:mybooks/pages/scan/components/scan_text_button.dart';
import 'package:mybooks/pages/components/float_button.dart';
import 'package:mybooks/pages/components/confirm_dialog.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:mybooks/models/userbooks_provider.dart';

class ScanBarCodePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScanBarCodePageState();
}

class _ScanBarCodePageState extends State<ScanBarCodePage> {
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? _controller;
  Barcode? _result;
  Set<String> _isbns = Set();

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) _controller?.pauseCamera();
    _controller?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: appBarForSettingPage(context, title: '添加书籍'),
        backgroundColor: Theme.of(context).backgroundColor,
        floatingActionButtonLocation: CustomFloatingActionButtonLocation(
          location: FloatingActionButtonLocation.endTop,
          offsetX: 8,
          offsetY: -23,
        ),
        floatingActionButton: FloatButton(
          child: Icon(Icons.flash_on, size: 15),
          onPressed: () => _controller?.toggleFlash(),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: _buildBarScanView(context),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ScanBooksList(isbns: _isbns.toList()),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ScanActionButton(
                        onPressed: () {
                          if (_isbns.isNotEmpty)
                            setState(() => _isbns.remove(_result?.code));
                        },
                        title: '取消本次操作',
                      ),
                      ScanActionButton(
                        onPressed: () {
                          if (_isbns.isEmpty) return;
                          showDialog<bool>(
                            context: context,
                            builder: (context) =>
                                ConfirmDialog(content: '确认清空？'),
                            barrierColor: Colors.transparent,
                          ).then((isConfirm) {
                            if (isConfirm != null) if (isConfirm) {
                              if (_isbns.isEmpty) return;
                              setState(() => _isbns.clear());
                            }
                          });
                        },
                        title: '全部清空',
                        type: Theme.of(context).errorColor,
                      ),
                      ScanActionButton(
                        onPressed: () {
                          if (_isbns.isEmpty) return;
                          _addNewBooksToDatabase().then((value) {
                            if (value != 0)
                              showToast(context, '有$value本书已经存在，没有被添加');
                            setState(() {});
                          });
                        },
                        title: '全部添加',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onWillPop: () async {
        if (_isbns.isEmpty) return true;
        bool? isQuit = await showDialog<bool>(
          context: context,
          builder: (context) => ConfirmDialog(content: '确认退出？'),
          barrierColor: Colors.transparent,
        );
        if (isQuit == true) return true;
        return false;
      },
    );
  }

  Widget _buildBarScanView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 250.0;
    return QRView(
      key: _qrKey,
      onQRViewCreated: (QRViewController controller) {
        setState(() => _controller = controller);
        _controller!.scannedDataStream.listen(
          (scanData) {
            if (_isbns.contains(scanData.code))
              return;
            else if (checkIsbn(scanData.code))
              DataBaseUtil.getBook(isbn: scanData.code).then((value) {
                if (_isbns.contains(scanData.code)) return;
                if (value == null) return;
                setState(() {
                  _result = scanData;
                  _isbns.add(_result!.code);
                });
              });
            else
              showToast(context, '这不是书', type: ToastType.ERROR);
          },
        );
      },
      overlay: QrScannerOverlayShape(
        borderColor: Theme.of(context).primaryColor,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
    );
  }

  Future<int> _addNewBooksToDatabase() async {
    final userBooksModel = Provider.of<MyUserBooksModel>(context);
    int repeat = 0;
    Set<String> newIsbn = Set();
    _isbns.forEach((e) async {
      if (userBooksModel.userBooks.containsKey(e)) {
        repeat++;
      } else if (!await context
          .read<MyUserBooksModel>()
          .addUserBook(UserBook(isbn: e, touchdate: DateTime.now().toString())))
        newIsbn.add(e);
    });
    _isbns = newIsbn;
    return repeat;
  }
}
