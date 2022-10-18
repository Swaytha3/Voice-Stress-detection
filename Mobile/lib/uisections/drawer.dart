import 'package:flutter/material.dart';
import 'package:relax/screen/other/profile.dart';
import 'package:relax/screen/main.dart';


class MainDrawer extends StatefulWidget {
  MainDrawer({Key? key}) : super(key: key);

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  // String _whatsapp = AppConfig.whatsapp_number;
  // String _message = AppConfig.whatsapp_message;
  // String _phone_number = AppConfig.phone_number;
  bool is_logged_in = false;

  onTapLogout(context) async {
    // AuthHelper().clearUserData();

    /*
    var logoutResponse = await AuthRepository()
            .getLogoutResponse();


    if(logoutResponse.result == true){
         ToastComponent.showDialog(logoutResponse.message, context,
                   gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
         }
         */
    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return Login();
    // }));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.only(top: 50),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // is_logged_in.value == true
              // is_logged_in  == true
              //     ? ListTile(
              //         leading: CircleAvatar(
              //           backgroundImage: NetworkImage(
              //             AppConfig.BASE_PATH + "${avatar_original.value}",
              //           ),
              //         ),
              //         title: Text("${user_name.value}"),
              //         subtitle:
              //             user_email.value != "" && user_email.value != null
              //                 ? Text("${user_email.value}")
              //                 : Text("${user_phone.value}"))
              //     : 
                  Text('Not logged in',
                      style: TextStyle(
                          color: Color.fromRGBO(153, 153, 153, 1),
                          fontSize: 14)),
              Divider(),
              ListTile(
                  visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                  leading: Image.asset("assets/icons/home.png",
                      height: 16, color: Color.fromRGBO(153, 153, 153, 1)),
                  title: Text('Home',
                      style: TextStyle(
                          color: Color.fromRGBO(153, 153, 153, 1),
                          fontSize: 14)),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Main();
                    }));
                  }),
              // is_logged_in.value == true
              is_logged_in  == true
                  ? ListTile(
                      visualDensity:
                          VisualDensity(horizontal: -4, vertical: -4),
                      leading: Image.asset("assets/icons/profile.png",
                          height: 16, color: Color.fromRGBO(153, 153, 153, 1)),
                      title: Text('Profile',
                          style: TextStyle(
                              color: Color.fromRGBO(153, 153, 153, 1),
                              fontSize: 14)),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Profile(showBackButton: true);
                        }));
                      })
                  : Container(),
              // (is_logged_in.value == true)
              is_logged_in  == true
                  ? ListTile(
                      visualDensity:
                          VisualDensity(horizontal: -4, vertical: -4),
                      leading: Image.asset("assets/icons/chat.png",
                          height: 16, color: Color.fromRGBO(153, 153, 153, 1)),
                      title: Text('AI COuncellor',
                          style: TextStyle(
                              color: Color.fromRGBO(153, 153, 153, 1),
                              fontSize: 14)),
                      onTap: () {
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) {
                        //   return MessengerList();
                        // }));
                      })
                  : Container(),
              Divider(height: 24),
               ListTile(
                  visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                  leading: Icon(
                    Icons.import_contacts_outlined,
                  // Image.asset("assets/login.png",
                      size: 16, color: Color.fromRGBO(153, 153, 153, 1)
                      // ),
                  ),
                  title: Text('About Us',
                      style: TextStyle(
                          color: Color.fromRGBO(153, 153, 153, 1),
                          fontSize: 14)),
                  onTap: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) {
                    //   return AboutUs();
                    // }));
                  }),
              Divider(height: 24),
              // is_logged_in.value == false
              is_logged_in  == false
                  ? ListTile(
                      visualDensity:
                          VisualDensity(horizontal: -4, vertical: -4),
                      leading: Image.asset("assets/icons/login.png",
                          height: 16, color: Color.fromRGBO(153, 153, 153, 1)),
                      title: Text('Login',
                          style: TextStyle(
                              color: Color.fromRGBO(153, 153, 153, 1),
                              fontSize: 14)),
                      onTap: () {
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) {
                        //   return Login();
                        // }));
                      })
                  : Container(),
              // is_logged_in.value == true
              is_logged_in  == true
                  ? ListTile(
                      visualDensity:
                          VisualDensity(horizontal: -4, vertical: -4),
                      leading: Image.asset("assets/logout.png",
                          height: 16, color: Color.fromRGBO(153, 153, 153, 1)),
                      title: Text('Logout',
                          style: TextStyle(
                              color: Color.fromRGBO(153, 153, 153, 1),
                              fontSize: 14)),
                      onTap: () {
                        onTapLogout(context);
                      })
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}