import 'dart:io';
import 'package:relax/api/api_service.dart';
import 'package:relax/models/message.dart';
import 'package:http/http.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:relax/my_theme.dart';
import 'package:relax/widgets/message_item.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';
import 'package:firebase_storage/firebase_storage.dart';

enum ChatDetailMenuOptions {
  viewContact,
  media,
  search,
  muteNotifications,
  wallpaper,
  more,
}

enum ChatDetailMoreMenuOptions {
  report,
  block,
  clearChat,
  exportChat,
  addShortcut,
}

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key, this.title, this.showBackButton = false})
      : super(key: key);

  final String? title;
  bool showBackButton;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<MessageItem> _messages = <MessageItem>[];
  // final List<ChatMessage> _messages = <ChatMessage>[];
  String _message = '';
  TextEditingController _textController = TextEditingController();
  bool _isPlayingMsg = false, _isRecording = false, _isSending = false;
  double _fontSize = 15.0; // default = medium
  TextInputAction _textInputAction = TextInputAction.newline;
  ScrollController scrollController = ScrollController();
  // Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    // _prefs.then((SharedPreferences prefs) {
    //   int size = prefs.getInt(SharedPreferencesHelpers.fontSize);
    int size = 1;
    setState(() {
      if (size == 0) {
        // small
        _fontSize = 13.0;
      } else if (size == 1) {
        // medium
        _fontSize = 15.0;
      } else if (size == 2) {
        // large
        _fontSize = 18.0;
      }
    });
    // bool enterIsSend = prefs.getBool(SharedPreferencesHelpers.enterIsSend) ?? SharedPreferencesHelpers.defaultEnterIsSend;
    bool enterIsSend = false;
    setState(() {
      if (enterIsSend) {
        _textInputAction = TextInputAction.send;
      } else {
        _textInputAction = TextInputAction.newline;
      }
    });
    // }

    // _chat = widget.chat;
    // int chatId = widget.chat?.id ?? widget.id;
    // _fMessages =
    //     ChatService.getChat(chatId).then((chat) {
    //       setState(() {
    //         _chat = chat;
    //         _messages = chat.messages.reversed.toList();
    //       });
    //       return null;
    //     });
    _textController = TextEditingController()
      ..addListener(() {
        setState(() {
          _message = _textController.text;
        });
      });
  }

  Widget _buildTextComposer() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(const Radius.circular(30.0)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  _isSending
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 25.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(const Radius.circular(80.0)),
                              color: Colors.white,
                            ),
                            child: LinearProgressIndicator(
                              backgroundColor: Colors.grey[100],
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  MyTheme.accent_color),
                            ),
                          ),
                        )
                      : SizedBox(),
                  Row(
                    children: [
                      IconButton(
                        padding: const EdgeInsets.all(0.0),
                        disabledColor: MyTheme.accent_color,
                        color: MyTheme.accent_color,
                        icon: Icon(null),
                        onPressed: () {},
                      ),
                      Flexible(
                        child: TextField(
                          controller: _textController,
                          textCapitalization: TextCapitalization.sentences,
                          textInputAction: _textInputAction,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(0.0),
                            hintText: 'Type a message',
                            hintStyle: TextStyle(
                              color: MyTheme.dark_grey,
                              fontSize: 16.0,
                            ),
                            counterText: '',
                          ),
                          onSubmitted: (String text) {
                            if (_textInputAction == TextInputAction.send) {
                              _handleSubmitted(text);
                            }
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          maxLength: 100,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: FloatingActionButton(
              elevation: 2.0,
              backgroundColor: MyTheme.accent_color,
              foregroundColor: Colors.white,
              onPressed: () {
                print("object");
                _handleSubmitted(_message);
              },
              child: _message.isEmpty
                  ? GestureDetector(
                      onLongPress: () {
                        startRecord();
                        setState(() {
                          _isRecording = true;
                        });
                      },
                      onLongPressEnd: (details) {
                        stopRecord();
                        setState(() {
                          _isRecording = false;
                        });
                      },
                      child: Container(
                          padding: EdgeInsets.all(10),
                          // height: 40,
                          margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: _isRecording
                                        ? Colors.white
                                        : Colors.black12,
                                    spreadRadius: 4)
                              ],
                              color: MyTheme.accent_color,
                              shape: BoxShape.circle),
                          child: const Icon(
                            Icons.settings_voice,
                            color: Colors.white,
                            size: 20,
                          )),
                    )
                  : const Icon(Icons.send),
            ),
          )
        ],
      ),
    );
  }

  void Response(query) async {
    _textController.clear();
    final response = await ApiService().sendMessage("123", "text", query);
    print("object");
    print(response);
    print("object");
    // Message response = await ApiService.sendMessage(
    //     uID,
    //     "audio"
    //     "",
    //     audioURL);

    // AuthGoogle authGoogle =
    //     await AuthGoogle(fileJson: "assets/BirthDayWisher-27d44bfaad84.json")
    //         .build();
    // Dialogflow dialogflow =
    //     Dialogflow(authGoogle: authGoogle, language: Language.english);
    // AIResponse response = await dialogflow.detectIntent(query);
    // // ChatMessage message = ChatMessage(

    // MessageItem message = MessageItem(
    //   text: response.getMessage() ??
    //       CardDialogflow(response.getListMessage()[0]).title,
    //   name: "Bot",
    //   type: false,
    // );
    MessageItem message = MessageItem(
      content: response.say,
      timestamp: DateTime.now(),
      isYou: false,
      fontSize: _fontSize,
    );

    setState(() {
      _messages.insert(0, message);
    });
  }

  uploadAudio() {
    // setState(() {
    //   _isSending = false;
    // });
//
    // FirebaseStorage storage = FirebaseStorage.instanceFor(bucket: 'gs://chatbot-83d39.appspot.com');
    FirebaseStorage storage = FirebaseStorage.instance;
    String path =
        'recorded_audios/audio${DateTime.now().millisecondsSinceEpoch.toString()}.mp3';
    Reference ref = storage.ref().child(path);
    UploadTask task = ref.putFile(File(recordFilePath));

    task.whenComplete(() async {
      var audioURL = await ref.getDownloadURL();
      String url = audioURL.toString();
      await sendAudioMsg(url);
    }).catchError((err) {
      print(err);
    });

    // final StorageReference firebaseStorageRef = FirebaseStorage.instance
    //     .ref()
    //     .child(
    //         'profilepics/audio${DateTime.now().millisecondsSinceEpoch.toString()}}.jpg');

    // StorageUploadTask task = firebaseStorageRef.putFile(File(recordFilePath));
    // task.onComplete.then((value) async {
    //   print('##############done#########');
    //   var audioURL = await value.ref.getDownloadURL();
    //   String strVal = audioURL.toString();
    //   await sendAudioMsg(strVal);
    // }).catchError((e) {
    //   print(e);
    // });

// FirebaseStorage storage = FirebaseStorage.instance;
    // String url;
    // Reference ref = storage.ref().child("image1" + DateTime.now().toString());
    // UploadTask uploadTask = ref.putFile(_image1);
    // uploadTask.whenComplete(() {
    //   url = ref.getDownloadURL();
    // }).catchError((onError) {
    //   print(onError);
    // });
    // return url;
  }

  sendAudioMsg(String audioMsg) async {
    if (audioMsg.isNotEmpty) {
      final response = await ApiService().sendMessage("123", "audio", audioMsg);

      print("response");
      print(response);
      print("response");
      // MessageItem message = MessageItem(
      //   content: audioMsg,
      //   timestamp: DateTime.now(),
      //   isYou: true,
      //   fontSize: _fontSize,
      // );

      setState(() {
        // _messages.insert(0, message);
        // _isSending = false;
        // _messages.insert(0, message2);
        // _message = '';
        // _textController.text = '';
      });

      // var ref = FirebaseFirestore.instance
      //     .collection('messages')
      //     .doc(chatRoomID)
      //     .collection(chatRoomID)
      //     .doc(DateTime.now().millisecondsSinceEpoch.toString());
      // await FirebaseFirestore.instance.runTransaction((transaction) async {
      //   await transaction.set(ref, {
      //     "senderId": userID,
      //     "anotherUserId": widget.docs['id'],
      //     "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
      //     "content": audioMsg,
      //     "type": 'audio'
      //   });
      // }).then((value) {
      // setState(() {
      //   _isSending = false;
      // });
      // });
      scrollController.animateTo(0.0,
          duration: Duration(milliseconds: 100), curve: Curves.bounceInOut);

      // Response(text);
    } else {
      print("Hello");
    }
  }

  void _handleSubmitted(String text) {
    if (_message.isEmpty || _message.trim().isEmpty) return;
    _textController.clear();

    MessageItem message = MessageItem(
      content: text,
      timestamp: DateTime.now(),
      isYou: true,
      fontSize: _fontSize,
    );

    // MessageItem message2 = MessageItem(
    //   content: "How can a girl go 25 days without sleep?.....She sleeps and night!",
    //   timestamp: DateTime.now(),
    //   isYou: false,
    //   fontSize: _fontSize,
    // );
    setState(() {
      _messages.insert(0, message);
      // _messages.insert(0, message2);
      _message = '';
      _textController.text = '';
    });
    Response(text);
  }

  _onSelectMenuOption(ChatDetailMenuOptions option) {
    switch (option) {
      case ChatDetailMenuOptions.viewContact:
        // Application.router.navigateTo(
        //   context,
        //   //"/profile?id=${_chat.id}",
        //   Routes.futureTodo,
        //   transition: TransitionType.inFromRight,
        // );
        break;
      case ChatDetailMenuOptions.media:
        // Application.router.navigateTo(
        //   context,
        //   //"/chat/media?id=${_chat.id}",
        //   Routes.futureTodo,
        //   transition: TransitionType.inFromRight,
        // );
        break;
      case ChatDetailMenuOptions.search:
        break;
      case ChatDetailMenuOptions.muteNotifications:
        break;
      case ChatDetailMenuOptions.wallpaper:
        break;
      case ChatDetailMenuOptions.more:
        break;
    }
  }

  AppBar buildAppBar(double statusBarHeight, BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      leading: Padding(
        padding: EdgeInsets.only(left: 10),
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black.withOpacity(0.6),
          ),
        ),
      ),
      title: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            child: CircleAvatar(
              backgroundColor: Color.fromARGB(255, 148, 148, 148),
              child: Text(
                'AC',
                style: TextStyle(color: MyTheme.white),
              ),
            ),
            // decoration: BoxDecoration(
            //   shape: BoxShape.circle,
            //   image: DecorationImage(
            //     image: NetworkImage(profilePic),
            //     fit: BoxFit.cover,
            //   ),
            // ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "AI Councellor",
                style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 16,
                ),
              ),
              // online
              //     ?
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 1),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 3),
                  Text(
                    "Active Now",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              )
              // : Text(
              //     time,
              //     style: TextStyle(
              //       color: Colors.grey,
              //       fontSize: 12,
              //     ),
              //   ),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.videocam),
              color: MyTheme.accent_color,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Video Call Button tapped')));
              },
            );
          },
        ),
        Builder(
          builder: (BuildContext context) {
            return IconButton(
              color: MyTheme.accent_color,
              icon: Icon(Icons.call),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Call Button tapped')));
              },
            );
          },
        ),
        PopupMenuButton<ChatDetailMenuOptions>(
          tooltip: "More options",
          icon: Icon(
            Icons.more_vert,
            size: 20,
            color: MyTheme.accent_color,
          ),
          color: MyTheme.white,
          onSelected: _onSelectMenuOption,
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem<ChatDetailMenuOptions>(
                child: Text("View contact"),
                value: ChatDetailMenuOptions.viewContact,
              ),
              const PopupMenuItem<ChatDetailMenuOptions>(
                child: Text("Media"),
                value: ChatDetailMenuOptions.media,
              ),
              const PopupMenuItem<ChatDetailMenuOptions>(
                child: Text("Search"),
                value: ChatDetailMenuOptions.search,
              ),
              const PopupMenuItem<ChatDetailMenuOptions>(
                child: Text("Mute notifications"),
                value: ChatDetailMenuOptions.muteNotifications,
              ),
              const PopupMenuItem<ChatDetailMenuOptions>(
                child: Text("Wallpaper"),
                value: ChatDetailMenuOptions.wallpaper,
              ),
              const PopupMenuItem<ChatDetailMenuOptions>(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0.0),
                  title: Text("More"),
                  trailing: Icon(Icons.arrow_right),
                ),
                value: ChatDetailMenuOptions.more,
              ),
            ];
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: MyTheme.golden,
      appBar: buildAppBar(statusBarHeight, context),
      body: Column(children: <Widget>[
        Flexible(
            child: ListView.builder(
          padding: EdgeInsets.all(8.0),
          reverse: true,
          itemBuilder: (_, int index) => _messages[index],
          itemCount: _messages.length,
        )),
        Divider(height: 1.0),
        _buildTextComposer(),
      ]),
    );
  }

  Future _loadFile(String url) async {
    final uri = Uri.parse(url);
    final bytes = await readBytes(uri);
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/audio.mp3');

    await file.writeAsBytes(bytes);
    if (await file.exists()) {
      setState(() {
        recordFilePath = file.path;
        _isPlayingMsg = true;
        print(_isPlayingMsg);
      });
      await play();
      setState(() {
        _isPlayingMsg = false;
        print(_isPlayingMsg);
      });
    }
  }

  Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  void startRecord() async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      recordFilePath = await getFilePath();

      RecordMp3.instance.start(recordFilePath, (type) {
        setState(() {});
      });
    } else {}
    setState(() {});
  }

  void stopRecord() async {
    bool s = RecordMp3.instance.stop();
    if (s) {
      setState(() {
        _isSending = true;
      });
      await uploadAudio();

      setState(() {
        _isPlayingMsg = false;
      });
    }
  }

  String recordFilePath = '';

  Future<void> play() async {
    if (recordFilePath.isNotEmpty && File(recordFilePath).existsSync()) {
      AudioPlayer audioPlayer = AudioPlayer();
      await audioPlayer.play(
        recordFilePath,
        isLocal: true,
      );
    }
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
}
