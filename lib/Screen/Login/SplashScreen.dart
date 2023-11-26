import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipe/Screen/BottomNavBar/BottomNavBar.dart';
import 'package:recipe/Screen/Login/OnBoarding.dart';
import 'package:recipe/Screen/Settings/Bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_locales/flutter_locales.dart';

class Splash extends StatefulWidget {
  // Splash({required Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late ThemeBloc _themeBloc;

  /// Create _themeBloc for double theme (Dark and White themse)

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _themeBloc = ThemeBloc();
    test();
  }

  void test() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Locales.init([
      'fr',
      'en',
      'ar',
      'af',
      "sq",
      "am",
      "hy",
      "as",
      "ay",
      "az",
      "bm",
      "eu",
      "be",
      "bn",
      "bho",
      "bs",
      "bg",
      "ca",
      "ceb",
      "zh-CN",
      "zh-TW",
      "co",
      "hr",
      "cs",
      "da",
      "dv",
      "doi",
      "nl",
      "eo",
      "et",
      "ee",
      "fil",
      "fi",
      "fy",
      "gl",
      "ka",
      "de",
      "el",
      "gn",
      "gu",
      "ht",
      "ha",
      "haw",
      "he",
      "hi",
      "hmn",
      "hu",
      "is",
      "ig",
      "ilo",
      "id",
      "ga",
      "it",
      "ja",
      "jv",
      "kn",
      "kk",
      "km",
      "rw",
      "gom",
      "ko",
      "kri",
      "ku",
      "ckb",
      "ky",
      "lo",
      "la",
      "lv",
      "ln",
      "lt",
      "lg",
      "lb",
      "mk",
      "mai",
      "mg",
      "ms",
      "ml",
      "mt",
      "mi",
      "mr",
      "mni-Mtei",
      "lus",
      "mn",
      "my",
      "ne",
      "no",
      "ny",
      "or",
      "om",
      "ps",
      "fa",
      "pl",
      "pt",
      "pa",
      "qu",
      "ro",
      "ru",
      "sm",
      "sa",
      "gd",
      "nso",
      "sr",
      "st",
      "sn",
      "sd",
      "si",
      "sk",
      "sl",
      "so",
      "es",
      "su",
      "sw",
      "sv",
      "tl",
      "tg",
      "ta",
      "tt",
      "te",
      "th",
      "ti",
      "ts",
      "tr",
      "tk",
      "ak",
      "uk",
      "ur",
      "ug",
      "uz",
      "vi",
      "cy",
      "xh",
      "yi",
      "yo",
      "zu"
    ]);

    final directory = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(directory.path);

    MobileAds.instance.initialize();
  }

  @override
  Widget build(BuildContext context) {
    ///Set color status bar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
    ));

    /// To set orientation always portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
// Locale('ru', 'RU')
    return LocaleBuilder(
      builder: (locale) => MaterialApp(
        localizationsDelegates: Locales.delegates,
        supportedLocales: Locales.supportedLocales,
        locale: locale,
        title: 'slowfood',
        debugShowCheckedModeBanner: false,
        home: SplashScreen(
          themeBloc: _themeBloc,
        ),
        theme: ThemeData(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          primaryColorLight: Colors.white,
          // primaryColorBrightness: Brightness.light,
          primaryColor: Colors.white,
        ),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  ThemeBloc themeBloc;
  SplashScreen({required this.themeBloc});
  @override
  _SplashScreenState createState() => _SplashScreenState(themeBloc);
}

class _SplashScreenState extends State<SplashScreen> {
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/image/splashBackground.jpeg"),
                      fit: BoxFit.cover)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Align(
                alignment: Alignment.center,
                child: LocaleText(
                  'recipe',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Lemon",
                    fontSize: 50.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ThemeBloc themeBloc;
  _SplashScreenState(this.themeBloc);

  @override
  void initState() {
    super.initState();
    isRegister();
    _navigateToBottomNavBar();

    ///
    /// Check connectivity
    ///
  }

  bool isRegistred = false;
  isRegister() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setBool('isRegistred', false);

    if (prefs.getBool('isRegistred') == true) {
      isRegistred = true;
    } else {
      isRegistred = false;
    }
    // return prefs.getBool('isRegistred') ?? false;
  }

  _navigateToBottomNavBar() async {
    await Future.delayed(Duration(milliseconds: 2000), () {
      if (!isRegistred) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OnboardingScreen(
              themeBloc: themeBloc,
              localeCode: Localizations.localeOf(this.context).languageCode,
            ),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNavBar(
              themeBloc: themeBloc,
              localeCode: Localizations.localeOf(this.context).languageCode,
            ),
          ),
        );
      }
    });
  }
}
