import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:movie_app/components/bottom_menu_item.dart';
import 'package:movie_app/definitions.dart';
import 'package:movie_app/main.dart';
import 'package:movie_app/pages/CastCrew.dart';
import 'package:movie_app/pages/HomePage.dart';
import 'package:movie_app/pages/Movies.dart';
import 'package:movie_app/pages/Series.dart';

class BottomMenu extends StatefulWidget {
  const BottomMenu({
    super.key,
    required this.title,
    required this.width,
    required this.height,
    this.homePage = true,
    this.moviesPage = false,
    this.seriesPage = false,
    this.castCrewPage = false,
  });

  final String title;
  final double width;
  final double height;
  final bool homePage;
  final bool moviesPage;
  final bool seriesPage;
  final bool castCrewPage;

  @override
  State<BottomMenu> createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  String _activePage = "homePage"; // Başlangıçta aktif sayfa

  void _updateActivePage(String newPage) {
    setState(() {
      _activePage = newPage; // Aktif sayfayı güncelle
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      width: widget.width,
      decoration: BoxDecoration(
        color: HexColor(bgColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 15,
            offset: const Offset(0, -15),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          BottomMenuItem(
            icon: Iconsax.home_1_outline,
            name: "homePage",
            onTap: () {
              setState(() {
                _updateActivePage("homePage");
              });
              myAppKey.currentState?.pageChange(const HomePage());
            },
            activePage: _activePage,
          ),
          BottomMenuItem(
            icon: Iconsax.video_play_outline,
            name: "moviesPage",
            onTap: () {
              setState(() {
                _updateActivePage("moviesPage");
              });
              myAppKey.currentState?.pageChange(const Movies());
            },
            activePage: _activePage,
          ),
          BottomMenuItem(
            icon: Iconsax.video_vertical_outline,
            name: "seriesPage",
            onTap: () {
              setState(() {
                _updateActivePage("seriesPage");
              });
              myAppKey.currentState?.pageChange(const Series());
            },
            activePage: _activePage,
          ),
          BottomMenuItem(
            icon: Iconsax.user_outline,
            name: "castCrewPage",
            onTap: () {
              setState(() {
                _updateActivePage("castCrewPage");
              });
              myAppKey.currentState?.pageChange(const CastCrew());
            },
            activePage: _activePage,
          )
        ],
      ),
    );
  }
}
