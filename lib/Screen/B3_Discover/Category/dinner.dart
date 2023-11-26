import 'dart:async';
import 'package:flutter/material.dart';
import 'package:recipe/Widget/Page_Transformer_Card/page_transformer.dart';
import 'package:shimmer/shimmer.dart';

class DinnerDiscover extends StatefulWidget {
  // String idUser;
  // DinnerDiscover({this.idUser});
  DinnerDiscover();

  _DinnerDiscoverState createState() => _DinnerDiscoverState();
}

class _DinnerDiscoverState extends State<DinnerDiscover> {
  ///
  /// Get image data dummy from firebase server
  ///
  // var imageNetwork = NetworkImage(
  //     "https://firebasestorage.googleapis.com/v0/b/beauty-look.appspot.com/o/Artboard%203.png?alt=media&token=dc7f4bf5-8f80-4f38-bb63-87aed9d59b95");

  ///
  /// check the condition is right or wrong for image loaded or no
  ///
  bool loadImage = true;

  @override
  void initState() {
    Timer(Duration(milliseconds: 1500), () {
      setState(() {
        loadImage = false;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    // return _loadingDataHeader(context);
    // return new dataFirestore();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 0.0),
                  child:
                      loadImage ? _loadingDataHeader(context) : dataFirestore(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

///
///
/// Calling imageLoading animation for set a grid layout
///
///

Widget _loadingDataHeader(BuildContext context) {
  double _height = MediaQuery.of(context).size.height;
  return SizedBox.fromSize(
    size: Size.fromHeight(_height / 1.45),
    child: cardHeaderLoading(context),
  );
}

Widget cardHeaderLoading(BuildContext context) {
  double _height = MediaQuery.of(context).size.height;
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: _height / 1.45,
      width: 275.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Colors.grey[500],
          boxShadow: [
            BoxShadow(
                color: Colors.black12.withOpacity(0.1),
                spreadRadius: 0.2,
                blurRadius: 0.5)
          ]),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade400,
        highlightColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 320.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                height: 25.0,
              ),
              Container(
                height: 20.0,
                width: 190.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 20.0,
                width: 270.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 20.0,
                width: 190.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
              ),
              SizedBox(
                height: 30.0,
              )
            ],
          ),
        ),
      ),
    ),
  );
}

class dataFirestore extends StatelessWidget {
  // String dataUser;
  // dataFirestore({this.list, this.dataUser});
  dataFirestore();
  // final List<DocumentSnapshot> list;
  late PageVisibility pageVisibility;

  Widget _applyTextEffects({
    required double translationFactor,
    required Widget child,
  }) {
    final double xTranslation = pageVisibility.pagePosition * translationFactor;

    return Opacity(
      opacity: pageVisibility.visibleFraction,
      child: Transform(
        alignment: FractionalOffset.topLeft,
        transform: Matrix4.translationValues(
          xTranslation,
          0.0,
          0.0,
        ),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
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
    return SizedBox.fromSize(
      size: Size.fromHeight(_height / 1.45),
      child: ListView.builder(
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Hero(
                // tag: 'hero-tag-${id + title}',
                tag: 'hero-tag-' + index.toString(),
                child: Material(
                  child: Container(
                    height: 500.0,
                    width: 275.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        color: Colors.grey[500],
                        image: DecorationImage(
                          // image: NetworkImage(image),
                          image:
                              AssetImage('assets/image/splashBackground.png'),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12.withOpacity(0.1),
                              spreadRadius: 0.2,
                              blurRadius: 0.5)
                        ]),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        gradient: LinearGradient(
                          begin: FractionalOffset.bottomCenter,
                          end: FractionalOffset.topCenter,
                          colors: [
                            const Color(0xFF000000),
                            const Color(0x00000000),
                          ],
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          print("recipe" + index.toString());
                        },
                        child: Stack(
                          children: <Widget>[
                            imageOverlayGradient,
                            Positioned(
                              bottom: 0.0,
                              left: 0.0,
                              right: 0.0,
                              child: Container(
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.2,
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
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 4.0,
                                                ),
                                                Text(
                                                  "time",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: "Sofia",
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w300),
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
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                  "calorie",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: "Sofia",
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 16.0),
                                        child: Text(
                                          "title",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
