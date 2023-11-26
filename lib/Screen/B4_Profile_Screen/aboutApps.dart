import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:recipe/Style/Style.dart';

class aboutApps extends StatefulWidget {
  @override
  _aboutAppsState createState() => _aboutAppsState();
}

class _aboutAppsState extends State<aboutApps> {
  @override
  static var _txtCustomHead = TextStyle(
    color: Colors.black54,
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    fontFamily: "Gotik",
  );

  static var _txtCustomSub = TextStyle(
    color: Colors.black38,
    fontSize: 15.0,
    fontWeight: FontWeight.w500,
    fontFamily: "Gotik",
  );

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: LocaleText(
          "about",
          style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 15.0,
              color: Colors.white,
              fontFamily: "Gotik"),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: colorStyle.primaryColor),
        elevation: 0.0,
        backgroundColor: colorStyle.secondaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              // Padding(
              //   padding: const EdgeInsets.all(20.0),
              //   child: Divider(
              //     height: 0.5,
              //     color: Colors.black12,
              //   ),
              // ),

              Container(
                margin: EdgeInsets.only(top: 30),
                padding: EdgeInsets.only(left: 15.0, right: 15),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          LocaleText(
                            "recipe",
                            style: _txtCustomHead.copyWith(
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(20.0),
              //   child: Divider(
              //     height: 0.5,
              //     color: Colors.black12,
              //   ),
              // ),

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: LocaleText(
                  "recipe_desc",
                  style: _txtCustomSub,
                  textAlign: TextAlign.justify,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class category extends StatelessWidget {
  @override
  String txt, image;
  // GestureTapCallback tap;
  double padding;

  // category({this.txt, this.image, this.tap, this.padding});
  category({this.txt: "", this.image: "", this.padding: 0});

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: padding),
                    child: Image.asset(
                      image,
                      height: 25.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(
                      txt,
                      style: TextStyle(
                        fontSize: 14.5,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Sofia",
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black26,
                  size: 15.0,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Divider(
          color: Colors.black12,
        )
      ],
    );
  }
}
