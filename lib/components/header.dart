import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:movie_app/definitions.dart';

class Header extends StatefulWidget {
  const Header(
      {super.key,
      required this.title,
      required this.width,
      required this.height});

  final String title;
  final double width;
  final double height;
  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: widget.width,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            height: 60,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0.1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Icon(
                  Iconsax.element_equal_outline,
                  size: 19,
                ),
                Text(
                  widget.title,
                  style: GoogleFonts.merriweather(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    color: HexColor(headerTextColor)
                  ),
                ),
                const Icon(
                  Iconsax.search_normal_outline,
                  size: 17,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
