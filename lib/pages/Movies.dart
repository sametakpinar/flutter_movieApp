import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:movie_app/components/button.dart';
import 'package:movie_app/components/horizontal_card.dart';
import 'package:movie_app/components/title_head.dart';
import 'package:movie_app/definitions.dart';
import 'package:movie_app/main.dart';

class Movies extends StatefulWidget {
  const Movies({super.key});

  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  int _viewType = 0;
  void changeViewType() {
    setState(() {
      _viewType = _viewType == 0 ? 1 : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TitleHead(
            title: "Filmler",
            buttonText: _viewType == 0 ? "Yatay Görünüm" : "Dikey Görünüm",
            onButtonTap: () {
              changeViewType();
            },
            externalButton: const Button(
              externalElement: Icon(
                Iconsax.filter_search_outline,
                size: 15,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: Wrap(
              alignment: WrapAlignment.spaceAround,
              runSpacing: 20,
              children: [
                const HorizontalCard(
                  id: 1,
                  image: "lib/assets/images/image_1.png",
                  title: "",
                  vote: 1,
                  genreList: [],
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  decoration: BoxDecoration(
                    color: HexColor("#110E47"),
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    border: Border.all(width: 1, color: HexColor("#D6D6FD")),
                  ),
                  child: Text(
                    "Daha Fazla Göster",
                    style: GoogleFonts.mulish(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
