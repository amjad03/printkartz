import 'package:Printzkart/repository/auth_repository.dart';
import 'package:Printzkart/screens/auth/sign_in.dart';
import 'package:Printzkart/screens/components/carousel/carousel_page.dart';
import 'package:Printzkart/screens/feedback&help/help.dart';
import 'package:Printzkart/screens/profile/profile.dart';
import 'package:Printzkart/screens/search_page.dart';
import 'package:Printzkart/services/shared_preferences_service.dart';
import 'package:Printzkart/widgets/show_message.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:Printzkart/screens/main_page.dart';
import 'package:Printzkart/theme/model_theme.dart';
import 'package:Printzkart/theme/theme.dart';
import 'package:provider/provider.dart';

import 'constants/dimensions.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ModelTheme(),
        child: Consumer<ModelTheme>(
            builder: (context, ModelTheme themeNotifier, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Printzkart',
                routes: {
                  // "/main": (context) => const MainPage(),
                  "/main": (context) => const LandingPage(),
                },
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeNotifier.isDark ? ThemeMode.light : ThemeMode.dark,
                // home: const MainPage(),
                home: const LandingPage(),
              );
            })
    );
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'Printzkart',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   home: const MainPage(),
    // );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key,});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  late bool loggedIn;

  void checkLoginStatus(){
    loggedIn = checkLoggedIn();
  }

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {

    var bgColor = Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade700 : Colors.white;
    var focusColor = Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                  // builder: (context) => const SearchPage()
                  builder: (context) => ChangeNotifierProvider(
                    create: (_) => FavoritesManager(),
                    child: SearchPage(),
                  ),
                )
            );
          },
          child: Container(
            // width: Dimensions.twoHundred,
            height: Dimensions.forty,
            decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(Dimensions.ten)
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.ten),
              child: TextField(
                // controller: _searchController,
                enabled: false,
                cursorColor: focusColor,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusColor: focusColor,
                  hintText: 'Search here...',
                  suffixIcon: const Icon(Icons.search,color: Colors.grey,
                    // onPressed: () => _search(_searchController.text.trim()),
                  ),
                ),
                // onChanged: (e) => _search(_searchController.text.trim()),
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: (){
                loggedIn ? Navigator.push(context, MaterialPageRoute(builder: (context) => const HelpScreen()))
                    : showToast("You are not logged in");
              },
              icon: const Icon(Icons.headset_mic)),
          !loggedIn ? TextButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
              },
              child: const Text("Login",style: TextStyle(color: Colors.white),)) : SizedBox(),
          // IconButton(onPressed: (){}, icon: Icon(Icons.account_cirilc))
          IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage(length: 0,)));
              },
              icon: const Icon(Icons.account_circle)
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Dimensions.ten),
          child: Column(
            children: [
              const CustomBannerSlider(),
              const Divider(),
              SizedBox(height: Dimensions.ten,),
              GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: Dimensions.ten,
                    crossAxisSpacing: Dimensions.ten
                  ),
                  // itemCount: 4,
                  shrinkWrap: true,
                  primary: false,
                  // itemBuilder: (context, index) {
                  //   return Container(
                  //     width: 300,
                  //     height: 200,
                  //     decoration: BoxDecoration(
                  //       gradient: LinearGradient(
                  //         begin: Alignment.topLeft,
                  //         end: Alignment.bottomRight,
                  //         colors: [Color(0xFF6187f9), Colors.lightBlueAccent],
                  //       ),
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     child: Text(
                  //       '',
                  //       style: TextStyle(fontSize: 20, color: Colors.white),
                  //     ),
                  //   );
                  // },
                children: const [
                  CustomCard(
                    icon: Icons.threed_rotation,
                    title: "3D Models",
                    colors: [
                      Color(0xFF6187f9),
                      Colors.lightBlueAccent
                    ],
                    pageIndex: 0,
                  ),
                  CustomCard(
                    icon: Icons.print,
                    title: "3D Printers",
                    colors: [
                      Colors.deepOrange,
                      Colors.orange
                    ],
                    pageIndex: 1,
                  ),
                  CustomCard(
                    icon: Icons.earbuds,
                    title: "Filaments",
                    colors: [
                      Colors.purple,
                      Colors.purpleAccent
                    ],
                    pageIndex: 2,
                  ),
                  CustomCard(
                    icon: Icons.play_circle_filled,
                    title: "Videos",
                    colors: [
                      Colors.pink,
                      Colors.pinkAccent
                    ],
                    pageIndex: 3,
                  ),
                  // GestureDetector(
                  //   onTap: (){
                  //     Navigator.push(context, MaterialPageRoute(builder: (context) => const MainPage(initialPage: 1,)));
                  //   },
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       gradient: const LinearGradient(
                  //         begin: Alignment.topLeft,
                  //         end: Alignment.bottomRight,
                  //         colors: [Colors.deepOrange, Colors.orange],
                  //       ),
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     child: Column(
                  //       children: [
                  //         Expanded(
                  //             child: Center(child: Icon(Icons.print, size: Dimensions.sixty,color: Colors.white,))
                  //         ),
                  //         SizedBox(height: Dimensions.fifteen,),
                  //         Text("3D Printers", style: TextStyle(fontSize: Dimensions.twenty, color: Colors.white),),
                  //         SizedBox(height: Dimensions.ten,),
                  //         const Icon(Icons.arrow_forward,color: Colors.white,),
                  //         SizedBox(height: Dimensions.fifteen,),
                  //       ],
                  //     )
                  //   ),
                  // ),
                  // GestureDetector(
                  //   onTap: (){
                  //     Navigator.push(context, MaterialPageRoute(builder: (context) => const MainPage(initialPage: 2,)));
                  //   },
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       gradient: const LinearGradient(
                  //         begin: Alignment.topLeft,
                  //         end: Alignment.bottomRight,
                  //         colors: [Colors.purple, Colors.purpleAccent],
                  //       ),
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     child: Column(
                  //       children: [
                  //         Expanded(
                  //             child: Center(child: Icon(Icons.earbuds, size: Dimensions.sixty,color: Colors.white,))
                  //         ),
                  //         SizedBox(height: Dimensions.fifteen,),
                  //         Text("3D Printer\nFilaments",textAlign: TextAlign.center, style: TextStyle(fontSize: Dimensions.twenty, color: Colors.white),),
                  //         SizedBox(height: Dimensions.ten,),
                  //         const Icon(Icons.arrow_forward,color: Colors.white,),
                  //         SizedBox(height: Dimensions.fifteen,),
                  //       ],
                  //     )
                  //   ),
                  // ),
                  // GestureDetector(
                  //   onTap: (){
                  //     Navigator.push(context, MaterialPageRoute(builder: (context) => const MainPage(initialPage: 3,)));
                  //   },
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       gradient: const LinearGradient(
                  //         begin: Alignment.topLeft,
                  //         end: Alignment.bottomRight,
                  //         colors: [Colors.pink, Colors.pinkAccent],
                  //       ),
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     child: Column(
                  //       children: [
                  //         Expanded(
                  //           child: Center(child: Icon(Icons.play_circle_filled, size: Dimensions.sixty,color: Colors.white,))
                  //         ),
                  //         SizedBox(height: Dimensions.fifteen,),
                  //         Text("Videos", style: TextStyle(fontSize: Dimensions.twenty, color: Colors.white),),
                  //         SizedBox(height: Dimensions.ten,),
                  //         const Icon(Icons.arrow_forward,color: Colors.white,),
                  //         SizedBox(height: Dimensions.fifteen,),
                  //       ],
                  //     )
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key, required this.icon, required this.title, required this.colors, required this.pageIndex,
  });

  final IconData icon;
  final String title;
  final int pageIndex;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        // Navigator.push(context, MaterialPageRoute(builder: (context) => const MainPage()));
        // print("clicked");
        // navigate;
        Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(initialPage: pageIndex,)));
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            // colors: [Color(0xFF6187f9), Colors.lightBlueAccent],
            colors: colors,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Expanded(
                child: Center(
                    child: Icon(icon, size: Dimensions.sixty,color: Colors.white,))
            ),
            // SizedBox(height: Dimensions.fifteen,),
            Text(title, style: TextStyle(fontSize: Dimensions.twenty, color: Colors.white),textAlign: TextAlign.center,),
            SizedBox(height: Dimensions.ten,),
            Divider(indent: Dimensions.fifteen, endIndent: Dimensions.fifteen, color: Colors.white,),
            const Icon(Icons.arrow_forward,color: Colors.white,),
            SizedBox(height: Dimensions.fifteen,),
          ],
        )
      ),
    );
  }
}
