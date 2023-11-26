import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:recipe/Screen/B1_Home_Screen/Category/CategoryDetail.dart';
import 'package:recipe/Screen/B1_Home_Screen/Detail/detail_recipe.dart';
import 'package:recipe/service/ad_mob_service.dart';
import 'package:shimmer/shimmer.dart';
import 'package:recipe/Style/Style.dart';

class HomeScreenT1 extends StatefulWidget {
  // String userID;
  // HomeScreenT1({this.userID});
  late String localeCode;
  HomeScreenT1({required this.localeCode});
  @override
  _HomeScreenT1State createState() => _HomeScreenT1State(this.localeCode);
}

class _HomeScreenT1State extends State<HomeScreenT1> {
  String localeCode;
  @override
  // List<DocumentSnapshot> _image;
  _HomeScreenT1State(this.localeCode);
  bool loadData = true;
  bool loadImage = true;
  String languageCode = "";
  List _items = [], _sliderItems = [];
  @override
  void initState() {
    Timer(Duration(milliseconds: 500), () {
      setState(() {
        loadData = false;
      });
    });
    Timer(Duration(milliseconds: 500), () {
      setState(() {
        loadImage = false;
      });
    });
    readJson();

    // TODO: implement initState
    super.initState();
  }

  var _background = Stack(
    children: <Widget>[
      Image(
        image: AssetImage('assets/image/profileBackground.png'),
        height: 310.0,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
      Container(
        height: 325.0,
        margin: EdgeInsets.only(top: 0.0, bottom: 75.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(0.0, 1.0),
            // stops: [0.0, 1.0],
            colors: <Color>[
              Colors.white.withOpacity(0.1),
              Colors.white.withOpacity(0.3),
              Colors.white,
              //  Color(0xFF1E2026),
            ],
          ),
        ),
      ),
    ],
  );

  var _categories = Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[],
  );

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/da_${widget.localeCode}.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["categories"] as List;
    });
  }

  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light));

    var _search = Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child: InkWell(
          onTap: () {},
          child: Container(
            height: 45.0,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5.0,
                      spreadRadius: 0.0)
                ]),
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: <Widget>[
                      Icon(
                        EvaIcons.searchOutline,
                        color: Color(0xFFFF975D),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      LocaleText(
                        "input_placeholder",
                        style: TextStyle(
                            color: Colors.grey[400],
                            fontFamily: "Sofia",
                            fontSize: 16.0),
                      ),
                    ],
                  ),
                  Icon(
                    EvaIcons.moreHorizontalOutline,
                    color: Color(0xFFFF975D),
                  ),
                ],
              ),
            ),
          ),
        ));

    var _sliderImage = Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 190,
          aspectRatio: 24 / 18,
          viewportFraction: 0.9,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 1500),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
        items: [..._items].map(
          (i) {
            final rec = i['recipes'][Random().nextInt(i['recipes'].length)];
            return Container(
              height: 190.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                    // image: NetworkImage(
                    //   "https://firebasestorage.googleapis.com/v0/b/recipeadmin-9b5fb.appspot.com/o/chef.png?alt=media&token=fa89a098-7e68-45d6-b58d-0cfbaef189cc",
                    // ),
                    // image: AssetImage('assets/image/banner1.webp'),
                    image: AssetImage(
                        rec["image"].replaceAll("{{", "").replaceAll("}}", "")),
                    fit: BoxFit.cover),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new RecipeDetailScreen(
                        title: rec["title"],
                        // id: id,
                        image: rec["image"]
                            .replaceAll("{{", "")
                            .replaceAll("}}", ""),
                        // category: category,
                        time: rec["time"],
                        // userId: widget.userID,
                        // rating: rating,
                        calorie: rec["calorie"],
                        directions: rec["directions"],
                        ingredient: rec["ingredients"],
                        videoURI: rec["video"]["uri"]
                            .replaceAll("{{", "")
                            .replaceAll("}}", ""),
                        videoTitle: rec["title"],
                        videoDesc: rec["video"]["desc"],
                      ),

                      // pageBuilder: (_, __, ___) => new RecipeDetailScreen(),
                    ),
                  );
                },
              ),
            );
          },
        ).toList(),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.0),
        child: AppBar(
          backgroundColor: colorStyle.secondaryColor,
          elevation: 0.0,
          // brightness: Brightness.light,
        ),
      ),
      body: loadData
          ? animationLoadData()
          : SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  _background,
                  Padding(
                    padding: const EdgeInsets.only(top: 60.0),
                    child: Column(
                      children: <Widget>[
                        // _search,
                        _sliderImage,
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 30.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                LocaleText(
                                  "categories",
                                  style: TextStyle(
                                      fontFamily: "Sofia",
                                      fontSize: 18.5,
                                      color: Colors.black.withOpacity(0.9),
                                      fontWeight: FontWeight.w600),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: colorStyle.primaryColor,
                                      ),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      child: Text(
                                        _items.length.toString(),
                                        style: TextStyle(
                                            fontFamily: "Sofia",
                                            fontSize: 13.5,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    LocaleText(
                                      _items.length > 1 ? 'items' : 'item',
                                      style: TextStyle(
                                          fontFamily: "Sofia",
                                          fontSize: 13.5,
                                          color: Colors.black.withOpacity(0.9),
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                )
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10.0,
                          ),
                          child: Container(
                            height: 110.0,
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: ListView.builder(
                              itemCount: _items.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return cardPopular(
                                  image: _items[index]["image"]
                                      .replaceAll("{{", "")
                                      .replaceAll("}}", ""),
                                  title: _items[index]["title"],
                                  // userId: widget.userID,
                                  // category: _items[index]["category"],
                                  recipes: _items[index]["recipes"],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: AdMobService.createBanner(AdSize.fullBanner),
    );
  }
}

class animationLoadData extends StatelessWidget {
  @override
  final color = Colors.black38;
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 40.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Shimmer.fromColors(
            baseColor: color,
            highlightColor: Colors.white,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 40.0,
                    width: 170.0,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0)),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    height: 45.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(EvaIcons.searchOutline, color: Colors.white),
                          Icon(EvaIcons.moreHorizontalOutline,
                              color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    height: 200.0,
                    width: double.infinity,
                    color: Colors.black12,
                    alignment: Alignment.topRight,
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    height: 40.0,
                    width: 120.0,
                    color: Colors.black12,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Container(
                            height: 100.0,
                            width: MediaQuery.of(context).size.width / 3.8,
                            color: Colors.black12,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Container(
                            height: 100.0,
                            width: MediaQuery.of(context).size.width / 3.8,
                            color: Colors.black12,
                          ),
                        ),
                        Container(
                          height: 100.0,
                          width: MediaQuery.of(context).size.width / 3.8,
                          color: Colors.black12,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    height: 40.0,
                    width: 120.0,
                    color: Colors.black12,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Container(
                            height: 100.0,
                            width: MediaQuery.of(context).size.width / 2.5,
                            color: Colors.black12,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Container(
                            height: 100.0,
                            width: MediaQuery.of(context).size.width / 2.5,
                            color: Colors.black12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}

class cardPopular extends StatelessWidget {
  // String image, title, userId, category;
  String image, title;
  List recipes;
  cardPopular(
      {required this.title,
      required this.image,
      // required this.userId,
      required this.recipes});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 4.0, top: 3.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder(
                // new categoryDetail(
                //       title: title, userId: userId, category: category),
                pageBuilder: (_, __, ___) =>
                    new categoryDetail(title: title, recipes: this.recipes),
                transitionDuration: Duration(milliseconds: 500),
                transitionsBuilder:
                    (_, Animation<double> animation, __, Widget child) {
                  return Opacity(
                    opacity: animation.value,
                    child: child,
                  );
                }),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 98.0,
              width: 99.0,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12.withOpacity(0.04),
                      blurRadius: 3.0,
                      spreadRadius: 1.0)
                ],
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        image,
                        height: 45,
                        width: 45,
                        colorBlendMode: BlendMode.darken,
                      )),
                  SizedBox(
                    height: 7.0,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Sofia",
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
