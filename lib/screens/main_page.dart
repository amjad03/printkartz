import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Printzkart/screens/feedback&help/help.dart';
import 'package:Printzkart/screens/profile/profile.dart';
import 'package:Printzkart/screens/search_page.dart';
import 'package:Printzkart/screens/tabs/VideosPage.dart';
import 'package:Printzkart/screens/tabs/filaments_page.dart';
import 'package:Printzkart/screens/tabs/machines_page.dart';
import 'package:Printzkart/screens/tabs/models_page.dart';
import 'package:Printzkart/screens/tabs/profile_page.dart';
import 'package:Printzkart/services/shared_preferences_service.dart';
import 'package:Printzkart/widgets/show_message.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../constants/dimensions.dart';
import '../repository/auth_repository.dart';
import 'auth/sign_in.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.initialPage}) : super(key: key);

  final int initialPage;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  // final _searchController = TextEditingController();
  // int _selectedIndex = 0;
  late int _selectedIndex;
  late bool loggedIn;

  final List<Widget> _screens = [
    ChangeNotifierProvider(
      create: (_) => FavoritesManager(),
      child: ModelsPage(),
    ),
    ChangeNotifierProvider(
      create: (_) => FavoritesManager(),
      child: MachinesPage(),
    ),
    ChangeNotifierProvider(
      create: (_) => FavoritesManager(),
      child: FilamentsPage(),
    ),
    // const ModelsPage(),
    // const MachinesPage(),
    // const FilamentsPage(),
    // const ProfilePage(),
    const VideosPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _search(String searchText) async {
    // WallpaperService wallpaperService = WallpaperService();
    // List<Wallpaper> wallpapers = await wallpaperService.getSearchedWallpapers(searchText);
    // setState(() {
    //   _wallpapers = wallpapers;
    // });
  }

  void checkLoginStatus(){
    loggedIn = checkLoggedIn();
  }

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    _selectedIndex = widget.initialPage;
  }

  @override
  Widget build(BuildContext context) {


    var bgColor = Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade700 : Colors.white;
    var focusColor = Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black;
    var unselectedColor = Theme.of(context).brightness == Brightness.dark ? Colors.grey : Colors.black26;

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
          // GestureDetector(
          //   onTap: (){
          //     Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage(length: 0,)));
          //   },
          //   child: Padding(
          //     padding: EdgeInsets.only(right: Dimensions.ten),
          //     child: const Icon(Icons.account_circle)
          //     // Image(
          //     //   image: AssetImage(AppIcons.profileActive),
          //     //   width: Dimensions.thirty,
          //     //   height: Dimensions.thirty,
          //     // ),
          //   ),
          // ),
        ],
      ),
      body: _screens[_selectedIndex],
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: (){
      //     addDataToFirestore();
      //   },
      // ),
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Colors.grey,
        selectedFontSize: Dimensions.ten,
        iconSize: Dimensions.thirty,
        selectedItemColor: focusColor,
        unselectedItemColor: unselectedColor,
        items: const [
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.threed_rotation),
              // Image(
              //   image: AssetImage(AppIcons.modelActive),
              //   width: Dimensions.thirty,
              //   height: Dimensions.thirty,
              // ),
              icon: Icon(Icons.threed_rotation),
              // Image(
              //   image: AssetImage(AppIcons.model),
              //   width: Dimensions.thirty,
              //   height: Dimensions.thirty,
              // ),
              label: '3d Models',
              tooltip: '3d Models'
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.print),
            // Image(
            //   image: AssetImage(AppIcons.printerActive),
            //   width: Dimensions.thirty,
            //   height: Dimensions.thirty,
            // ),
            icon: Icon(Icons.local_print_shop_outlined),
            // Image(
            //   image: AssetImage(AppIcons.printer),
            //   width: Dimensions.thirty,
            //   height: Dimensions.thirty,
            // ),
            label: 'Machines',
            tooltip: 'Machines',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.earbuds),
            // Image(
            //   image: AssetImage(AppIcons.filamentActive),
            //   width: Dimensions.thirty,
            //   height: Dimensions.thirty,
            // ),
            icon: Icon(Icons.earbuds_outlined),
            // Image(
            //   image: AssetImage(AppIcons.filament),
            //   width: Dimensions.thirty,
            //   height: Dimensions.thirty,
            // ),
            label: 'Filaments',
            tooltip: 'Filaments',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.play_arrow),
            // Image(
            //   image: AssetImage(AppIcons.videosActive),
            //   width: Dimensions.thirty,
            //   height: Dimensions.thirty,
            // ),
            icon: Icon(Icons.play_arrow_outlined),
            // Image(
            //   image: AssetImage(AppIcons.videos),
            //   width: Dimensions.thirty,
            //   height: Dimensions.thirty,
            // ),
            label: 'Videos',
            tooltip: 'Videos',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
