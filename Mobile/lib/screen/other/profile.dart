import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:relax/my_theme.dart';
import 'package:relax/screen/other/settings.dart';
import 'package:relax/uisections/drawer.dart';

class Profile extends StatefulWidget {
  Profile({Key? key, this.showBackButton = false}) : super(key: key);

  bool showBackButton;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _currentSlider = 0;
  ScrollController? _featuredProductScrollController;

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: buildAppBar(statusBarHeight, context),
        drawer: MainDrawer(),
        backgroundColor: MyTheme.bgColorScreen,
        body: Stack(
          children: <Widget>[
            Column(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/imgs/bg-profile.png"),
                              fit: BoxFit.cover)),
                      child: Stack(
                        children: <Widget>[
                          SafeArea(
                            bottom: false,
                            right: false,
                            left: false,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 0, right: 0),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/imgs/profile-img.jpg"),
                                      radius: 65.0),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 24.0),
                                    child: Text("Ryan Scheinder",
                                        style: TextStyle(
                                            color: MyTheme.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 22)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text("Photographer",
                                        style: TextStyle(
                                            color: MyTheme.white
                                                .withOpacity(0.85),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 24.0, left: 42, right: 32),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        // Column(
                                        //   crossAxisAlignment:
                                        //       CrossAxisAlignment.center,
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.center,
                                        //   children: [
                                        //     Text("2K",
                                        //         style: TextStyle(
                                        //             color: MyTheme.white,
                                        //             fontSize: 16.0,
                                        //             fontWeight:
                                        //                 FontWeight.bold)),
                                        //     Text("Friends",
                                        //         style: TextStyle(
                                        //             color: MyTheme.white
                                        //                 .withOpacity(0.8),
                                        //             fontSize: 12.0))
                                        //   ],
                                        // ),
                                        // Column(
                                        //   crossAxisAlignment:
                                        //       CrossAxisAlignment.center,
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.center,
                                        //   children: [
                                        //     Text("26",
                                        //         style: TextStyle(
                                        //             color: MyTheme.white,
                                        //             fontSize: 16.0,
                                        //             fontWeight:
                                        //                 FontWeight.bold)),
                                        //     Text("Comments",
                                        //         style: TextStyle(
                                        //             color: MyTheme.white
                                        //                 .withOpacity(0.8),
                                        //             fontSize: 12.0))
                                        //   ],
                                        // ),
                                        // Column(
                                          // crossAxisAlignment:
                                          //     CrossAxisAlignment.center,
                                          // mainAxisAlignment:
                                          //     MainAxisAlignment.center,
                                          // children: [
                                          //   Text("48",
                                          //       style: TextStyle(
                                          //           color: MyTheme.white,
                                          //           fontSize: 16.0,
                                          //           fontWeight:
                                          //               FontWeight.bold)),
                                          //   Text("Bookmarks",
                                          //       style: TextStyle(
                                          //           color: MyTheme.white
                                          //               .withOpacity(0.8),
                                          //           fontSize: 12.0))
                                          // ],
                                        // )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      )),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                      child: SingleChildScrollView(
                          child: Padding(
                    padding: const EdgeInsets.only(
                        left: 32.0, right: 32.0, top: 42.0),
                    child: Column(children: [
                      Text("About me",
                          style: TextStyle(
                              color: MyTheme.text,
                              fontWeight: FontWeight.w600,
                              fontSize: 17.0)),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 24.0, right: 24, top: 30, bottom: 24),
                        child: Text(
                            "An artist of considerable range, Ryan - the name taken by Meblourne-raised, Brooklyn-based Nick Murphy - writes, performs and records all of his own music.",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: MyTheme.time)),
                      ),
                      // PhotoAlbum(imgArray: imgArray)
                    ]),
                  ))),
                ),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(left: 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.only(right: 8.0),
                    //   child: ElevatedButton(
                    //     textColor: MyTheme.white,
                    //     color: MyTheme.info,
                    //     onPressed: () {
                    //       // Respond to button press
                    //       Navigator.pushReplacementNamed(context, '/home');
                    //     },
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(32.0),
                    //     ),
                    //     child: Padding(
                    //         padding: EdgeInsets.only(
                    //             left: 12.0, right: 12.0, top: 10, bottom: 10),
                    //         child: Text("Follow",
                    //             style: TextStyle(fontSize: 13.0))),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: RawMaterialButton(
                        constraints: BoxConstraints.tight(Size(38, 38)),
                        onPressed: () {},
                        elevation: 4.0,
                        fillColor: MyTheme.defaultColor,
                        child: Icon(FontAwesomeIcons.twitter,
                            size: 14.0, color: Colors.white),
                        padding: EdgeInsets.all(0.0),
                        shape: CircleBorder(),
                      ),
                    ),
                    RawMaterialButton(
                      constraints: BoxConstraints.tight(Size(38, 38)),
                      onPressed: () {},
                      elevation: 4.0,
                      fillColor: MyTheme.defaultColor,
                      child: Icon(FontAwesomeIcons.pinterest,
                          size: 14.0, color: Colors.white),
                      padding: EdgeInsets.all(0.0),
                      shape: CircleBorder(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  AppBar buildAppBar(double statusBarHeight, BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: GestureDetector(
        onTap: () {
          _scaffoldKey.currentState?.openDrawer();
        },
        child: widget.showBackButton
            ? Builder(
                builder: (context) => IconButton(
                  icon: Icon(Icons.arrow_back, color: MyTheme.dark_grey),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              )
            : Builder(
                builder: (context) => Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 18.0, horizontal: 0.0),
                  child: Container(
                    child: Image.asset(
                      'assets/icons/hamburger.png',
                      height: 16,
                      //color: MyTheme.dark_grey,
                      color: MyTheme.dark_grey,
                    ),
                  ),
                ),
              ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            //  margin: const EdgeInsets.only(left: 75),
            child: Image.asset(
              'assets/logo/appbar_icon.png',
              fit: BoxFit.fitWidth,
              height: 40,
            ),
          )
        ],
      ),
      elevation: 0.0,
      titleSpacing: 0,
      actions: <Widget>[
        InkWell(
          onTap: () {
            // ToastComponent.showDialog("Coming soon", context,
            //     gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
          },
          child: Visibility(
            visible: false,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 18.0, horizontal: 12.0),
              child: Image.asset(
                'assets/bell.png',
                height: 16,
                color: MyTheme.dark_grey,
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Settings();
            }));
          },
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            child: Icon(
              Icons.settings,
              color: MyTheme.accent_color,
            ),
          ),
        ),
      ],
    );
  }
}
