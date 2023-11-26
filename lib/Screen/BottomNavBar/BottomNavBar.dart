import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:recipe/Screen/B1_Home_Screen/B1_HomeScreen.dart';
import 'package:recipe/Screen/B3_Favorite_Screen/B3_Favorite_Screen.dart';
import 'package:recipe/Screen/B4_Profile_Screen/aboutApps.dart';
import 'package:recipe/Screen/BottomNavBar/NavBarItem.dart';
import 'package:recipe/Screen/Settings/Bloc.dart';
import 'package:recipe/Style/Style.dart';

class BottomNavBar extends StatefulWidget {
  // String idUser;
  late ThemeBloc themeBloc;
  final String localeCode;
  // BottomNavBar({this.idUser, this.themeBloc});
  BottomNavBar({required this.themeBloc, required this.localeCode});
  createState() => _BottomNavBarState(themeBloc, this.localeCode);
  // createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  ThemeBloc themeBloc;
  String localeCode;
  _BottomNavBarState(this.themeBloc, this.localeCode);
  // String barcode = '';
  // Uint8List bytes = Uint8List(200);
  late BottomNavBarBloc _bottomNavBarBloc;
  @override
  void initState() {
    super.initState();
    _bottomNavBarBloc = BottomNavBarBloc();
    // barcode = '';
  }

  @override
  void dispose() {
    _bottomNavBarBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorStyle.whiteBackground,
      body: StreamBuilder<NavBarItem>(
        stream: _bottomNavBarBloc.itemStream,
        initialData: _bottomNavBarBloc.defaultItem,
        builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
          switch (snapshot.data) {
            case NavBarItem.HOME:
              return HomeScreenT1(
                // userID: widget.idUser,
                localeCode: widget.localeCode,
              );

            case NavBarItem.FAVORITE:
              return favoriteScreen(
                  // idUser: widget.idUser,
                  );
            case NavBarItem.ABOUTAPP:
              return aboutApps();
            case NavBarItem.VIDEO:
            // return B2Playlist(
            //     // idUser: widget.idUser,
            //     );
            case NavBarItem.USERS:
            // return B4ProfileScreen(
            //   idUser: widget.idUser,
            // );)
            case NavBarItem.DISCOVER:
            // return discover(
            //     // userId: widget.idUser,
            //     );
          }
          print(snapshot.data);
          return Container();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: StreamBuilder(
        stream: _bottomNavBarBloc.itemStream,
        initialData: _bottomNavBarBloc.defaultItem,
        builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
          return BottomNavigationBar(
            selectedFontSize: 10.0,
            unselectedFontSize: 10.0,
            selectedItemColor: colorStyle.primaryColor,
            unselectedItemColor: colorStyle.iconColorUnselecLight,
            backgroundColor: colorStyle.whiteBackground,
            type: BottomNavigationBarType.fixed,
            iconSize: 25.0,
            // currentIndex: snapshot.data.index,
            currentIndex: _bottomNavBarBloc.selectedIndex,
            onTap: _bottomNavBarBloc.pickItem,
            items: [
              BottomNavigationBarItem(
                // label: 'home',
                label: '',
                icon: Icon(
                  EvaIcons.homeOutline,
                ),
                activeIcon: Icon(
                  Icons.home,
                ),
              ),
              BottomNavigationBarItem(
                // label: 'Favorite',
                label: '',
                icon: Icon(
                  EvaIcons.heartOutline,
                ),
                activeIcon: Icon(
                  EvaIcons.heart,
                ),
              ),
              BottomNavigationBarItem(
                // label: 'About app',
                label: '',
                icon: Icon(
                  EvaIcons.questionMarkCircleOutline,
                ),
                activeIcon: Icon(
                  EvaIcons.questionMark,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
