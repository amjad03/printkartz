import 'package:flutter/material.dart';
import 'package:printzkart/constants/constants.dart';
import 'package:printzkart/constants/dimensions.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).brightness == Brightness.dark ? const Color(0xFF333333) : Colors.white;

    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        title: const Text("About",style: TextStyle(fontFamily: 'Inter'),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(Dimensions.ten),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('About Us - 3D Printing Company In Bangalore',style: TextStyle(fontSize: Dimensions.twenty),textAlign: TextAlign.left,),
              Divider(),
              SizedBox(height: Dimensions.ten,),
              Text('    3D ${Strings.appTitle}, a revolutionary additive manufacturing product development studio envisions making product development more efficient through modern-day technologies and a problem-solving approach.',style: TextStyle(fontSize: Dimensions.fifteen),textAlign: TextAlign.left,),
              SizedBox(height: Dimensions.ten,),
              Text('    Started in 2018 as an OEM for Industrial grade and academic grade 3D Printing Company In Bangalore, today they function more profoundly as a 3D printing studio in the heart of Bangalore-The startup hub of India.',style: TextStyle(fontSize: Dimensions.fifteen),textAlign: TextAlign.left,),
              SizedBox(height: Dimensions.ten,),
              Text('    ${Strings.appTitle} has evolved into one of the pioneer product development studios for startups and major technology-oriented brands in India and also has its foothold in the export market for manufacturing-related technologies.',style: TextStyle(fontSize: Dimensions.fifteen),textAlign: TextAlign.left,),
              SizedBox(height: Dimensions.ten,),
              Text('    With a mission to become a market leader in the segment, the organization help technology companies and start-ups feasibly ideate and execute their goals and build optimized products for their go-to-market.',style: TextStyle(fontSize: Dimensions.fifteen),textAlign: TextAlign.left,),
              SizedBox(height: Dimensions.ten,),
              Text('    3D ${Strings.appTitle} aims to do its part in building an incredible startup ecosystem in India. Whether it be ideation, design, conceptualizing, reverse engineering, or R&D, it provides effective services, to help companies grow in their respective arenas.',style: TextStyle(fontSize: Dimensions.fifteen),textAlign: TextAlign.left,),
              SizedBox(height: Dimensions.ten,),
              Text('    Thank you for choosing "${Strings.appTitle}". We hope you enjoy using our app as much as we enjoy creating it. If you have any feedback or suggestions, please don\'t hesitate to reach out to us - we\'re always happy to hear from our users!',style: TextStyle(fontSize: Dimensions.fifteen),textAlign: TextAlign.left,),
              SizedBox(height: Dimensions.ten,),
              Text('Sincerely, "${Strings.appTitle}" Team',style: TextStyle(fontSize: Dimensions.twenty),textAlign: TextAlign.left,),

            ],
          ),
        ),
      ),
    );
  }
}
