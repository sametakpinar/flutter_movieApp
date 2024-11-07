import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:movie_app/api.dart';
import 'package:movie_app/components/button.dart';
import 'package:movie_app/definitions.dart';
import 'package:movie_app/main.dart';
import 'package:movie_app/pages/MovieDetail.dart';

class HorizontalCard extends StatefulWidget {
  const HorizontalCard({
    super.key,
    required this.id,
    required this.image,
    required this.title,
    required this.vote,
    required this.genreList,
  });

  final int id;
  final String image;
  final String title;
  final double vote;
  final List<dynamic> genreList;
  @override
  State<HorizontalCard> createState() => _HorizontalCardState();
}

class _HorizontalCardState extends State<HorizontalCard> {
  @override
  Widget build(BuildContext context) {
    ApiService().setGenres();
    List<dynamic> genreList = widget.genreList;
    return Container(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 85,
              height: 120,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Opacity(
                    opacity: 0.4,
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(
                        sigmaX: 20,
                        sigmaY: 20,
                        tileMode: TileMode.decal,
                      ),
                      child: Image(
                        width: 85,
                        height: 120,
                        image: NetworkImage(widget.image),
                        fit: BoxFit.cover,
                      ),
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
                      width: 85,
                      height: 120,
                      image: NetworkImage(widget.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              /*,*/
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      myAppKey.currentState?.openFullScreeModal(MovieDetail(
                        id: widget.id,
                      ));
                    },
                    child: Text(
                      widget.title,
                      style: GoogleFonts.mulish(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: HexColor(headerTextColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 7),
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
                        "${widget.vote}/10",
                        style: GoogleFonts.mulish(
                          color: HexColor(solidTextColor),
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                      spacing: 5,
                      runSpacing: 5,
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: genreList.map<Widget>((genre) {
                        var s = ApiService().genres;
                        return Button(
                          text: "genres[genre]",
                          style: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: HexColor(cardGenreButtonBG),
                          ),
                          textStyle: GoogleFonts.mulish(
                            color: HexColor(cardGenreButtonText),
                            fontWeight: FontWeight.w700,
                            fontSize: 8,
                          ),
                        );
                      }).toList()),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Iconsax.clock_outline,
                        size: 12,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "2s 40d",
                        style: GoogleFonts.mulish(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
