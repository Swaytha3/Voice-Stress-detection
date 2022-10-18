import 'package:flutter/material.dart';
import 'package:relax/my_theme.dart';
import 'package:relax/screen/other/settings.dart';
import 'package:relax/uisections/drawer.dart';

class Home extends StatefulWidget {
  Home({Key? key, this.title, this.showBackButton = false}) : super(key: key);

  final String? title;
  bool showBackButton;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _currentSlider = 0;
  ScrollController? _featuredProductScrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // In initState()
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: buildAppBar(statusBarHeight, context),
      drawer: MainDrawer(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              Container(),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(
              //     8.0,
              //     16.0,
              //     8.0,
              //     0.0,
              //   ),
              //   child: buildHomeCarouselSlider(context),
              // ),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(
              //     8.0,
              //     16.0,
              //     8.0,
              //     0.0,
              //   ),
              //   child: buildHomeMenuRow(context),
              // ),
          //   ]),
          // ),
          // SliverList(
          //   delegate: SliverChildListDelegate([
          //     Padding(
          //       padding: const EdgeInsets.fromLTRB(
          //         16.0,
          //         16.0,
          //         8.0,
          //         0.0,
          //       ),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             "Featured Categories",
          //             style: TextStyle(
          //               fontSize: 16,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ]),
          // ),
          // SliverToBoxAdapter(
          //   child: Padding(
          //     padding: const EdgeInsets.fromLTRB(
          //       16.0,
          //       16.0,
          //       0.0,
          //       0.0,
          //     ),
          //     child: SizedBox(
          //       height: 154,
          //       child: buildHomeFeaturedCategories(context),
          //     ),
          //   ),
          // ),
          // SliverList(
          //   delegate: SliverChildListDelegate([
          //     Padding(
          //       padding: const EdgeInsets.fromLTRB(
          //         16.0,
          //         16.0,
          //         8.0,
          //         0.0,
          //       ),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             "Featured Products",
          //             style: TextStyle(fontSize: 16),
          //           ),
          //         ],
          //       ),
          //     ),
              // SingleChildScrollView(
              //   child: Column(
              //     children: [
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(
                    //     4.0,
                    //     16.0,
                    //     8.0,
                    //     0.0,
                    //   ),
                    //   child: buildHomeFeaturedProducts(context),
                    // ),
              //     ],
              //   ),
              // ),
              Container(
                height: 80,
              )
            ]),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar(double statusBarHeight, BuildContext context) {
    return AppBar(
      backgroundColor : Colors.white,
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
