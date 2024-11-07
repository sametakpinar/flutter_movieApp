import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:movie_app/definitions.dart';
import 'package:movie_app/main.dart';
import 'package:movie_app/pages/Series.dart';

class BottomMenuItem extends StatefulWidget {
  const BottomMenuItem({
    Key? key,
    required this.icon,
    this.onTap,
    this.activePage = "homePage",
    this.name = "",
  }) : super(key: key);

  final IconData icon;
  final VoidCallback? onTap;
  final String activePage;
  final String name;

  @override
  State<BottomMenuItem> createState() => _BottomMenuItemState();
}

class _BottomMenuItemState extends State<BottomMenuItem> {

  @override
  Widget build(BuildContext context) {
    AnimatedOpacity activeStyle = const AnimatedOpacity(
      //imageFilter: ImageFilter.blur(),
      opacity: 0,
      duration: Duration(milliseconds: 0),
    );
    if (widget.activePage == widget.name) {
      activeStyle = AnimatedOpacity(
        opacity: 1.0,
        duration: const Duration(milliseconds: 500),
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(
            sigmaX: 7,
            sigmaY: 7,
            tileMode: TileMode.decal,
          ),
          child: Icon(
            widget.icon,
            color: HexColor(iconShadowColor),
            size: 23,
          ),
        ),
      );
    }

    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            //color: Colors.amber,
          ),
          child: Stack(
            alignment: const Alignment(0, 0),
            children: [
              activeStyle,
              Icon(
                widget.icon,
                size: 23,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
