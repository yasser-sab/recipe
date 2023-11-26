import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipe/Screen/B1_Home_Screen/Detail/detail_recipe.dart';
import 'package:recipe/Style/Style.dart';
import 'package:recipe/service/ad_mob_service.dart';
import 'package:shimmer/shimmer.dart';

class favoriteScreen extends StatefulWidget {
  // String idUser;
  // favoriteScreen({this.idUser});
  favoriteScreen();

  @override
  _favoriteScreenState createState() => _favoriteScreenState();
}

class _favoriteScreenState extends State<favoriteScreen> {
  ///
  /// check the condition is right or wrong for image loaded or no
  ///
  bool loadImage = true;

  @override
  void initState() {
    Timer(Duration(milliseconds: 500), () {
      setState(() {
        loadImage = false;
      });
    });

    // _function();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0.0,
        title: Padding(
          padding: const EdgeInsets.only(top: 25.0, left: 5.0),
          child: LocaleText(
            "favorite_recipe",
            style: TextStyle(
                fontFamily: "Sofia",
                fontSize: 29.0,
                fontWeight: FontWeight.w800,
                color: Colors.black),
          ),
        ),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 30.0, bottom: 0.0),
              child:
                  loadImage == true ? _loadingDataList(4) : new dataFirestore(),
            ),
            SizedBox(
              height: 40.0,
            )
          ],
        ),
      ),
    );
  }
}

Widget cardHeaderLoading(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 500.0,
      width: 275.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        color: Color(0xFF2C3B4F),
      ),
      child: Shimmer.fromColors(
        baseColor: Color(0xFF3B4659),
        highlightColor: Color(0xFF606B78),
        child: Padding(
          padding: const EdgeInsets.only(top: 320.0),
          child: Column(
            children: <Widget>[
              Container(
                height: 17.0,
                width: 70.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
              ),
              SizedBox(
                height: 25.0,
              ),
              Container(
                height: 20.0,
                width: 150.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 20.0,
                width: 250.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 20.0,
                width: 150.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

///
///
/// Calling imageLoading animation for set a list layout
///
///
Widget _loadingDataList(int panjang) {
  return Container(
    child: ListView.builder(
      shrinkWrap: true,
      primary: false,
      padding: EdgeInsets.only(top: 0.0),
      itemCount: panjang,
      itemBuilder: (ctx, i) {
        return loadingCard(ctx);
      },
    ),
  );
}

Widget loadingCard(BuildContext ctx) {
  return Padding(
    padding:
        const EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0, bottom: 10.0),
    child: Shimmer.fromColors(
      baseColor: Colors.black38,
      highlightColor: Colors.white,
      child: Row(children: [
        Container(
          height: 100.0,
          width: 100.0,
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.0),
                topLeft: Radius.circular(10.0)),
          ),
          alignment: Alignment.topRight,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Container(
                        width: 170.0,
                        height: 18.0,
                        color: Colors.black12,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Icon(
                        Icons.delete,
                        color: Colors.black12,
                        size: 30.0,
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 5.0)),
                  Container(
                    height: 15.0,
                    width: 100.0,
                    color: Colors.black12,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.9),
                    child: Container(
                      height: 12.0,
                      width: 140.0,
                      color: Colors.black12,
                    ),
                  )
                ],
              ),
            ),
          ],
        )
      ]),
    ),
  );
}

class dataFirestore extends StatefulWidget {
  @override
  _dataFirestoreState createState() => _dataFirestoreState();
}

class _dataFirestoreState extends State<dataFirestore> {
  List _items = [];
  Future<void> readJson() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final data =
        await json.decode(await File('$path/favorite.json').readAsString());
    setState(() {
      _items = data as List;
    });
  }

  @override
  void initState() {
    readJson();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var imageOverlayGradient = DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.bottomCenter,
          end: FractionalOffset.topCenter,
          colors: [
            const Color(0xFF000000),
            const Color(0x00000000),
            Colors.black,
            Colors.black,
            Colors.black,
            Colors.black,
          ],
        ),
      ),
    );
    return !(_items.length > 0)
        ? noItem()
        : SizedBox.fromSize(
            // size: const Size.fromHeight(410.0),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              primary: false,
              itemCount: _items.length,
              itemBuilder: (context, i) {
                late InterstitialAd _interstitial;
                bool isLoaded = false;
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
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new RecipeDetailScreen(
                          title: _items[i]["title"],
                          // id: id,
                          image: _items[i]["image"],
                          // category: category,
                          time: _items[i]["time"],
                          // userId: userId,
                          // rating: rating,
                          calorie: _items[i]["calorie"],
                          directions: _items[i]["directions"],
                          ingredient: _items[i]["ingredients"],
                          videoURI: _items[i]["video"]["uri"],
                          videoDesc: _items[i]["video"]["desc"],
                          videoTitle: _items[i]["title"],
                        ),
                        transitionDuration: Duration(milliseconds: 500),
                        transitionsBuilder:
                            (_, Animation<double> animation, __, Widget child) {
                          return Opacity(
                            opacity: animation.value,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 10.0, top: 5.0, left: 15.0, right: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Hero(
                          // tag: 'hero-tag-${id + title}',
                          tag: 'hero-tag-' + i.toString(),
                          child: Material(
                            color: Colors.transparent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            child: Container(
                              margin: EdgeInsets.only(right: 15),
                              height: 100.0,
                              width: 100.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  // image: NetworkImage(image), fit: BoxFit.cover),
                                  image: AssetImage(_items[i]["image"]),
                                  fit: BoxFit.cover,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 0.0, color: Colors.black87)
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                gradient: LinearGradient(
                                    colors: [Colors.white, Colors.white],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight),
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: 5.0,
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(left: 0.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 180.0,
                                    child: Text(
                                      _items[i]["title"],
                                      style: TextStyle(
                                          color:
                                              Colors.black87.withOpacity(0.7),
                                          fontFamily: "Sofia",
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w700),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                  // SizedBox(
                                  //   width: 4.0,
                                  // ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: InkWell(
                                      onTap: () {
                                        AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.info,
                                          dismissOnTouchOutside: true,
                                          title: "Delete this Recipe?",
                                          desc:
                                              "Are you sure you want to delete " +
                                                  _items[i]["title"],
                                          btnOkOnPress: () async {
                                            final directory =
                                                await getApplicationDocumentsDirectory();
                                            final path = directory.path;

                                            setState(() {
                                              _items.removeWhere((element) =>
                                                  element["title"] ==
                                                  _items[i]["title"]);
                                            });

                                            await File('$path/favorite.json')
                                                .writeAsString(
                                                    json.encode(_items));

                                            if (isLoaded) {
                                              _interstitial.show();
                                            }
                                          },
                                          animType: AnimType.scale,
                                        ).show();

                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: colorStyle.primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 25.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2.2,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          Icons.query_builder,
                                          size: 18.0,
                                          color: Colors.black26,
                                        ),
                                        SizedBox(
                                          width: 4.0,
                                        ),
                                        Text(
                                          _items[i]["time"],
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontFamily: "Sofia",
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          Icons.whatshot,
                                          size: 18.0,
                                          color: Colors.black26,
                                        ),
                                        Text(
                                          _items[i]["calorie"],
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontFamily: "Sofia",
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }
}

///
///
/// If no item cart this class showing
///
class noItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Container(
      width: 500.0,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: mediaQueryData.padding.top + 100.0),
            ),
            Image.asset(
              "assets/ilustration/5.png",
              height: 270.0,
            ),
            LocaleText(
              "not_found",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 19.5,
                color: Colors.black26.withOpacity(0.2),
                fontFamily: "Sofia",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
