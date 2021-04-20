import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mybooks/pages/components/slide_show_dialog.dart';

class SelectDialog extends StatefulWidget {
  final String content;
  final Map<dynamic, dynamic> selected;
  final dynamic? defaultIndex;
  SelectDialog({
    Key? key,
    required this.content,
    required this.selected,
    this.defaultIndex,
  }) : super(key: key);
  @override
  _SelectDialogState createState() => _SelectDialogState();
}

class _SelectDialogState extends State<SelectDialog> {
  late dynamic _index;

  @override
  void initState() {
    if (widget.defaultIndex == null)
      _index = widget.selected.keys.toList()[0];
    else
      _index = widget.defaultIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SlideShowDialog(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            left: 20,
            right: 20,
            bottom: 10,
            child: Container(
              padding: EdgeInsets.only(top: 25, bottom: 20),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                      Text(
                        widget.content,
                        style: GoogleFonts.acme(
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.none,
                            color: Theme.of(context).buttonColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                    ] +
                    List.generate(
                      widget.selected.length,
                      (index) => SecretItem(
                        isToggle:
                            _index == widget.selected.keys.toList()[index]!,
                        onPressed: () {
                          setState(() {
                            _index = widget.selected.keys.toList()[index]!;
                          });
                          Navigator.of(context).pop(_index);
                        },
                        hintStr: widget.selected.values.toList()[index]!,
                      ),
                    ),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).dialogBackgroundColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SecretItem extends StatelessWidget {
  final bool isToggle;
  final GestureTapCallback onPressed;
  final String hintStr;
  SecretItem({
    Key? key,
    required this.isToggle,
    required this.onPressed,
    required this.hintStr,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 30),
            Icon(
              isToggle
                  ? Icons.radio_button_on_sharp
                  : Icons.radio_button_off_sharp,
              color: isToggle
                  ? Theme.of(context).hintColor
                  : Theme.of(context).buttonColor,
              size: 15,
            ),
            SizedBox(width: 20),
            Text(
              hintStr,
              style: Theme.of(context).textTheme.headline2,
            ),
          ],
        ),
      ),
    );
  }
}
