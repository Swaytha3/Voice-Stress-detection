import 'package:flutter/material.dart';
import 'package:relax/my_theme.dart';
import 'package:relax/uisections/drawer.dart';
import 'package:relax/widgets/table-cell.dart';

class Settings extends StatefulWidget {
  Settings({Key? key, this.title, this.showBackButton = true})
      : super(key: key);

  final String? title;
  bool showBackButton;

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _currentSlider = 0;
  ScrollController? _featuredProductScrollController;

  bool? switchValueOne;
  bool? switchValueTwo;

  void initState() {
    setState(() {
      switchValueOne = true;
      switchValueTwo = false;
    });
    super.initState();
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
        appBar: buildAppBar(statusBarHeight, context),
        // Navbar(
        //   title: "Settings",
        // ),
        drawer: MainDrawer(),
        // drawer: NowDrawer(currentPage: "Settings"),
        body: Container(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 32.0, left: 16, right: 16),
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text("Recommended Settings",
                        style: TextStyle(
                            color: MyTheme.text,
                            fontWeight: FontWeight.w600,
                            fontSize: 18)),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text("These are the most important settings",
                        style: TextStyle(color: MyTheme.time, fontSize: 14)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Use FaceID to signin",
                        style: TextStyle(color: MyTheme.text)),
                    Switch.adaptive(
                      value: switchValueOne ?? false,
                      onChanged: (bool newValue) =>
                          setState(() => switchValueOne = newValue),
                      activeColor: MyTheme.primary,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Auto-Lock security",
                        style: TextStyle(color: MyTheme.text)),
                    Switch.adaptive(
                      value: switchValueTwo ?? false,
                      onChanged: (bool newValue) =>
                          setState(() => switchValueTwo = newValue),
                      activeColor: MyTheme.primary,
                    )
                  ],
                ),
                TableCellSettings(
                    title: "Notifications",
                    onTap: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) {
                      //   return Settings();
                      // }));
                    }),
                SizedBox(height: 36.0),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text("Payment Settings",
                        style: TextStyle(
                            color: MyTheme.text,
                            fontWeight: FontWeight.w600,
                            fontSize: 18)),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text("These are also important settings",
                        style: TextStyle(color: MyTheme.time)),
                  ),
                ),
                TableCellSettings(title: "Manage Payment Options"),
                TableCellSettings(title: "Manage Gift Cards"),
                SizedBox(
                  height: 36.0,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text("Privacy Settings",
                        style: TextStyle(
                            color: MyTheme.text,
                            fontWeight: FontWeight.w600,
                            fontSize: 18)),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text("Third most important settings",
                        style: TextStyle(color: MyTheme.time)),
                  ),
                ),
                TableCellSettings(
                    title: "User Agreement",
                    onTap: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) {
                      //   return Settings();
                      // }));
                    }),
                TableCellSettings(
                    title: "Privacy",
                    onTap: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) {
                      //   return Settings();
                      // }));
                    }),
                TableCellSettings(
                    title: "About",
                    onTap: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) {
                      //   return Settings();
                      // }));
                    }),
              ],
            ),
          ),
        )));
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
