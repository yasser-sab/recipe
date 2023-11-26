import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:recipe/Screen/B1_Home_Screen/Detail/detail_recipe.dart';
import 'package:recipe/Style/Style.dart';
import 'package:recipe/service/ad_mob_service.dart';

class categoryDetail extends StatefulWidget {
  // String userId, title, category;
  String title;
  List recipes;
  // categoryDetail({this.userId, this.title, this.category});
  categoryDetail({required this.title, required this.recipes});

  @override
  _categoryDetailState createState() => _categoryDetailState();
}

class _categoryDetailState extends State<categoryDetail> {
  @override
  bool loadData = true;
  @override
  void initState() {
    Timer(Duration(milliseconds: 1500), () {
      setState(() {
        loadData = false;
      });
    });

    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: colorStyle.secondaryColor,
        title: Text(
          widget.title,
          style: TextStyle(
              fontFamily: "Sofia", fontSize: 19.0, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: InkWell(
                onTap: () {},
                child: Container(
                  height: 40.0,
                  margin: EdgeInsets.only(top: 20),
                  alignment: AlignmentDirectional.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Color(0xFFF7F7FA),
                  ),
                  padding: EdgeInsets.only(
                      left: 20.0, right: 30.0, top: 0.0, bottom: 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.search,
                            color: colorStyle.primaryColor,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          LocaleText(
                            'input_placeholder',
                            style: TextStyle(
                                color: Colors.grey[400],
                                fontFamily: "Sofia",
                                fontSize: 16.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            cardDinner(recipes: widget.recipes),
            SizedBox(
              height: 15.0,
            )
          ],
        ),
      ),
      bottomNavigationBar: AdMobService.createBanner(AdSize.fullBanner),
    );
  }
}

class cardDinner extends StatelessWidget {
  List recipes;
  cardDinner({required this.recipes});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      primary: false,
      // separatorBuilder: (context, index) {
      //   if (index % 3 == 0) {
      //     return Padding(
      //       padding: EdgeInsets.symmetric(vertical: 15),
      //       child: AdMobService.createBanner(AdSize.banner),
      //     );
      //   }
      //   return Container();
      // },
      itemBuilder: (context, i) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => new RecipeDetailScreen(
                  title: recipes[i]['title'],
                  // id: id,
                  image: recipes[i]['image']
                      .replaceAll("{{", "")
                      .replaceAll("}}", ""),
                  // category: 'category 1',
                  time: recipes[i]['time'],
                  // userId: dataUser,
                  // rating: rating,
                  calorie: recipes[i]['calorie'],
                  directions: recipes[i]['directions'],
                  ingredient: recipes[i]['ingredients'],
                  videoURI: recipes[i]['video']['uri']
                      .replaceAll("{{", "")
                      .replaceAll("}}", ""),
                  videoTitle: recipes[i]['title'],
                  videoDesc: recipes[i]['video']['desc'],
                  // video: 'video',
                ),
                transitionDuration: Duration(milliseconds: 1000),
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
            padding: const EdgeInsets.only(top: 10.0, left: 15.0, right: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Hero(
                  // tag: 'hero-tag-${id + title}',
                  tag: 'hero-tag-' + i.toString(),
                  child: Material(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Color(0xFF1E2026),
                    child: Container(
                      height: 110.0,
                      width: 110.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          // image: NetworkImage(image),
                          image: AssetImage(recipes[i]["image"]
                              .replaceAll("{{", "")
                              .replaceAll("}}", "")),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(blurRadius: 0.0, color: Colors.black87)
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        gradient: LinearGradient(
                            colors: [
                              Color(0xFF1E2026),
                              Color(0xFF23252E),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, top: 19.0, right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 200.0,
                        child: Text(
                          recipes[i]["title"],
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Sofia",
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(
                        height: 2.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Icon(
                                  Icons.query_builder,
                                  size: 19.0,
                                  color: Colors.black26,
                                ),
                                SizedBox(
                                  width: 4.0,
                                ),
                                Text(
                                  recipes[i]["time"],
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontFamily: "Sofia",
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w300),
                                ),
                                SizedBox(
                                  width: 4.0,
                                ),
                                // LocaleText(
                                //   "min",
                                //   style: TextStyle(
                                //       color: Colors.black45,
                                //       fontFamily: "Sofia",
                                //       fontSize: 15.0,
                                //       fontWeight: FontWeight.w300),
                                // ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Icon(
                                  Icons.whatshot,
                                  size: 19.0,
                                  color: Colors.black26,
                                ),
                                Text(
                                  recipes[i]["calorie"],
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontFamily: "Sofia",
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: recipes.length,
    );
  }
}
