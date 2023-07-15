
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Printzkart/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/dimensions.dart';
import '../../services/send_message_service.dart';
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

  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  final fontWeight = FontWeight.w400;


  void sendHelp(help) async {
    setState(() {
      isLoading = true;
    });
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
    sendHelpEmail(help, user?.email);

    // send(help);

    setState(() {
      isLoading = false;
    });
    // Navigator.of(context).pop();
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
    var iconColor = Theme.of(context).brightness == Brightness.dark ? Colors.grey : Colors.black45;


    final name = user?.displayName;
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        title: const Text("Help",style: TextStyle(fontFamily: 'Inter'),),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(Dimensions.height20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: Dimensions.height20,),
                  Text("Hi, $name\n ", style: TextStyle(fontSize: Dimensions.twenty),textAlign: TextAlign.center,),
                  Text("We are always here for you. Please ask for any queries you have, we will try to figure it out as soon as possible.", style: TextStyle(fontSize: Dimensions.fifteen),textAlign: TextAlign.center,),
                  SizedBox(height: Dimensions.height20,),
                  // CustomInputField(controller: helpController, icon: Icons.help, label: "What help you need", password: false, phoneNumber: false,maxLines: 4, isFor: 'Help',),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.all(Dimensions.ten),
                      child: TextFormField(
                        controller: helpController,
                        textAlign: TextAlign.start,
                        cursorColor: Colors.grey,
                        keyboardType: TextInputType.text,
                        maxLines: 4,
                        decoration: InputDecoration(
                          focusColor: Colors.grey,
                          contentPadding: EdgeInsets.all(Dimensions.fifteen),
                          label: const Text("What help you need"),
                          prefixIcon: const Icon(
                            Icons.help,
                            color: Colors.grey,
                          ),
                          border: const OutlineInputBorder(),
                          iconColor: iconColor,
                          labelStyle: TextStyle(color: iconColor),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2, color: iconColor),
                          ),
                        ),
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return "This field is required";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ),
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
                          if(_formKey.currentState!.validate()) {
                            sendHelp(helpController.text);
                          }
                          // showToast("Successfully received, we will resolve your help as soon as possible");
                          // Navigator.of(context).pop();
                        },
                        child: Text("Submit",style: TextStyle(color: Colors.white,fontSize: Dimensions.fifteen,fontFamily: 'Inter'),),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.twenty,),
                  const Divider(),
                  SizedBox(height: Dimensions.ten,),
                  // SizedBox(height: Dimensions.twenty)
                  Align(
                    alignment: Alignment.center,
                    child: Text("FAQ's",style: TextStyle(fontSize: Dimensions.twenty,fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(height: Dimensions.ten,),
                  const Divider(),
                  customExpansionTile(
                      "How do I contact the company to purchase a 3D printer?",
                      "You can easily contact the company from the above displayed number. You will find the contact information and a form to send your inquiry."
                  ),
                  customExpansionTile(
                      "Can I download 3D models from the app?",
                      "Absolutely! Our app provides a wide range of 3D models available for download. Simply browse through the collection, select the models you like, and download them directly to your device."
                  ),
                  customExpansionTile(
                      "Are the 3D models compatible with all types of 3D printers?",
                      "Yes, our 3D models are designed to be compatible with a variety of 3D printers. However, it's essential to check the file format and specifications of the model to ensure it is compatible with your specific printer."
                  ),
                  customExpansionTile(
                      "How can I purchase 3D filaments in the app?",
                      "Purchasing 3D filaments is quick and convenient in our app. Simply navigate to the \"Filaments\" section, browse the available options, select the desired filaments, and proceed to the checkout. We offer secure online payment options for a hassle-free purchase experience."
                  ),
                  customExpansionTile(
                      "What payment methods are accepted for online purchases?",
                      "We accept various online payment methods, including credit cards, debit cards, and popular digital wallets like PayPal and Google Pay. Rest assured that all transactions are securely processed to protect your financial information."
                  ),
                  customExpansionTile(
                      "Do you offer international shipping?",
                      "Yes, we offer international shipping to select countries. During the checkout process, you can enter your shipping address, and the app will provide the available shipping options and associated costs for your location."
                  ),
                  customExpansionTile(
                      "What if I encounter any issues with my purchase or need assistance?",
                      "We're here to help! If you encounter any issues or need assistance, please reach out to our customer support team via the above mentioned phone number. Our dedicated support staff will promptly assist you with any concerns you may have."
                  ),
                  // ExpansionTile(
                  //   title: Text('How do I contact the company to purchase a 3D printer?',style: TextStyle(fontWeight: fontWeight),),
                  //   children: [
                  //     Padding(
                  //       padding: EdgeInsets.symmetric(horizontal: Dimensions.twenty),
                  //       child: Text("You can easily contact the company from the above displayed number. You will find the contact information and a form to send your inquiry."),
                  //     ),
                  //     SizedBox(height: Dimensions.fifteen)
                  //   ],
                  // ),
                  // const ExpansionTile(
                  //   title: Text('Can I download 3D models from the app?',style: TextStyle(fontWeight: FontWeight.bold),),
                  //   children: [
                  //     Text("Absolutely! Our app provides a wide range of 3D models available for download. Simply browse through the collection, select the models you like, and download them directly to your device.")
                  //   ],
                  // ),
                  // const ExpansionTile(
                  //   title: Text('Are the 3D models compatible with all types of 3D printers?',style: TextStyle(fontWeight: FontWeight.bold),),
                  //   children: [
                  //     Text("Yes, our 3D models are designed to be compatible with a variety of 3D printers. However, it's essential to check the file format and specifications of the model to ensure it is compatible with your specific printer.")
                  //   ],
                  // ),
                  // const ExpansionTile(
                  //   title: Text('How can I purchase 3D filaments in the app?',style: TextStyle(fontWeight: FontWeight.bold),),
                  //   children: [
                  //     Text("Purchasing 3D filaments is quick and convenient in our app. Simply navigate to the \"Filaments\" section, browse the available options, select the desired filaments, and proceed to the checkout. We offer secure online payment options for a hassle-free purchase experience.")
                  //   ],
                  // ),
                  // const ExpansionTile(
                  //   title: Text('What payment methods are accepted for online purchases?',style: TextStyle(fontWeight: FontWeight.bold),),
                  //   children: [
                  //     Text("We accept various online payment methods, including credit cards, debit cards, and popular digital wallets like PayPal and Google Pay. Rest assured that all transactions are securely processed to protect your financial information.")
                  //   ],
                  // ),
                  // const ExpansionTile(
                  //   title: Text('Do you offer international shipping?',style: TextStyle(fontWeight: FontWeight.bold),),
                  //   children: [
                  //     Text("Yes, we offer international shipping to select countries. During the checkout process, you can enter your shipping address, and the app will provide the available shipping options and associated costs for your location.")
                  //   ],
                  // ),
                  // const ExpansionTile(
                  //   title: Text('What if I encounter any issues with my purchase or need assistance?',style: TextStyle(fontWeight: FontWeight.bold),),
                  //   children: [
                  //     Text("We're here to help! If you encounter any issues or need assistance, please reach out to our customer support team via the above mentioned phone number. Our dedicated support staff will promptly assist you with any concerns you may have.")
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
          if (isLoading)
            const Opacity(
              opacity: 0.4,
              child: ModalBarrier(dismissible: false, color: Colors.black),
            ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
        ]
      ),
    );
  }

  ExpansionTile customExpansionTile(title, body){
    var color = Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black;
    return ExpansionTile(
      // collapsedTextColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
      // collapsedIconColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
      iconColor: Theme.of(context).brightness == Brightness.dark ? Colors.grey : Colors.black,

      title: Text(title,style: TextStyle(fontWeight: fontWeight,color: color),),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.twenty),
          child: Text(body),
        ),
        SizedBox(height: Dimensions.fifteen)
      ],
    );
  }
}


