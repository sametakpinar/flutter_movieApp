import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:movie_app/definitions.dart';

class VerticalCard extends StatefulWidget {
  const VerticalCard({super.key, required this.image, required this.title, required this.vote});

  final String image;
  final String title;
  final double vote;

  @override
  State<VerticalCard> createState() => _VerticalCardState();
}

class _VerticalCardState extends State<VerticalCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        width: 143,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 143,
              height: 212,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  ImageFiltered(
                    imageFilter: ImageFilter.blur(
                      sigmaX: 30,
                      sigmaY: 30,
                      tileMode: TileMode.decal,
                    ),
                    child: Image(
                      width: 143 / 1.5,
                      height: 212 / 1.5,
                      image: NetworkImage(widget.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(6),
                      ),
                    ),
                    child: Image(
                      width: 143,
                      height: 212,
                      image: NetworkImage(widget.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              /*,*/
            ),
            const SizedBox(height: 5),
            Text(
              widget.title,
              style: GoogleFonts.mulish(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: HexColor(headerTextColor),
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  OctIcons.star_fill,
                  color: HexColor(starColor),
                  size: 12,
                ),
                const SizedBox(width: 5),
                Text(
                  widget.vote.toString() + "/10",
                  style: GoogleFonts.mulish(
                    color: HexColor(solidTextColor),
                    fontSize: 12,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
