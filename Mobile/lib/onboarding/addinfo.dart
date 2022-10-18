import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:relax/my_theme.dart';
import 'package:relax/screen/main.dart';
import 'package:relax/widgets/snack_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

class AddInfo extends StatefulWidget {
  AddInfo({Key? key, this.title, this.showBackButton = false})
      : super(key: key);

  final String? title;
  bool showBackButton;
  @override
  _AddInfoState createState() => _AddInfoState();
}

class _AddInfoState extends State<AddInfo> {
  XFile? _image;
  String? _imagepath;
  String? name;
  String? phoneno;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final dobController = TextEditingController();
  // final genderController = TextEditingController();
  String? _selectedgender;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final Snackbar snackbar = Snackbar();
  @override
  void initState() {
    super.initState();
    LoadImage();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final focus = FocusScope.of(context);
    final deviceHeight = MediaQuery.of(context).size.height - 60.0;

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      appBar: buildAppBar(statusBarHeight, context),
      backgroundColor: MyTheme.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 10.0),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Choose a Profile Picture",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await chooseImage();
                      SaveImage(_image!.path);
                      LoadImage();
                      print("_image");
                      print(_image);
                      print("_image");
                    },
                    child: _imagepath != null
                        ? CircleAvatar(
                            backgroundImage: FileImage(File(_imagepath!)),
                            radius: 50.0,
                          )
                        : _image != null
                            ? CircleAvatar(
                                radius: 50.0,
                                backgroundImage: FileImage(File(_image!.path)))
                            : const CircleAvatar(
                                radius: 50.0,
                                backgroundImage: AssetImage(
                                    'assets/appinit/temp_profile.png')),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Divider(
              thickness: 2,
              height: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: nameController,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 18.0),
                  decoration: InputDecoration(
                    icon: Icon(Icons.account_circle_outlined),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 5.0),
                    labelText: "Name",
                    border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(width: 0.5, color: Colors.grey)),
                  ),
                  maxLines: 1,
                  onSubmitted: (val) => focus.nextFocus(),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: phoneController,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 18.0),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 5.0),
                    labelText: "Phone No",
                    border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(width: 0.5, color: Colors.grey)),
                  ),
                  maxLines: 1,
                  keyboardType: TextInputType.phone,
                  onSubmitted: (val) => focus.unfocus(),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: dobController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 5.0), //icon of text field
                    labelText: "Birth of Date",
                    border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                            width: 0.5,
                            color: Colors.grey)), //label text of field
                  ),
                  readOnly: true,
                  //set it true, so that user will not able to edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(DateTime.now().year + 1));

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      setState(() {
                        dobController.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {}
                  },
                ),
                const SizedBox(height: 20),
                DropdownButton<String>(
                  // Step 3.
                  isExpanded: true,
                  value: _selectedgender,
                  // Step 4.
                  borderRadius: BorderRadius.circular(10.0),
                  hint: Text("Gender"),
                  icon: Icon(Icons.person_search),
                  items: <String>['Male', 'Female','Rather not to say']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }).toList(),
                  // Step 5.
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedgender = newValue!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: deviceHeight * 0.09,
                  width: double.infinity,
                  child: TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(MyTheme.accent_color)),
                    onPressed: () async => addInfo(),
                    child: const Text(
                      "Start",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 17.0),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future addInfo() async {
    if (nameController.text.isEmpty || phoneController.text.isEmpty) {
      if (nameController.text.isEmpty) {
        snackbar.showSnack("Check your Name", null);
      }
      // if (double.tryParse(phoneController.text) == null) {
      //   snackbar.showSnack("Enter a Valid Number", _scaffoldKey, null);
      // }
      if (phoneController.text.isEmpty) {
        snackbar.showSnack("Check your Number", null);
      }
    } else {
      SharedPreferences saveName = await SharedPreferences.getInstance();
      saveName.setString("username", nameController.text);
      SharedPreferences savePhone = await SharedPreferences.getInstance();
      savePhone.setString("phone", phoneController.text);
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => Main(),
          // transitionDuration: Duration(milliseconds: 350),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        ),
      );
    }
  }

  AppBar buildAppBar(double statusBarHeight, BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
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
        // InkWell(
        //   onTap: () {
        //     // ToastComponent.showDialog("Coming soon", context,
        //     //     gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
        //   },
        //   child: Visibility(
        //     visible: false,
        //     child: Padding(
        //       padding:
        //           const EdgeInsets.symmetric(vertical: 18.0, horizontal: 12.0),
        //       child: Image.asset(
        //         'assets/bell.png',
        //         height: 16,
        //         color: MyTheme.dark_grey,
        //       ),
        //     ),
        //   ),
        // ),
        // InkWell(
        //   onTap: () {
        //     Navigator.push(context, MaterialPageRoute(builder: (context) {
        //       return Settings();
        //     }));
        //   },
        //   child: Padding(
        //     padding:
        //         const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
        //     child: Icon(
        //       Icons.settings,
        //       color: MyTheme.accent_color,
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Future<void> chooseImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void SaveImage(path) async {
    SharedPreferences saveImage = await SharedPreferences.getInstance();
    saveImage.setString("imagepath", path);
  }

  void LoadImage() async {
    SharedPreferences saveImage = await SharedPreferences.getInstance();
    setState(() {
      _imagepath = saveImage.getString("imagepath");
    });
  }
}
