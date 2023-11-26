import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:recipe/Style/Style.dart';
import 'package:recipe/service/ad_mob_service.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class detailVideo extends StatefulWidget {
  // String videoId;
  String title, url, desc;
  // detailVideo({this.videoId: 'https://www.youtube.com/watch?v=YMx8Bbev6T4'});
  detailVideo({required this.title, required this.url, required this.desc});

  @override
  _detailVideoState createState() =>
      _detailVideoState(this.title, this.url, this.desc);
}

class _detailVideoState extends State<detailVideo> {
  _detailVideoState(String title, String url, String desc);
  @override
  // String videoId;
  // String videoURI = 'https://www.youtube.com/watch?v=YMx8Bbev6T4';
  late final videoId;
  late InterstitialAd _interstitial;
  bool isLoaded = false;

  // _detailVideoState(this.videoURI);
  late YoutubePlayerController _controller;
  @override
  void initState() {
    videoId = YoutubePlayer.convertUrlToId(widget.url);
    _controller = YoutubePlayerController(
      initialVideoId: this.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        forceHD: false,
        enableCaption: false,
        controlsVisibleAtStart: true,
        disableDragSeek: false,
        hideControls: false,
        hideThumbnail: false,
        isLive: false,
        loop: false,
      ),
    );
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
    // inter = AdMobService.createInterstitial();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: LocaleText(
          "videos",
          style: TextStyle(
            fontFamily: "Sofia",
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                onEnded: (frame) {
                  // Navigator.of(context).pop();
                  if (isLoaded) {
                    _interstitial.show();
                  }
                },
                bottomActions: [
                  CurrentPosition(),
                  ProgressBar(
                    isExpanded: true,
                    colors: ProgressBarColors(
                      playedColor: colorStyle.primaryColor,
                      handleColor: colorStyle.primaryColor.withOpacity(0.7),
                    ),
                  ),
                  RemainingDuration(),
                  PlaybackSpeedButton(),
                  // FullScreenButton(
                  //       controller: _controller,
                  //       color: Colors.blueAccent
                  //     )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  widget.title,
                  style: TextStyle(
                      fontFamily: "Sofia",
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontSize: 25.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  widget.desc,
                  style: TextStyle(
                      fontFamily: "Sofia",
                      fontWeight: FontWeight.w700,
                      color: Colors.grey.shade500,
                      fontSize: 15.0),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AdMobService.createBanner(AdSize.fullBanner),
    );
  }
}
