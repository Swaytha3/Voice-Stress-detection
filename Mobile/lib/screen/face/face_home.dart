import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

import 'package:relax/my_theme.dart';
import 'package:relax/uisections/drawer.dart';
import 'package:relax/widgets/table-cell.dart';

class FaceHome extends StatefulWidget {
  FaceHome({Key? key, this.showBackButton = false}) : super(key: key);

  bool showBackButton;

  @override
  _FaceHomeState createState() => _FaceHomeState();
}

class _FaceHomeState extends State<FaceHome>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _currentSlider = 0;
  ScrollController? _featuredProductScrollController;

  String _image =
      'https://ouch-cdn2.icons8.com/84zU-uvFboh65geJMR5XIHCaNkx-BZ2TahEpE9TpVJM/rs:fit:784:784/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9wbmcvODU5/L2E1MDk1MmUyLTg1/ZTMtNGU3OC1hYzlh/LWU2NDVmMWRiMjY0/OS5wbmc.png';

  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future deleteImage() async {
    setState(() => this.image = null);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: buildAppBar(statusBarHeight, context),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            image != null
                ? Padding(
                    padding: EdgeInsets.all(20),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          image!,
                          // width: 70,
                        )),
                  )
                : Image.network(
                    _image,
                    width: 300,
                  ),
            SizedBox(
              height: 50,
            ),
            Text(
              'Upload your image',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'File should be jpg, png',
              style: TextStyle(fontSize: 15, color: Colors.grey.shade500),
            ),
            SizedBox(
              height: 20,
            ),
            image != null
                ? Padding(
                    padding: EdgeInsets.all(20),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        deleteImage();
                        // Respond to button press
                      },
                      style: ElevatedButton.styleFrom(
                        primary: MyTheme.red_accent_color,
                        minimumSize: const Size.fromHeight(50),
                        padding: EdgeInsets.all(20),
                      ),
                      icon: Icon(Icons.delete, size: 20),
                      label:
                          Text("Delete Image", style: TextStyle(fontSize: 20)),
                    ))
                : Column(
                    children: [
                      GestureDetector(
                        onTap: pickImage,
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.0, vertical: 20.0),
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: Radius.circular(10),
                              dashPattern: [10, 4],
                              strokeCap: StrokeCap.round,
                              color: MyTheme.accent_color,
                              child: Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                    color: Colors.blue.shade50.withOpacity(.3),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Iconsax.image,
                                      color: MyTheme.accent_color,
                                      size: 40,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      'Select your image',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey.shade400),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ),
                      GestureDetector(
                        onTap: pickImageC,
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.0, vertical: 20.0),
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: Radius.circular(10),
                              dashPattern: [10, 4],
                              strokeCap: StrokeCap.round,
                              color: MyTheme.accent_color,
                              child: Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                    color: Colors.blue.shade50.withOpacity(.3),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Iconsax.camera,
                                      color: MyTheme.accent_color,
                                      size: 40,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      'Capture Your Image',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey.shade400),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
            SizedBox(
              height: 150,
            ),
          ],
        ),
      ),
    );
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
              return FaceHome();
            }));
          },
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            child: Icon(
              Icons.upload_file,
              color: MyTheme.accent_color,
            ),
          ),
        ),
      ],
    );
  }
}
