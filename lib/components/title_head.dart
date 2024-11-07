import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:movie_app/components/button.dart';
import 'package:movie_app/definitions.dart';

class TitleHead extends StatefulWidget {
  const TitleHead({
    super.key,
    this.title = "Title",
    this.buttonText = "",
    this.onButtonTap,
    this.externalButton = const SizedBox(),
    this.externalPosition,
    this.customContent = const Wrap(children: []),
  });

  final String title;
  final String buttonText;
  final VoidCallback? onButtonTap;

  final Widget externalButton;
  final int? externalPosition;
  final Wrap customContent;
  @override
  State<TitleHead> createState() => _TitleHeadState();
}

class _TitleHeadState extends State<TitleHead> {
  // Wrap children;
  @override
  Widget build(BuildContext context) {
    Wrap wrap = widget.customContent;
    if (wrap.children.isEmpty) {
      List<Widget> wrapContent = [];
      if (!widget.buttonText.isEmpty) {
        wrapContent.add(
          InkWell(
            onTap: widget.onButtonTap,
            child: Button(
              text: widget.buttonText,
            ),
          ),
        );
      }
      if (widget.externalButton != const SizedBox()) {
        wrapContent.add(widget.externalButton);
      }
      wrap = Wrap(
        spacing: 10,
        children: wrapContent,
      );
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            widget.title,
            style: GoogleFonts.merriweather(
              fontWeight: FontWeight.w900,
              fontSize: 21,
              color: HexColor(headerTextColor),
            ),
          ),
          wrap
        ],
      ),
    );
  }
}
