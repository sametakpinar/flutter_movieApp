import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:movie_app/api.dart';
import 'package:movie_app/components/bottom_menu.dart';
import 'package:movie_app/components/header.dart';
import 'package:movie_app/definitions.dart';
import 'package:movie_app/pages/HomePage.dart';
import 'package:movie_app/pages/MovieDetail.dart';
import 'package:tmdb_api/tmdb_api.dart';

final GlobalKey<_MyAppState> myAppKey = GlobalKey<_MyAppState>();



void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: myAppKey);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String title = "Movie App";
  StatefulWidget page = const HomePage();
  double screenWidth = 0;
  double screenHeight = 0;
  

  Widget videoModal = SizedBox();
  void pageChange(StatefulWidget setPage) {
    setState(() {
      page = setPage;
    });
  }

  void openFullScreeModal(modal) {
    setState(() {
      videoModal = modal;
    });
  }
  void closeFullScreeModal() {
    setState(() {
      videoModal = SizedBox();
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      screenWidth = MediaQuery.of(context).size.width;
      screenHeight = MediaQuery.of(context).size.height;
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            Container(
              width: screenWidth,
              height: screenHeight,
              decoration: BoxDecoration(color: HexColor(bgColor)),
              child: SafeArea(
                child: LayoutBuilder(
                  builder: (
                    BuildContext context,
                    BoxConstraints constraints,
                  ) {
                    return Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height - (93),
                          child: SingleChildScrollView(
                            padding: EdgeInsets.fromLTRB(0, 80, 0, 60),
                            child: page,
                          ),
                        ),
                        Header(
                          title: title,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                        ),
                        Positioned(
                          bottom: 0,
                          child: BottomMenu(
                            title: title,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                          ),
                        ),
                        Positioned.fill(
                          top: 0,
                          left: 0,
                          child: videoModal,
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
