import 'dart:ffi';
import 'dart:ui';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:movie_app/api.dart';
import 'package:movie_app/components/button.dart';
import 'package:movie_app/components/title_head.dart';
import 'package:movie_app/definitions.dart';
import 'package:movie_app/main.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetail extends StatefulWidget {
  const MovieDetail({super.key, required this.id});

  final int id;
  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  final ApiService apiService = ApiService();
  double imageTop = -myAppKey.currentState!.screenHeight / 100 * 25;
  double containerBottom = -myAppKey.currentState!.screenHeight -
      (myAppKey.currentState!.screenHeight / 100 * 25);
  Map<String, dynamic> movie = {};
  Map<String, dynamic> credit = {};
  Map<String, dynamic> images = {};
  Map<String, dynamic> videos = {};
  List allImages = [];

  bool pageStart = false;
  int pageAnimation = 0;

  @override
  void initState() {
    super.initState();
    getPageData();
  }

  Future<void> getPageData() async {
    final pMovie = await apiService.getMovieDetail(widget.id);
    final pCredit = await apiService.getCredits(widget.id);
    final pImages = await apiService.getImages(widget.id);
    final pVideos = await apiService.getVideos(widget.id);
    setState(() {
      movie = pMovie;
      credit = pCredit;
      images = pImages;
      videos = pVideos;
      allImages = [
        ...?images["backdrops"],
        ...?images["posters"],
        ...?images["logos"],
      ];

      pageStart = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (movie.isEmpty) return;
      if (pageAnimation == 0) {
        pageAnimation = 1;
        setState(() {
          imageTop = 0;
          containerBottom = 0;
        });
      }
    });
    String getImagePath(dynamic value) {
      return value == null
          ? "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.w3schools.com%2Fhowto%2Fimg_avatar.png&f=1&nofb=1&ipt=bf3e0e676ca33eb86670d0ffc71ed7bc6234717006f2f9f0f62190d5d2fdafb6&ipo=images"
          : "https://image.tmdb.org/t/p/w500${value}";
    }

    return pageStart == false
        ? Container()
        : Container(
            width: myAppKey.currentState?.screenWidth,
            height: myAppKey.currentState?.screenHeight,
            color: Colors.transparent,
            child: Stack(
              children: <Widget>[
                AnimatedPositioned(
                  top: imageTop,
                  left: 0,
                  duration: const Duration(milliseconds: 200),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Image.network(
                        "https://image.tmdb.org/t/p/w500${movie['poster_path']}",
                        width: myAppKey.currentState?.screenWidth,
                        height: myAppKey.currentState!.screenHeight / 100 * 25,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Image.asset(
                            'lib/assets/images/image_1.png',
                            width: myAppKey.currentState?.screenWidth,
                            height:
                                myAppKey.currentState!.screenHeight / 100 * 25,
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'lib/assets/images/image_1.png',
                            width: myAppKey.currentState?.screenWidth,
                            height:
                                myAppKey.currentState!.screenHeight / 100 * 25,
                          );
                        },
                      ),
                      ColoredBox(
                        color: Colors.black.withOpacity(0.35),
                        child: SizedBox(
                          width: myAppKey.currentState?.screenWidth,
                          height:
                              myAppKey.currentState!.screenHeight / 100 * 25,
                        ),
                      ),
                      Positioned(
                        bottom: 40,
                        child: Container(
                          child: Column(
                            children: [
                              const Icon(
                                Iconsax.play_circle_outline,
                                color: Colors.white,
                                size: 60,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Fragmanı Oynat",
                                style: GoogleFonts.mulish(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        right: 20,
                        child: InkWell(
                          child: Container(
                            child: const Icon(
                              OctIcons.kebab_horizontal,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedPositioned(
                  bottom: containerBottom,
                  left: 0,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    width: myAppKey.currentState?.screenWidth,
                    height: myAppKey.currentState!.screenHeight -
                        (myAppKey.currentState!.screenHeight / 100 * 35) +
                        15,
                    decoration: BoxDecoration(
                      color: HexColor(bgColor),
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: const Offset(0, -10),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movie['title'],
                                  style: GoogleFonts.mulish(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      OctIcons.star_fill,
                                      color: HexColor(starColor),
                                      size: 14,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      "${movie["vote_average"]}/10 (${movie["vote_count"]})",
                                      style: GoogleFonts.mulish(
                                        color: HexColor(solidTextColor),
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Wrap(
                                  spacing: 5,
                                  runSpacing: 5,
                                  //mainAxisAlignment: MainAxisAlignment.start,
                                  children: movie["genres"].map<Widget>(
                                    (genre) {
                                      return Button(
                                        text: genre["name"],
                                        style: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: HexColor(cardGenreButtonBG),
                                        ),
                                        textStyle: GoogleFonts.mulish(
                                          color: HexColor(cardGenreButtonText),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 10,
                                        ),
                                      );
                                    },
                                  ).toList(),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Süre",
                                          style: GoogleFonts.mulish(
                                            color: HexColor(solidTextColor),
                                            fontWeight: FontWeight.w300,
                                            fontSize: 13,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "1s 45dk",
                                          style: GoogleFonts.mulish(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Dil",
                                          style: GoogleFonts.mulish(
                                            color: HexColor(solidTextColor),
                                            fontWeight: FontWeight.w300,
                                            fontSize: 13,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "Türkçe",
                                          style: GoogleFonts.mulish(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Tür",
                                          style: GoogleFonts.mulish(
                                            color: HexColor(solidTextColor),
                                            fontWeight: FontWeight.w300,
                                            fontSize: 13,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "Yetişkin",
                                          style: GoogleFonts.mulish(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                Text(
                                  "Ön İzleme",
                                  style: GoogleFonts.merriweather(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: HexColor(headerTextColor),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  movie["overview"],
                                  style: GoogleFonts.mulish(
                                      fontSize: 14,
                                      color: HexColor(solidTextColor)),
                                ),
                                const SizedBox(height: 26),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Oyuncular (" +
                                      credit["cast"].length.toString() +
                                      ")",
                                  style: GoogleFonts.merriweather(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: HexColor(headerTextColor),
                                  ),
                                ),
                                Button(text: "Tümünü Göster")
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.fromLTRB(24, 24, 24, 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: credit["cast"].map<Widget>(
                                (cast) {
                                  return Container(
                                    width: 100,
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Stack(
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
                                                    width: 100 / 2,
                                                    height: 100 / 2,
                                                    image: NetworkImage(
                                                      getImagePath(
                                                          cast["profile_path"]),
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                clipBehavior: Clip.antiAlias,
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(6),
                                                  ),
                                                ),
                                                child: Image(
                                                  width: 100,
                                                  height: 100,
                                                  image: NetworkImage(
                                                    getImagePath(
                                                        cast["profile_path"]),
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            cast["original_name"] +
                                                " \n(" +
                                                cast["character"] +
                                                ")",
                                            softWrap: true,
                                            style: GoogleFonts.mulish(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(24, 20, 24, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Resim Galeri", // (${images["posters"].length + images["backdrops"].length + images["logos"].length})
                                  style: GoogleFonts.merriweather(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: HexColor(headerTextColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 240,
                            child: Swiper(
                              itemCount: allImages.length,
                              itemBuilder: (BuildContext context, int index) {
                                final image = allImages[index];
                                return Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(24, 16, 24, 0),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(6),
                                    ),
                                  ),
                                  child: Image.network(
                                    "https://image.tmdb.org/t/p/w500${image['file_path']}",
                                    width: 300,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 24),
                          Padding(
                            padding: EdgeInsets.fromLTRB(24, 20, 24, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Video Galeri",
                                  style: GoogleFonts.merriweather(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: HexColor(headerTextColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 240,
                            child: Swiper(
                              itemCount: videos["results"].length,
                              itemBuilder: (BuildContext context, int index) {
                                var s = videos["results"][index];
                                //dynamic player = YoutubePlayer.convertUrlToId(
                                //    "https://www.youtube.com/watch?v=${videos[index]}");

                                YoutubePlayerController _controller =
                                    YoutubePlayerController(
                                  initialVideoId: s["key"],
                                  flags: YoutubePlayerFlags(
                                    autoPlay: false,
                                    mute: true,
                                  ),
                                );

                                return Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(24, 16, 24, 0),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(6),
                                    ),
                                  ),
                                  child: YoutubePlayer(
                                    controller: _controller,
                                    showVideoProgressIndicator: true,
                                    progressIndicatorColor: Colors.amber,
                                    progressColors: const ProgressBarColors(
                                      playedColor: Colors.amber,
                                      handleColor: Colors.amberAccent,
                                    ),
                                    onReady: () {
                                      //_controller.addListener(listener);
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 20,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        imageTop =
                            -myAppKey.currentState!.screenHeight / 100 * 25;
                        containerBottom = -myAppKey.currentState!.screenHeight -
                            (myAppKey.currentState!.screenHeight / 100 * 25);
                        Future.delayed(const Duration(milliseconds: 200), () {
                          myAppKey.currentState?.closeFullScreeModal();
                        });
                      });
                    },
                    child: Container(
                      child: const Icon(
                        OctIcons.reply,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                    /*
               */
                  ),
                ),
              ],
            ),
          );
  }
}
