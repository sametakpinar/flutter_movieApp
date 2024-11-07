import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class Button extends StatefulWidget {
  const Button({
    super.key,
    this.text = "",
    this.style,
    this.textStyle,
    this.onTab,
    this.externalElement = const SizedBox(),
  });

  final String text;
  final BoxDecoration? style;
  final TextStyle? textStyle;
  final Widget externalElement;
  final VoidCallback? onTab;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  String text = "";
  BoxDecoration? style;
  TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    text = widget.text;
    if (widget.style == null) {
      style = BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: HexColor("#E5E4EA")));
    } else
      style = widget.style;
    if (widget.textStyle == null) {
      textStyle = GoogleFonts.mulish(
        color: HexColor("#AAA9B1"),
        fontWeight: FontWeight.w600,
        fontSize: 11,
      );
    } else
      textStyle = widget.textStyle;

    List<Widget> children = [];
    if (text != "") {
      children.add(
        Text(
          text,
          style: textStyle,
        ),
      );
      //
    }
    // ignore: unnecessary_null_comparison
    if (widget.externalElement != null) {
      children.add(widget.externalElement);
    }
    return Container(
      decoration: style,
      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
      child: Column(children: children),
    );
  }
}