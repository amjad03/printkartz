import 'package:flutter/material.dart';
import 'package:Printzkart/constants/dimensions.dart';

import '../../constants/constants.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var color = Theme.of(context).brightness == Brightness.dark ? const Color(0xFF333333) : Colors.white;

    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        title: const Text("Privacy & Policy",style: TextStyle(fontFamily: 'Inter'),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(Dimensions.ten),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Privacy Policy for ${Strings.appTitle}",style: TextStyle(fontSize: Dimensions.eighteen,fontWeight: FontWeight.bold,fontFamily: 'Inter')),
              SizedBox(height: Dimensions.height10,),
              Text('At ${Strings.appTitle}, we are committed to protecting the privacy of our users. This Privacy Policy describes how we collect, use, and disclose information about you when you use our app ("${Strings.appTitle}").',style: TextStyle(fontSize: Dimensions.fifteen),textAlign: TextAlign.left,),
              const Divider(),
              SizedBox(height: Dimensions.height10,),
              Text("Information We Collect",style: TextStyle(fontSize: Dimensions.eighteen,fontWeight: FontWeight.w400,fontFamily: 'Inter')),
              SizedBox(height: Dimensions.height10,),
              Text('We collect certain information about you when you use the App,',style: TextStyle(fontSize: Dimensions.fifteen),textAlign: TextAlign.left,),
              SizedBox(height: Dimensions.height10,),
              Text('  We collect personal information such as your name, email address, phone number, and gender when you provide it to us voluntarily, when you interact with our App',style: TextStyle(fontSize: Dimensions.fifteen),textAlign: TextAlign.left,),
              const Divider(),
              SizedBox(height: Dimensions.height10,),
              Text("How We Use Your Information",style: TextStyle(fontSize: Dimensions.eighteen,fontWeight: FontWeight.w400,fontFamily: 'Inter')),
              SizedBox(height: Dimensions.height10,),
              Text('We use the personal information we collect to provide you with our services, to communicate with you, to improve our products and services, and to comply with legal obligations. We may also use your personal information to send you promotional materials, but only if you have given us your consent to do so.',style: TextStyle(fontSize: Dimensions.fifteen),textAlign: TextAlign.left,),
              const Divider(),
              SizedBox(height: Dimensions.height10,),
              Text("Security of Your Information",style: TextStyle(fontSize: Dimensions.eighteen,fontWeight: FontWeight.w400,fontFamily: 'Inter')),
              SizedBox(height: Dimensions.height10,),
              Text('We take reasonable measures to protect the personal information we collect from loss, theft, misuse, and unauthorized access, disclosure, alteration, and destruction.',style: TextStyle(fontSize: Dimensions.fifteen),textAlign: TextAlign.left,),
              const Divider(),
              SizedBox(height: Dimensions.height10,),
              Text("Your Rights:",style: TextStyle(fontSize: Dimensions.eighteen,fontWeight: FontWeight.w400,fontFamily: 'Inter')),
              SizedBox(height: Dimensions.height10,),
              Text('You have the right to access and correct your personal information, and to ask us to delete it in certain circumstances. You may also opt-out of receiving promotional communications from us at any time.',style: TextStyle(fontSize: Dimensions.fifteen),textAlign: TextAlign.left,),
              const Divider(),
              SizedBox(height: Dimensions.height10,),
              Text("Updates to Our Privacy Policy:",style: TextStyle(fontSize: Dimensions.eighteen,fontWeight: FontWeight.w400,fontFamily: 'Inter')),
              SizedBox(height: Dimensions.height10,),
              Text('We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy.',style: TextStyle(fontSize: Dimensions.fifteen),textAlign: TextAlign.left,),
              const Divider(),
              SizedBox(height: Dimensions.height10,),
              Text("Contact Us:",style: TextStyle(fontSize: Dimensions.eighteen,fontWeight: FontWeight.w400,fontFamily: 'Inter')),
              SizedBox(height: Dimensions.height10,),
              Text('If you have any questions about this Privacy Policy or our privacy practices, please contact us at ',style: TextStyle(fontSize: Dimensions.fifteen),textAlign: TextAlign.left,),
              Text(Strings.email,style: TextStyle(fontSize: Dimensions.fifteen,color: Colors.blue),textAlign: TextAlign.left,),

            ],
          ),
        ),
      ),
    );
  }
}
