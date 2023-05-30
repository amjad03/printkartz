
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Printzkart/widgets/show_message.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constants/dimensions.dart';
import '../../../widgets/custom_input.dart';
import '../../constants/constants.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  TextEditingController feedbackController = TextEditingController();

  final user = FirebaseAuth.instance.currentUser;

  void sendFeedback(feedback) async {

    final feedbackRef = FirebaseFirestore.instance.collection('feedback');

    String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    String time = DateFormat("hh:mm:ss a").format(DateTime.now());

    final feedbackData = {
      'userName': user!.displayName,
      'date': date,
      'time': time,
      'viewed': false,
      'email': user?.email,
      'feedback': feedback,
    };
    final userId = user?.uid;
    await feedbackRef.doc(userId).set(feedbackData);
  }

  @override
  void dispose() {
    super.dispose();
    feedbackController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var color = Theme.of(context).brightness == Brightness.dark ? const Color(0xFF333333) : Colors.white;
    var dividerColor = Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black38;


    final name = user?.displayName;
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        title: const Text("Feedback",style: TextStyle(fontFamily: 'Inter'),),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(Dimensions.height20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: Dimensions.height20,),
            Text("Hi, $name\n ", style: TextStyle(fontSize: Dimensions.twenty),textAlign: TextAlign.center,),
            Text("We would be happy to get your feedback. Please write your feedback below.", style: TextStyle(fontSize: Dimensions.fifteen),textAlign: TextAlign.center,),
            SizedBox(height: Dimensions.height20,),
            CustomInputField(controller: feedbackController, icon: Icons.feedback, label: "Enter Your feedback", password: false, phoneNumber: false,maxLines: 4, isFor: 'Feedback',),
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
                    sendFeedback(feedbackController.text);
                    showToast("Feedback Sent Successfully");
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


