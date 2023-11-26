import 'dart:convert';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipe/Screen/B2_Youtube_Video/PlayYoutube.dart';
import 'package:recipe/Style/Style.dart';
import 'package:recipe/service/ad_mob_service.dart';

class RecipeDetailScreen extends StatefulWidget {
  List ingredient, directions;
  String image, title, time, calorie, videoURI, videoTitle, videoDesc;
  RecipeDetailScreen({
    required this.image,
    required this.title,
    required this.ingredient,
    required this.directions,
    // required this.category,
    required this.time,
    required this.calorie,
    required this.videoURI,
    required this.videoTitle,
    required this.videoDesc,
    // this.id,
    // this.userId,
    // this.rating
  });

  @override
  _RecipeDetailScreenState createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  Widget bookmark = LocaleText("save",
      style: TextStyle(
          fontFamily: "Sofia",
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 20.0));
  late InterstitialAd _interstitial;
  bool isLoaded = false, buttonClicked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadInterstitial();
  }

  void loadInterstitial() {
    InterstitialAd.load(
      adUnitId: AdMobService.interstitialAdUnitId.toString(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitial = ad;
          isLoaded = true;
          print("loaded");
          // isLoaded = true;
        },
        onAdFailedToLoad: (err) {
          isLoaded = false;
          _interstitial.dispose();
          debugPrint("error");
        },
      ),
      request: AdRequest(),
    );
  }

  Widget build(BuildContext context) {
    // String _name, _email;
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    var _ingredients = Container(
        color: Colors.black12.withOpacity(0.015),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  top: 30.0, left: 20.0, right: 20.0, bottom: 10.0),
              child: LocaleText(
                "ingredients",
                style: TextStyle(
                    fontFamily: "Sofia",
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 0.0, left: 20.0, right: 20.0, bottom: 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.ingredient
                    .map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(
                          top: 10.0,
                          left: 10.0,
                          bottom: 10.0,
                        ),
                        child: new Text(
                          "- " + item,
                          style: TextStyle(
                            fontFamily: "Sofia",
                            color: Colors.black54,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            SizedBox(
              height: 30.0,
            )
          ],
        ));
    var _directions = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
              top: 60.0, left: 20.0, right: 20.0, bottom: 10.0),
          child: LocaleText(
            "directions",
            style: TextStyle(
                fontFamily: "Sofia",
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.w700),
            textAlign: TextAlign.justify,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: 0.0, left: 20.0, right: 20.0, bottom: 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.directions
                .map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 10.0, bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "-   ",
                          style: TextStyle(color: Colors.black),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.3,
                          child: new Text(
                            item,
                            style: TextStyle(
                                fontFamily: "Sofia",
                                color: Colors.black54,
                                fontSize: 18.0),
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
    var icon = TextStyle(
        fontFamily: "Sofia",
        fontWeight: FontWeight.w600,
        color: Colors.black87,
        fontSize: 12.0);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: <Widget>[
            /// AppBar
            SliverPersistentHeader(
              delegate: MySliverAppBar(
                  expandedHeight: _height - 30.0,
                  title: widget.title,
                  img: widget.image
                  // img: widget.image,
                  // id: widget.id,
                  // title: widget.title,
                  // time: widget.time,
                  // category: widget.category,
                  // rating: widget.rating
                  ),
              pinned: true,
            ),

            SliverToBoxAdapter(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 30.0, left: 20.0, right: 20.0, bottom: 10.0),
                    child: LocaleText(
                      "informations",
                      style: TextStyle(
                          fontFamily: "Sofia",
                          fontSize: 20.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 10.0),
                    child: Container(
                        height: 60.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12.withOpacity(0.13),
                                blurRadius: 7.0,
                                spreadRadius: 1.0),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10.0, top: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                _infoCircleIcon(
                                  EvaIcons.shoppingBag,
                                  widget.ingredient.length.toString(),
                                  LocaleText(
                                    widget.ingredient.length > 1
                                        ? "stuffs"
                                        : "stuff",
                                    style: icon,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                _infoCircleIcon(
                                  Icons.query_builder,
                                  widget.time,
                                  LocaleText(
                                    "",
                                    style: icon,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                _infoCircleIcon(
                                  Icons.whatshot,
                                  widget.calorie,
                                  LocaleText(
                                    'cal',
                                    style: icon,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  // Center(
                  //   child: Padding(
                  //     padding: EdgeInsets.symmetric(vertical: 15),
                  //     child: AdMobService.createBanner(AdSize.banner),
                  //   ),
                  // ),

                  /// Description
                  _ingredients,
                  // Center(
                  //   child: Padding(
                  //     padding: EdgeInsets.symmetric(vertical: 15),
                  //     child: AdMobService.createBanner(AdSize.banner),
                  //   ),
                  // ),

                  /// Description
                  _directions,
                  // Center(
                  //   child: Padding(
                  //     padding: EdgeInsets.symmetric(vertical: 15),
                  //     child: AdMobService.createBanner(AdSize.banner),
                  //   ),
                  // ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 60.0, left: 20.0, right: 20.0, bottom: 10.0),
                        child: LocaleText(
                          "video_tutorial",
                          style: TextStyle(
                              fontFamily: "Sofia",
                              fontSize: 20.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          
                          Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder: (_, __, ___) => new detailVideo(
                                    url: widget.videoURI,
                                    title: widget.videoTitle,
                                    desc: widget.videoDesc,
                                  )));
                          loadInterstitial();
                          _interstitial.show();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 20.0),
                          child: Container(
                            height: 300.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12.withOpacity(0.1),
                                  blurRadius: 3.0,
                                  spreadRadius: 1.0,
                                )
                              ],
                            ),
                            child: Column(children: [
                              Container(
                                height: 165.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10.0),
                                      topLeft: Radius.circular(10.0)),
                                  image: DecorationImage(
                                      // image: NetworkImage(
                                      //     list[i]['snippet']['thumbnails']["high"]["url"]),
                                      image: AssetImage(widget.image),
                                      fit: BoxFit.cover),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black12.withOpacity(0.4),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10.0),
                                        topLeft: Radius.circular(10.0)),
                                  ),
                                  child: Center(
                                    child: CircleAvatar(
                                        radius: 30.0,
                                        backgroundColor: Colors.white24,
                                        child: Icon(
                                          Icons.play_arrow,
                                          color: Colors.white,
                                          size: 30.0,
                                        )),
                                  ),
                                ),
                                alignment: Alignment.topRight,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                              width: 290.0,
                                              child: Text(
                                                // list[i]['snippet']['title'],
                                                widget.videoTitle,
                                                style: TextStyle(
                                                    fontFamily: "Sofia",
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 17.5),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              )),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(top: 5.0)),
                                          Container(
                                            width: 290.0,
                                            child: Text(
                                              // list[i]['snippet']['description'],
                                              widget.videoDesc,
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w300,
                                                  fontFamily: "Sofia",
                                                  color: Colors.black38),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () async {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.info,
                        dismissOnTouchOutside: true,
                        title: "Add this Recipe?",
                        desc: "Are you sure you want to add ?",
                        btnOkOnPress: () async {
                          Map<String, dynamic> obj = {
                            "title": widget.title,
                            "calorie": widget.calorie,
                            "image": widget.image,
                            "directions": widget.directions,
                            "ingredients": widget.ingredient,
                            "time": widget.time,
                            "video": {
                              "uri": widget.videoURI,
                              "desc": widget.videoDesc,
                              "title": widget.videoTitle,
                            }
                          };
                          final directory =
                              await getApplicationDocumentsDirectory();
                          final path = directory.path;
                          // print(path);
                          if (!await File('$path/favorite.json').exists()) {
                            await File('$path/favorite.json')
                                .writeAsString("[]");
                          }

                          String result =
                              await File('$path/favorite.json').readAsString();
                          List list = await json.decode(result);

                          if (!(list
                                  .where((element) =>
                                      element["title"] == obj["title"])
                                  .length >
                              0)) {
                            list.add(obj);
                          }

                          await File('$path/favorite.json')
                              .writeAsString(json.encode(list));
                          setState(
                            () {
                              loadInterstitial();
                              buttonClicked = true;
                              bookmark = LocaleText(
                                'saved',
                                style: TextStyle(
                                    fontFamily: "Sofia",
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20.0),
                              );
                            },
                          );
                          Future.delayed(Duration(milliseconds: 500), () {
                            _interstitial.show();
                          });
                        },
                        animType: AnimType.scale,
                      ).show();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 50.0, bottom: 30.0),
                      child: Container(
                        height: 52.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            // color: colorStyle.primaryColor,
                            color: buttonClicked
                                ? colorStyle.primaryColor.withOpacity(0.5)
                                : colorStyle.primaryColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(40.0))),
                        child: Center(
                          child: bookmark,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.black12.withOpacity(0.015),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                ])),
          ],
        ),
      ),
      bottomNavigationBar: AdMobService.createBanner(AdSize.fullBanner),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  // num rating;
  // String img, id, title, category, time;
  final String title, img;

  MySliverAppBar({
    required this.expandedHeight,
    required this.title,
    required this.img,
    // this.id,
    // this.title,
    // this.time,
    // this.category,
    // this.rating
  });

  var _txtStyleTitle = TextStyle(
    color: Colors.black54,
    fontFamily: "Sofia",
    fontSize: 20.0,
    fontWeight: FontWeight.w800,
    overflow: TextOverflow.ellipsis,
  );

  var _txtStyleSub = TextStyle(
    color: Colors.black26,
    fontFamily: "Sofia",
    fontSize: 12.5,
    fontWeight: FontWeight.w600,
    overflow: TextOverflow.ellipsis,
  );

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          height: 50.0,
          width: double.infinity,
          color: Colors.white,
        ),
        Align(
          alignment: Alignment.center,
          child: LocaleText(
            "recipe",
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Sofia",
              fontWeight: FontWeight.w700,
              fontSize: (expandedHeight / 40) - (shrinkOffset / 40) + 18,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Opacity(
          opacity: (1 - shrinkOffset / expandedHeight),
          child: Hero(
            // tag: 'hero-tag-${id + title}',
            tag: 'hero-tag-1',
            child: Material(
              color: Colors.transparent,
              child: new DecoratedBox(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    fit: BoxFit.cover,
                    // image: new NetworkImage(img),
                    image: AssetImage(this.img),
                  ),
                  shape: BoxShape.rectangle,
                ),
                child: Container(
                  margin: EdgeInsets.only(top: 620.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(0.0, 1.0),
                      stops: [0.0, 1.0],
                      colors: <Color>[
                        Color(0x00FFFFFF),
                        Color(0xFFFFFFFF),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0, left: 20.0),
              child: Container(
                height: 170.0,
                width: double.infinity,
                padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.white.withOpacity(0.85)),
                child: Center(
                  child: Text(
                    title,
                    style: _txtStyleTitle.copyWith(fontSize: 27.0),
                    overflow: TextOverflow.visible,
                    // overflow: TextOverflow.ellipsis,
                    // maxLines: 2,
                    // softWrap: true,
                  ),
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 20.0, right: 20),
                      child: Container(
                        height: 35.0,
                        width: 35.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(40.0),
                          ),
                          color: Colors.white70,
                        ),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                    ))),
            SizedBox(
              width: 36.0,
            )
          ],
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

Widget _line() {
  return Container(
    height: 0.9,
    width: double.infinity,
    color: Colors.white10,
  );
}

Widget _infoCircleIcon(IconData icons, String title, Text text) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Center(
        child: Icon(
          icons,
          size: 22.0,
          // color: colorStyle.primaryColor,
          color: colorStyle.primaryColor,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            icons == Icons.query_builder
                ? Text(
                    title,
                    style: TextStyle(
                        fontFamily: "Sofia",
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                        fontSize: 12.0),
                    textAlign: TextAlign.center,
                  )
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    // padding: EdgeInsets.all(5),
                    // decoration: BoxDecoration(
                    //   color: Colors.green,
                    //   shape: BoxShape.circle,
                    // ),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontFamily: "Sofia",
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
            text,
          ],
        ),
      ),
    ],
  );
}
