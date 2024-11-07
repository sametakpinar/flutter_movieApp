import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:movie_app/components/button.dart';
import 'package:movie_app/definitions.dart';
import 'package:movie_app/main.dart';

class HumanCard extends StatefulWidget {
  const HumanCard({super.key, required this.image});

  final String image;
  @override
  State<HumanCard> createState() => _HumanCardState();
}

class _HumanCardState extends State<HumanCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: myAppKey.currentState!.screenWidth / 2 - 34,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.all(
          Radius.circular(7),
        ),
      ),
      child: Column(
        children: [
          Image.asset(
            widget.image,
            fit: BoxFit.cover,
            height: 100,
          ),
        ],
      ),
    );
  }
}
