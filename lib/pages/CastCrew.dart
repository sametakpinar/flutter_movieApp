import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:movie_app/components/button.dart';
import 'package:movie_app/components/human_card.dart';
import 'package:movie_app/components/title_head.dart';

class CastCrew extends StatefulWidget {
  const CastCrew({super.key});

  @override
  State<CastCrew> createState() => _CastCrewState();
}

class _CastCrewState extends State<CastCrew> {
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
          const TitleHead(
            title: "Oyuncular ve Yönetmenler",
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: Wrap(
              //alignment: WrapAlignment.spaceAround,
              runSpacing: 20,
              spacing: 20,
              children: [
                const HumanCard(
                  image: "lib/assets/images/image_1.png",
                ),
                const HumanCard(
                  image: "lib/assets/images/image_2.png",
                ),
                const HumanCard(
                  image: "lib/assets/images/image_3.png",
                ),
                const HumanCard(
                  image: "lib/assets/images/image_4.png",
                ),
                const HumanCard(
                  image: "lib/assets/images/image_5.png",
                ),
                const HumanCard(
                  image: "lib/assets/images/image_1.png",
                ),
                const HumanCard(
                  image: "lib/assets/images/image_2.png",
                ),
                const HumanCard(
                  image: "lib/assets/images/image_3.png",
                ),
                const HumanCard(
                  image: "lib/assets/images/image_4.png",
                ),
                const HumanCard(
                  image: "lib/assets/images/image_5.png",
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
