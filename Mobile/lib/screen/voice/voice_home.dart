import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/services.dart';
import 'package:relax/api/api_service.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

import 'package:relax/my_theme.dart';
import 'package:relax/uisections/drawer.dart';
import 'package:relax/widgets/table-cell.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';

class VoiceHome extends StatefulWidget {
  VoiceHome({Key? key, this.showBackButton = false}) : super(key: key);

  bool showBackButton;

  @override
  _VoiceHomeState createState() => _VoiceHomeState();
}

class _VoiceHomeState extends State<VoiceHome>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _currentSlider = 0;
  ScrollController? _featuredProductScrollController;
  bool _isPlayingMsgQ1 = false,
      _isRecordingQ1 = false,
      _isPlayingMsgQ2 = false,
      _isRecordingQ2 = false,
      _isPlayingMsgQ3 = false,
      _isRecordingQ3 = false;
  ScrollController scrollController = ScrollController();
  AudioPlayer audioPlayer = AudioPlayer();
  String _image =
      'https://ouch-cdn2.icons8.com/84zU-uvFboh65geJMR5XIHCaNkx-BZ2TahEpE9TpVJM/rs:fit:784:784/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9wbmcvODU5/L2E1MDk1MmUyLTg1/ZTMtNGU3OC1hYzlh/LWU2NDVmMWRiMjY0/OS5wbmc.png';

  Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  Future<void> startRecord() async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      recordFilePath = await getFilePath();

      RecordMp3.instance.start(recordFilePath, (type) {
        setState(() {});
      });
    } else {}
  }

  void stopRecord() async {
    bool s = RecordMp3.instance.stop();
    if (s) {
      setState(() {
        recordFilePath = '';
        _isRecordingQ1 = false;
        _isRecordingQ2 = false;
        _isRecordingQ3 = false;
      });
    }
  }

  void triggerRecording(input) {
    stopplay();
    setState(() {
      if (input == "1") {
        _isRecordingQ2 = false;
        _isRecordingQ3 = false;
        _isRecordingQ1 = true;
      }
      if (input == "2") {
        _isRecordingQ1 = false;
        _isRecordingQ3 = false;
        _isRecordingQ2 = true;
      }
      if (input == "3") {
        _isRecordingQ1 = false;
        _isRecordingQ2 = false;
        _isRecordingQ3 = true;
      }
    });
  }

  void triggerPlaying(input) {
    stopRecord();
    setState(() {
      if (input == "1") {
        _isPlayingMsgQ2 = false;
        _isPlayingMsgQ3 = false;
        _isPlayingMsgQ1 = true;
      }
      if (input == "2") {
        _isPlayingMsgQ1 = false;
        _isPlayingMsgQ3 = false;
        _isPlayingMsgQ2 = true;
      }
      if (input == "3") {
        _isPlayingMsgQ1 = false;
        _isPlayingMsgQ2 = false;
        _isPlayingMsgQ3 = true;
      }
    });
  }

  uploadAudio() {
    FirebaseStorage storage = FirebaseStorage.instance;
    String path =
        'recorded_voice_audios/audio${DateTime.now().millisecondsSinceEpoch.toString()}.mp3';
    Reference ref = storage.ref().child(path);
    UploadTask task = ref.putFile(File(recordFilePath));

    task.whenComplete(() async {
      var audioURL = await ref.getDownloadURL();
      String url = audioURL.toString();
      await sendAudioMsg(url);
    }).catchError((err) {
      print(err);
    });
  }

  sendAudioMsg(String audioMsg) async {
    if (audioMsg.isNotEmpty) {
      // final response = await ApiService().sendMessage("123", "audio", audioMsg);

      print("response");
      print(audioMsg);
      print("response");
      setState(() {
        // _messages.insert(0, message);
        // _isSending = false;
        // _messages.insert(0, message2);
        // _message = '';
        // _textController.text = '';
      });

      scrollController.animateTo(0.0,
          duration: Duration(milliseconds: 100), curve: Curves.bounceInOut);

      // Response(text);
    } else {
      print("Hello");
    }
  }

  String recordFilePath = '';
  String recordFilePathQ1 = '';
  String recordFilePathQ2 = '';
  String recordFilePathQ3 = '';

  Future<void> play(input) async {
    if (input.isNotEmpty && File(input).existsSync()) {
      // AudioPlayer audioPlayer = AudioPlayer();
      await audioPlayer.play(
        input,
        isLocal: true,
      );
    }
  }

  Future<void> stopplay() async {
    await audioPlayer.stop();
    setState(() {
      _isPlayingMsgQ1 = false;
      _isPlayingMsgQ2 = false;
      _isPlayingMsgQ3 = false;
    });
  }

  int i = 0;

  Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = storageDirectory.path + "/record";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    return sdPath + "/test_${i++}.mp3";
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
            Image.network(
              _image,
              width: 200,
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              'Answer The questions',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Record your answers for the questions',
              style: TextStyle(fontSize: 15, color: Colors.grey.shade500),
            ),
            SizedBox(
              height: 20,
            ),
            // image != null
            //     ? Padding(
            //         padding: EdgeInsets.all(20),
            //         child: ElevatedButton.icon(
            //           onPressed: () {
            //             deleteImage();
            //             // Respond to button press
            //           },
            //           style: ElevatedButton.styleFrom(
            //             primary: MyTheme.red_accent_color,
            //             minimumSize: const Size.fromHeight(50),
            //             padding: EdgeInsets.all(20),
            //           ),
            //           icon: Icon(Icons.delete, size: 20),
            //           label:
            //               Text("Delete Image", style: TextStyle(fontSize: 20)),
            //         ))
            //     :
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '01. This is the first Question',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.bold),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 4.0),
                        // child:
                        FloatingActionButton(
                            elevation: 2.0,
                            backgroundColor: MyTheme.accent_color,
                            foregroundColor: Colors.white,
                            onPressed: () {
                              print("object");
                              // _handleSubmitted(_message);
                            },
                            child: GestureDetector(
                              onTap: () async {
                                if (recordFilePathQ1 == '') {
                                  if (_isRecordingQ1) {
                                    setState(() {
                                      _isRecordingQ1 = false;
                                      recordFilePathQ1 = recordFilePath;
                                    });
                                    stopRecord();
                                  } else {
                                    await startRecord();
                                    triggerRecording("1");
                                  }
                                } else {
                                  if (_isPlayingMsgQ1) {
                                    stopplay();
                                    setState(() {
                                      _isPlayingMsgQ1 = false;
                                    });
                                  } else {
                                    play(recordFilePathQ1);
                                    triggerPlaying("1");
                                  }
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                // height: 40,
                                margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: recordFilePathQ1 == ''
                                              ? _isRecordingQ1
                                                  ? Colors.white
                                                  : Colors.black12
                                              : _isPlayingMsgQ1
                                                  ? Colors.red
                                                  : Colors.black12,
                                          spreadRadius: 4)
                                    ],
                                    color: MyTheme.accent_color,
                                    shape: BoxShape.circle),
                                child: recordFilePathQ1 == ""
                                    ? const Icon(
                                        Icons.settings_voice,
                                        color: Colors.white,
                                        size: 20,
                                      )
                                    : _isPlayingMsgQ1
                                        ? Icon(
                                            Icons.stop,
                                          )
                                        : Icon(Icons.play_arrow),
                              ),
                            )),
                        // ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Padding(
                        //   padding: EdgeInsets.symmetric(
                        //       horizontal: 40.0, vertical: 20.0),
                        //   child:
                        Text(
                          '02. This is the Secound Question',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.bold),
                        ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 4.0),
                        // child:
                        FloatingActionButton(
                            elevation: 2.0,
                            backgroundColor: MyTheme.accent_color,
                            foregroundColor: Colors.white,
                            onPressed: () {
                              print("object");
                              // _handleSubmitted(_message);
                            },
                            child: GestureDetector(
                              onTap: () async {
                                if (recordFilePathQ2 == '') {
                                  if (_isRecordingQ2) {
                                    setState(() {
                                      _isRecordingQ2 = false;
                                      recordFilePathQ2 = recordFilePath;
                                    });
                                    stopRecord();
                                  } else {
                                    await startRecord();
                                    triggerRecording("2");
                                  }
                                } else {
                                  if (_isPlayingMsgQ2) {
                                    stopplay();
                                    setState(() {
                                      _isPlayingMsgQ2 = false;
                                    });
                                  } else {
                                    play(recordFilePathQ2);
                                    triggerPlaying("2");
                                  }
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                // height: 40,
                                margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: recordFilePathQ2 == ''
                                              ? _isRecordingQ2
                                                  ? Colors.white
                                                  : Colors.black12
                                              : _isPlayingMsgQ2
                                                  ? Colors.red
                                                  : Colors.black12,
                                          spreadRadius: 4)
                                    ],
                                    color: MyTheme.accent_color,
                                    shape: BoxShape.circle),
                                child: recordFilePathQ2 == ""
                                    ? const Icon(
                                        Icons.settings_voice,
                                        color: Colors.white,
                                        size: 20,
                                      )
                                    : _isPlayingMsgQ2
                                        ? Icon(
                                            Icons.stop,
                                          )
                                        : Icon(Icons.play_arrow),
                              ),
                            )),
                        // ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '03. This is the third Question',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.bold),
                        ),
                        FloatingActionButton(
                            elevation: 2.0,
                            backgroundColor: MyTheme.accent_color,
                            foregroundColor: Colors.white,
                            onPressed: () {
                              print("object");
                              // _handleSubmitted(_message);
                            },
                            child: GestureDetector(
                              onTap: () async {
                                if (recordFilePathQ3 == '') {
                                  if (_isRecordingQ3) {
                                    setState(() {
                                      _isRecordingQ3 = false;
                                      recordFilePathQ3 = recordFilePath;
                                    });
                                    stopRecord();
                                  } else {
                                    await startRecord();
                                    triggerRecording("3");
                                  }
                                } else {
                                  if (_isPlayingMsgQ3) {
                                    stopplay();
                                    setState(() {
                                      _isPlayingMsgQ3 = false;
                                    });
                                  } else {
                                    play(recordFilePathQ3);
                                    triggerPlaying("3");
                                  }
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                // height: 40,
                                margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: recordFilePathQ1 == ''
                                              ? _isRecordingQ3
                                                  ? Colors.white
                                                  : Colors.black12
                                              : _isPlayingMsgQ3
                                                  ? Colors.red
                                                  : Colors.black12,
                                          spreadRadius: 4)
                                    ],
                                    color: MyTheme.accent_color,
                                    shape: BoxShape.circle),
                                child: recordFilePathQ3 == ""
                                    ? const Icon(
                                        Icons.settings_voice,
                                        color: Colors.white,
                                        size: 20,
                                      )
                                    : _isPlayingMsgQ3
                                        ? Icon(
                                            Icons.stop,
                                          )
                                        : Icon(Icons.play_arrow),
                              ),
                            )),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
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
              return VoiceHome();
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
