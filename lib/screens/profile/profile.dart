import 'dart:convert';
import 'dart:math';

import 'package:Printzkart/main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Printzkart/constants/dimensions.dart';
import 'package:Printzkart/screens/settings.dart';
import 'package:Printzkart/screens/auth/sign_in.dart';
import 'package:Printzkart/screens/profile/edit_profile.dart';


import '../../constants/constants.dart';
import '../../repository/auth_repository.dart';
// import '../../services/shared_preference_service.dart';
import '../../services/shared_preferences_service.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/show_dialogue.dart';
import '../../widgets/show_message.dart';
import '../feedback&help/feedback.dart';
import '../main_page.dart';
import '../feedback&help/help.dart';
import '../policies/about.dart';
import '../policies/privacy_policy.dart';
import '../user_features/favorites.dart';



bool noData = false;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.showAppbar,}) : super(key: key);

  final bool showAppbar;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final List _randomColor = [];
  late Color color ;

  void _setRandomColor() {
    for(var i = 1;i<= 20;i++){
      setState(() {
        final random = Random();
        color = Color.fromRGBO(
          random.nextInt(256),
          random.nextInt(256),
          random.nextInt(256),
          1,
        );
        _randomColor.add(color);
      });
    }
  }

  Map<String, String> result = {};

  Future<Map<String, String>> getFromFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> favorites = jsonDecode(prefs.getString('data') ?? '{}');

    setState(() {
      favorites.forEach((key, value) {
        result[key] = value.toString();
      });
    });


    return result;
  }

  var lenFavorites = 0;
  var lenDownloads = 0;
  var lenShared = 0;
  var lenRecentlyViewed = 0;


  // void getLength() async {
  //   int lengthFav = await getSharedPrefsListLength('favorites');
  //   int lengthDownloads = await getSharedPrefsListLength('downloaded');
  //   int lengthShared = await getSharedPrefsListLength('shared');
  //   int lengthRecentlyViewed = await getSharedPrefsListLength('recentlyViewed');
  //
  //   // if(lengthRecentlyViewed == 0){
  //   //   setState(() {
  //   //     noData = true;
  //   //   });
  //   // }
  //
  //   setState(() {
  //     lenFavorites = lengthFav;
  //     lenDownloads = lengthDownloads;
  //     lenShared = lengthShared;
  //     lenRecentlyViewed = lengthRecentlyViewed;
  //   });
  // }
  // Future<int> getLengthOfRecentlyViewed() async {
  //   int lengthRecentlyViewed = await getSharedPrefsListLength('recentlyViewed');
  //   return lengthRecentlyViewed;
  // }

  // String? name = 'User Name';
  // String? email = 'user.email@gmail.com';

  // void getUserData()async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   name = prefs.getString('name');
  //   email = prefs.getString('email');
  // }

  @override
  void initState() {
    super.initState();
    _setRandomColor();
    getFromFavorites();
    // getLength();
    // getUserData();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  @override
  Widget build(BuildContext context) {

    final loggedIn = checkLoggedIn();

    var bgColor = Theme.of(context).brightness == Brightness.dark ? const Color(0xFF333333) : Colors.white;
    var color = Theme.of(context).brightness == Brightness.dark ? const Color(0xFF555555) : Colors.white;
    var shadowColor = Theme.of(context).brightness == Brightness.dark ? Colors.transparent : Colors.black38;


    goToMainPage(){
      // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const MainPage()), (Route<dynamic> route) => false);
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const LandingPage()), (Route<dynamic> route) => false);
    }

    // Future<void> deleteHistory(BuildContext context) async {
    //   return showDialog<void>(
    //     context: context,
    //     barrierDismissible: false, // user must tap button!
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: const Text('Do you want to delete history?'),
    //         content: const Text("You will loose the images which you have viewed recently",textAlign: TextAlign.center,),
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
    //                 onPressed: () {
    //                   DeleteWallpaperHandler deleteWallpaperHandler = DeleteWallpaperHandler();
    //                   deleteWallpaperHandler.clearRecentlyViewedList();
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

    // var lengthRecentlyViewed = getLengthOfRecentlyViewed();

    return Scaffold(
      backgroundColor: bgColor,
      // appBar: AppBar(
      //   title: const Text("Profile",style: TextStyle(fontFamily: 'Inter'),),
      //   centerTitle: true,
      //   actions: [
      //     IconButton(onPressed: () {
      //         Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
      //       },
      //       icon: const Icon(Icons.settings)
      //     ),
      //   ],
      // ),
      appBar: widget.showAppbar ? AppBar(
        title: const Text("Profile",style: TextStyle(fontFamily: 'Inter'),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
          },
              icon: const Icon(Icons.settings)
          ),
        ],
      ) : null,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(Dimensions.twenty),
          width: double.maxFinite,
          child: !loggedIn
          ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle
                    ),
                    child: Align(
                      alignment: Alignment.center,
                        child: Icon(Icons.person,size: Dimensions.fifty, color: Colors.white,),
                    )
                  ),
                  SizedBox(width: Dimensions.width20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customRoundedButton('Login', Icons.login, onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
                      })
                    ],
                  ),
                  SizedBox(height: Dimensions.width20,),

                ],
              ),
              SizedBox(height: Dimensions.height10,),
              Divider(color: AppColors.grey,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Dimensions.height10,),
                  Text("Why Choose Us",style: TextStyle(fontSize: Dimensions.fifteen,fontFamily: 'Inter',fontWeight: FontWeight.bold),),
                  SizedBox(height: Dimensions.fifteen,),
                  featuredPoints('Wide Selection of 3D Printers'),
                  featuredPoints('Extensive Model Library'),
                  featuredPoints('High-Quality Filaments'),
                  featuredPoints('Reliable Customer Support'),
                  featuredPoints('User-friendly interface'),
                ],
              ),
              Divider(color: AppColors.grey,),
              Container(
                padding: EdgeInsets.all(Dimensions.ten),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(Dimensions.radius12),
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor,
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],

                ),
                child: Column(
                  children: [
                    customListTiles(const FaIcon(FontAwesomeIcons.solidHeart), "Favorites", true, (){showToast("Your are not Logged in");}),
                    // customListTiles(const FaIcon(FontAwesomeIcons.download), "Downloads", true, (){showToast("Your are not Logged in");}),
                    // customListTiles(const FaIcon(FontAwesomeIcons.share), "Shared", true, (){showToast("Your are not Logged in");}),
                    customListTiles(const FaIcon(FontAwesomeIcons.message), "Feedback", false, (){showToast("Your are not Logged in");}),
                    customListTiles(const FaIcon(FontAwesomeIcons.circleQuestion), "Help", false, (){showToast("Your are not Logged in");}),
                    customListTile(const Icon(Icons.info), "About", false, "",(){ Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutPage())); }),
                    customListTiles(const FaIcon(FontAwesomeIcons.shield), "Privacy & Policy", false, (){ Navigator.push(context, MaterialPageRoute(builder: (context) => const PrivacyPolicy())); }),
                  ],
                ),
              )
            ],
          )
          : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle
                    ),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(currentUser?.displayName?.toString().substring(0,1) ?? 'U',style: TextStyle(fontSize: Dimensions.thirty,color: Colors.white),)),
                  ),
                  SizedBox(width: Dimensions.width20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(currentUser?.displayName ?? '',style: TextStyle(fontSize: Dimensions.twenty,fontFamily: 'Inter'),),
                      Text(currentUser?.email ?? '',style: TextStyle(fontSize: Dimensions.fifteen,fontFamily: 'Inter'),),
                    ],
                  ),
                  SizedBox(height: Dimensions.width20,),

                ],
              ),
              SizedBox(height: Dimensions.height10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  customRoundedButton('Logout', Icons.logout, onPressed: () {
                    // logout(context);
                    logOutDialogBox(context, goToMainPage());
                  }),
                  customRoundedButton('Edit Profile', Icons.edit, onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfileScreen()));
                  }),
                ],
              ),
              Divider(color: AppColors.grey,),
              SizedBox(height: Dimensions.fifteen,),
              Container(
                padding: EdgeInsets.all(Dimensions.ten),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(Dimensions.radius12),
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor,
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    customListTile(const FaIcon(FontAwesomeIcons.solidHeart), "Favorites", true, "" ,(){
                      if(checkLoggedIn()){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritesScreen()));
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => ChangeNotifierProvider(
                        //         create: (_) => FavoritesManager(),
                        //         child: FavoritesScreen(),
                        //       ),
                        //     )
                        // );
                      }
                      else{
                        showToast("You are not logged in");
                      }
                    }),
                    // customListTile(const FaIcon(FontAwesomeIcons.download), "Downloads", true,  lenDownloads.toString() ,(){ Navigator.push(context, MaterialPageRoute(builder: (context) => const DownloadsScreen())); }),
                    // customListTile(const FaIcon(FontAwesomeIcons.share), "Shared", true,  lenShared.toString() ,(){ Navigator.push(context, MaterialPageRoute(builder: (context) => const SharedScreen())); }),
                    customListTile(const FaIcon(FontAwesomeIcons.message), "Feedback", false, "",(){ Navigator.push(context, MaterialPageRoute(builder: (context) => const FeedbackScreen())); }),
                    customListTile(const FaIcon(FontAwesomeIcons.circleQuestion), "Help", false, "",(){ Navigator.push(context, MaterialPageRoute(builder: (context) => const HelpScreen())); }),
                    customListTile(const FaIcon(FontAwesomeIcons.info), "About", false, "",(){ Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutPage())); }),
                    customListTile(const FaIcon(FontAwesomeIcons.shield), "Privacy & Policy", false, "",(){ Navigator.push(context, MaterialPageRoute(builder: (context) => const PrivacyPolicy())); }),
                  ],
                ),
              )
            ],
          ) ,
        ),
      ),
    );
  }

  featuredPoints(String title){
    return Padding(
      padding: EdgeInsets.all(Dimensions.ten),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.circle_rounded,size: Dimensions.ten,),
          SizedBox(width: Dimensions.fifteen,),
          Text(title,style: TextStyle(fontSize: Dimensions.fifteen,fontWeight: FontWeight.w400),),
        ],
      ),
    );
  }

  customListTile(icon, String title, bool keep,String total, ontap){
    return Column(
      children: [
        ListTile(
          onTap: ontap,
          title: Text(title),
          leading: icon,
          trailing: keep ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(total,style: TextStyle(fontSize: Dimensions.fifteen),),
              SizedBox(width: Dimensions.ten,),
              const Icon(Icons.chevron_right_rounded)
            ],
          )
              : const Icon(Icons.chevron_right_rounded)
          ,
        ),
        const Divider(height: 0,color: Colors.grey,),
      ],
    );
  }

  customListTiles(FaIcon icon, String title, bool keep, ontap){
    return Column(
      children: [
        ListTile(
          onTap: ontap,
          title: Text(title),
          leading: icon,
          trailing: keep ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("-",style: TextStyle(fontSize: Dimensions.twenty),),
              SizedBox(width: Dimensions.ten,),
              const Icon(Icons.chevron_right_rounded)
            ],
          )
              : const Icon(Icons.chevron_right_rounded)
          ,
        ),
        const Divider(height: 0,color: Colors.grey,),
      ],
    );
  }
}

