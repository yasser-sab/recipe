import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:recipe/Screen/BottomNavBar/BottomNavBar.dart';
import 'package:recipe/Screen/Settings/Bloc.dart';
import 'package:recipe/Style/Style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  ThemeBloc themeBloc;
  String localeCode;

  OnboardingScreen({required this.themeBloc, required this.localeCode});
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState(themeBloc);
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  ThemeBloc themeBloc;
  _OnboardingScreenState(this.themeBloc);
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 5.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? colorStyle.secondaryColor : Colors.black12,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;

    var _textH1 = TextStyle(
        fontFamily: "Sofia",
        fontWeight: FontWeight.w600,
        fontSize: 23.0,
        color: Colors.black);

    var _textH2 = TextStyle(
        fontFamily: "Sofia",
        fontWeight: FontWeight.w200,
        fontSize: 16.0,
        color: Colors.black);

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                child: PageView(
                  physics: ClampingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Image(
                          image: AssetImage('assets/image/banner1.webp'),
                          height: 400.0,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(top: 0.0, bottom: _height / 3.8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: FractionalOffset(0.0, 0.0),
                              end: FractionalOffset(0.0, 1.0),
                              // stops: [0.0, 1.0],
                              colors: <Color>[
                                Colors.white.withOpacity(0.1),
                                Colors.white.withOpacity(0.1),
                                Colors.white.withOpacity(0.01),
                                Colors.white,
                                Colors.white,
                                // Color(0xFF1E2026).withOpacity(0.1),
                                // Color(0xFF1E2026).withOpacity(0.3),
                                // Color(0xFF1E2026),
                                // Color(0xFF1E2026),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: FractionalOffset.center,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 245.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                LocaleText(
                                  'onboarding1_title',
                                  style: _textH1,
                                ),
                                SizedBox(height: 35.0),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0),
                                  child: LocaleText(
                                    'onboarding1_desc',
                                    textAlign: TextAlign.center,
                                    style: _textH2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: <Widget>[
                        Image(
                          image: AssetImage('assets/image/banner2.webp'),
                          height: 400.0,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(top: 0.0, bottom: _height / 3.8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: FractionalOffset(0.0, 0.0),
                              end: FractionalOffset(0.0, 1.0),
                              // stops: [0.0, 1.0],
                              colors: <Color>[
                                Colors.white.withOpacity(0.1),
                                Colors.white.withOpacity(0.1),
                                Colors.white.withOpacity(0.01),
                                Colors.white,
                                Colors.white,
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: FractionalOffset.center,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 245.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                LocaleText(
                                  'onboarding2_title',
                                  style: _textH1,
                                ),
                                SizedBox(height: 35.0),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0),
                                  child: LocaleText(
                                    'onboarding2_desc',
                                    textAlign: TextAlign.center,
                                    style: _textH2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: <Widget>[
                        Image(
                          image: AssetImage('assets/image/banner3.webp'),
                          height: 400.0,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(top: 0.0, bottom: _height / 3.8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: FractionalOffset(0.0, 0.0),
                              end: FractionalOffset(0.0, 1.0),
                              // stops: [0.0, 1.0],
                              colors: <Color>[
                                Colors.white.withOpacity(0.1),
                                Colors.white.withOpacity(0.1),
                                Colors.white.withOpacity(0.01),
                                Colors.white,
                                Colors.white,
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: FractionalOffset.center,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 245.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                LocaleText(
                                  "onboarding3_title",
                                  style: _textH1,
                                ),
                                SizedBox(height: 35.0),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0),
                                  child: LocaleText(
                                    'onboarding3_desc',
                                    textAlign: TextAlign.center,
                                    style: _textH2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Align(
                alignment: FractionalOffset.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 470.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator(),
                  ),
                ),
              ),
              _currentPage != _numPages - 1
                  ? Align(
                      alignment: FractionalOffset.bottomRight,
                      child: TextButton(
                          onPressed: () {
                            _pageController.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Container(
                              height: 50.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                color: colorStyle.primaryColor,
                                border: Border.all(
                                  color: colorStyle.primaryColor,
                                ),
                              ),
                              child: Center(
                                  child: LocaleText(
                                "button2",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Sofia",
                                    letterSpacing: 1.5),
                              )),
                            ),
                          )),
                    )
                  : Text(''),
            ],
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? InkWell(
              onTap: () async {
                // Navigator.of(context).pushReplacement(PageRouteBuilder(
                //     pageBuilder: (_, __, ___) =>
                //         new chooseLogin(themeBloc: themeBloc)));
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('isRegistred', true);
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => new BottomNavBar(
                      themeBloc: themeBloc,
                      localeCode: widget.localeCode,
                    ),
                  ),
                );
                // Navigator.of(context).pushReplacement(
                //   PageRouteBuilder(
                //     pageBuilder: (_, __, ___) => new SignUp(
                //         // localeCode: "",
                //         ),
                //   ),
                // );
              },
              child: Container(
                height: 60.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Colors.white,
                      colorStyle.primaryColor,
                    ],
                  ),
                ),
                child: Center(
                  child: LocaleText(
                    'button',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19.0,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
              ),
            )
          : Text(''),
    );
  }
}
