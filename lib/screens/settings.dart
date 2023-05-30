import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:printzkart/screens/policies/privacy_policy.dart';

import '../constants/dimensions.dart';
import '../repository/auth_repository.dart';
import '../theme/model_theme.dart';
import '../widgets/show_dialogue.dart';
import 'feedback&help/feedback.dart';
import 'main_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {

    final loggedIn = checkLoggedIn();
    var color = Theme.of(context).brightness == Brightness.dark ? const Color(0xFF333333) : Colors.white;

    // final FirebaseAuth auth = FirebaseAuth.instance;

    goToMainPage(){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const MainPage()), (Route<dynamic> route) => false);
    }

    showMessage(){
      Fluttertoast.showToast(
          msg: "Your are Not Logged in",
          toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
          gravity: ToastGravity.BOTTOM, // position of the toast message on the screen
          timeInSecForIosWeb: 3, // time duration in seconds to show the toast message
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0
      );

    }

    customListTile(FaIcon icon, String title,ontap){
      return Column(
        children: [
          ListTile(
            onTap: ontap,
            leading: icon,
            title: Text(title,style: TextStyle(fontSize: Dimensions.eighteen),),
            trailing: const Icon(Icons.chevron_right_rounded,),
          ),
          const Divider(height: 1,),
        ],
      );
    }

    // Future<void> logout(BuildContext context) async {
    //   return showDialog<void>(
    //     context: context,
    //     barrierDismissible: false,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: const Text('Do you want to logout?'),
    //         content: const Text("You have to login again in order to get into the app",textAlign: TextAlign.center,),
    //         actions: <Widget>[
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               TextButton(
    //                 child: const Text('Cancel',style: TextStyle(color: Colors.grey),),
    //                 onPressed: () {
    //                   Navigator.of(context).pop();
    //                 },
    //               ),
    //               TextButton(
    //                 child: const Text('Confirm',style: TextStyle(color: Colors.grey),),
    //                 onPressed: () async{
    //                   await auth.signOut();
    //                   Navigator.of(context).pop();
    //                   Navigator.of(context).pushAndRemoveUntil(
    //                       MaterialPageRoute(builder: (context) => const MainPage()),
    //                           (Route<dynamic> route) => false);
    //                 },
    //               ),
    //             ],
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // }

    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child){
        return Scaffold(
        backgroundColor: color,
        appBar: AppBar(
          title: const Text("Settings", style: TextStyle(fontFamily: 'Inter'),),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(Dimensions.ten),
          child: Column(
            children: [
              ListTile(
                  leading: const FaIcon(FontAwesomeIcons.palette,),
                  title: Text("Dark Mode",style: TextStyle(fontSize: Dimensions.eighteen),),
                  trailing: Switch(
                    onChanged: (value){
                      themeNotifier.isDark
                          ? themeNotifier.isDark = false
                          : themeNotifier.isDark = true;
                    },
                    value: themeNotifier.isDark
                        ? false
                        : true,
                    activeColor: Colors.blue,
                  )
              ),
              const Divider(height: 1,),
              customListTile(const FaIcon(FontAwesomeIcons.solidMessage,),
                  "Feedback & Support", () {
                    loggedIn ?
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const FeedbackScreen()))
                        :showMessage();
                  }),
              customListTile(
                  const FaIcon(FontAwesomeIcons.solidCircleQuestion,),
                  "Privacy & Security", () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const PrivacyPolicy()));
              }),
              customListTile(
                  const FaIcon(FontAwesomeIcons.shield,), "Logout", () {
                // loggedIn ? logout(context)
                //     : showMessage();
                loggedIn ? logOutDialogBox(context, goToMainPage())
                    : showMessage();
              }),
            ],
          ),
        ),
      );
    });
  }
}
