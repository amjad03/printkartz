
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Printzkart/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/dimensions.dart';
import '../../widgets/custom_input.dart';
import '../../widgets/show_message.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  TextEditingController helpController = TextEditingController();

  final user = FirebaseAuth.instance.currentUser;

  void sendHelp(help) async {
    final helpRef = FirebaseFirestore.instance.collection('help');

    String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    String time = DateFormat("hh:mm:ss a").format(DateTime.now());

    final helpData = {
      'userName': user!.displayName,
      'date': date,
      'time': time,
      'viewed': false,
      'email': user?.email,
      'helpMessage': help,
    };
    final userId = user?.uid;
    await helpRef.doc(userId).set(helpData);
  }


  @override
  void dispose() {
    super.dispose();
    helpController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var color = Theme.of(context).brightness == Brightness.dark ? const Color(0xFF333333) : Colors.white;
    var dividerColor = Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black38;

    final name = user?.displayName;
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        title: const Text("Help",style: TextStyle(fontFamily: 'Inter'),),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(Dimensions.height20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: Dimensions.height20,),
            Text("Hi, $name\n ", style: TextStyle(fontSize: Dimensions.twenty),textAlign: TextAlign.center,),
            Text("We are always here for you. Please ask for any queries you have, we will try to figure it out as soon as possible.", style: TextStyle(fontSize: Dimensions.fifteen),textAlign: TextAlign.center,),
            SizedBox(height: Dimensions.height20,),
            CustomInputField(controller: helpController, icon: Icons.help, label: "What help you need", password: false, phoneNumber: false,maxLines: 4, isFor: 'Help',),
            Padding(
              padding: EdgeInsets.all(Dimensions.ten),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: dividerColor,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'or',
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: dividerColor,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.call, size: Dimensions.twenty,),
                SizedBox(width: Dimensions.ten,),
                const Text("Call Us : "),
                TextButton(
                    onPressed: (){
                      Uri call = Uri.parse('tel:${Strings.phoneNo}');
                      launchUrl(call);
                    },
                    child: const Text(Strings.phoneNo, style: TextStyle(color: Colors.blue),)),
                const Text("/"),
                TextButton(
                    onPressed: (){
                      Uri call = Uri.parse('tel:${Strings.phoneNo2}');
                      launchUrl(call);
                    },
                    child: const Text(Strings.phoneNo2, style: TextStyle(color: Colors.blue),)),
              ],
            ),
            SizedBox(height: Dimensions.height20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Dimensions.radius50),
                      ),
                      padding: EdgeInsets.symmetric(vertical: Dimensions.fifteen,horizontal: Dimensions.forty)
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel",style: TextStyle(color: Colors.white,fontSize: Dimensions.fifteen,fontFamily: 'Inter'),),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Dimensions.radius50),
                      ),
                      padding: EdgeInsets.symmetric(vertical: Dimensions.fifteen,horizontal: Dimensions.forty)
                  ),
                  onPressed: () {
                    sendHelp(helpController.text);
                    showToast("Successfully received, we will resolve your help as soon as possible");
                    Navigator.of(context).pop();
                  },
                  child: Text("Submit",style: TextStyle(color: Colors.white,fontSize: Dimensions.fifteen,fontFamily: 'Inter'),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


