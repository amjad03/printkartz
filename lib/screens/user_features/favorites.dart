// import 'dart:math';
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
// import '../../constants/dimensions.dart';
//
//
// // import '../../models/wallpaper_model.dart';
// import '../../repository/auth_repository.dart';
// // import '../../services/shared_preference_service.dart';
// import '../../widgets/show_message.dart';
// // import '../wallpaper_detailed_screen.dart';
//
//
// void addToFavorites(wallpapers, index) async{
//   // Wallpaper wallpaper = Wallpaper(
//   //     id: wallpapers[index].id,
//   //     imageUrl: wallpapers[index].imageUrl,
//   //     category: wallpapers[index].category,
//   //     likes: wallpapers[index].likes,
//   //     downloads: wallpapers[index].downloads,
//   //     views: wallpapers[index].views,
//   //     tags: wallpapers[index].tags
//   // );
//   //
//   // SetWallpaperHandler wallpaperHandler = SetWallpaperHandler(newWallpapers: wallpaper);
//   // wallpaperHandler.saveToFavorites();
// }
//
// void removeFromFavorites(id) async{
//   // DeleteWallpaperHandler deleteWallpaperHandler = DeleteWallpaperHandler();
//   // deleteWallpaperHandler.removeWallpaperFromFavorites(id);
// }
//
//
// int length = 0;
//
// class FavoritesScreen extends StatefulWidget {
//   @override
//   FavoritesScreenState createState() => FavoritesScreenState();
// }
//
// class FavoritesScreenState extends State<FavoritesScreen> {
//   List<Map<String, dynamic>> favorites = [];
//
//   @override
//   void initState() {
//     super.initState();
//     loadFavorites();
//   }
//
//   Future<void> loadFavorites() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? favoritesJson = prefs.getString('favorites');
//     if (favoritesJson != null) {
//       setState(() {
//         favorites = List<Map<String, dynamic>>.from(jsonDecode(favoritesJson));
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Favorites'),
//       ),
//       body: ListView.builder(
//         itemCount: favorites.length,
//         itemBuilder: (context, index) {
//           Map<String, dynamic> favorite = favorites[index];
//           return ListTile(
//             title: Text(favorite['name']),
//             subtitle: Text(favorite['description']),
//             // Add other fields as needed
//           );
//         },
//       ),
//     );
//   }
// }
//
//
// // class FavoritesScreen extends StatefulWidget {
// //   const FavoritesScreen({Key? key,}) : super(key: key);
// //
// //   @override
// //   State<FavoritesScreen> createState() => _FavoritesScreenState();
// // }
// //
// // class _FavoritesScreenState extends State<FavoritesScreen> {
// //   final random = Random();
// //
// //   var len = 0;
// //
// //   // void getLength() async{
// //   //   int lengthFav = await getSharedPrefsListLength('favorites');
// //   //   setState(() {
// //   //     len = lengthFav;
// //   //   });
// //   // }
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     // getLength();
// //   }
// //
// //   GlobalKey favoritesKey = GlobalKey();
// //
// //   @override
// //   Widget build(BuildContext context) {
// //
// //     var color = Theme.of(context).brightness == Brightness.dark ? const Color(0xFF333333) : Colors.white;
// //
// //     return Scaffold(
// //       backgroundColor: color,
// //       appBar: AppBar(
// //         title: const Text("Favorites",style: TextStyle(fontFamily: 'Inter'),),
// //         centerTitle: true,
// //       ),
// //       body: SingleChildScrollView(
// //         key: favoritesKey,
// //         child: Padding(
// //           padding: EdgeInsets.all(Dimensions.ten),
// //           child: Column(
// //             children: [
// //               Padding(
// //                 padding: EdgeInsets.symmetric(vertical: Dimensions.ten),
// //                 child: Row(
// //                   children: [
// //                     Text("Favorites",style: TextStyle(fontSize: Dimensions.twenty,fontFamily: 'Inter'),),
// //                     SizedBox(width: Dimensions.width10,),
// //                     Text('($len)',style: TextStyle(fontSize: Dimensions.twenty,fontFamily: 'Inter'),),
// //                   ],
// //                 ),
// //               ),
// //               const Divider(),
// //               // len != 0
// //               //     ? const FavoritesList()
// //               //     : SizedBox(
// //               //       width: Dimensions.threeHundred,
// //               //       height: Dimensions.fourHundred,
// //               //       child: Center(child: Text("You have not added any wallpapers to favorites",style: TextStyle(fontSize: Dimensions.twenty,height: 1.5),textAlign: TextAlign.center,),)
// //               // )
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// // }
//
// // class FavoritesList extends StatefulWidget {
// //   const FavoritesList({Key? key}) : super(key: key);
// //
// //   @override
// //   State<FavoritesList> createState() => _FavoritesListState();
// // }
// //
// // class _FavoritesListState extends State<FavoritesList> {
// //   final random = Random();
// //
// //
// //   // late Stream<List<Wallpaper>> _favoritesStream;
// //   // late GetWallpaperHandler _getWallpaperHandler;
// //
// //   final loggedIn = checkLoggedIn();
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     // _getWallpaperHandler = GetWallpaperHandler();
// //     // _favoritesStream = _getWallpaperHandler.getFavoritesStream();
// //   }
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return StreamBuilder<List<Wallpaper>>(
// //       stream: _favoritesStream,
// //       builder: (context, snapshot) {
// //         if (snapshot.hasError) {
// //           return Text('Error: ${snapshot.error}');
// //         }
// //
// //         if(snapshot.hasData) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return SizedBox(
// //               width: double.maxFinite,
// //               height: Dimensions.hundred,
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.center,
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   const CircularProgressIndicator(color: Colors.grey,),
// //                   SizedBox(height: Dimensions.thirty,),
// //                   const Text('Loading...'),
// //                 ],
// //               ),
// //             );
// //           }
// //
// //           final wallpapers = snapshot.data!;
// //           return GridView.builder(
// //               physics: const NeverScrollableScrollPhysics(),
// //               shrinkWrap: true,
// //               scrollDirection: Axis.vertical,
// //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //                 childAspectRatio: 2 / 4,
// //                 crossAxisCount: 3,
// //                 crossAxisSpacing: Dimensions.ten,
// //                 mainAxisSpacing: Dimensions.ten,
// //               ),
// //               itemCount: wallpapers.length,
// //               itemBuilder: (context, index) {
// //                 final wallpaper = wallpapers[index];
// //                 return GestureDetector(
// //                   onTap: () {
// //                     Navigator.push(
// //                         context,
// //                         MaterialPageRoute(builder: (context) =>
// //                             WallpaperDetailScreen(
// //                               imageUrl: wallpaper.imageUrl,
// //                               wallpapers: wallpapers,
// //                               index: index,
// //                             )
// //                         )
// //                     );
// //                   },
// //                   child: ClipRRect(
// //                       borderRadius: BorderRadius.circular(Dimensions.fifteen),
// //                       child: Stack(
// //                         fit: StackFit.expand,
// //                         children: [
// //                           Container(
// //                               color: Color.fromRGBO(
// //                                 random.nextInt(256),
// //                                 random.nextInt(256),
// //                                 random.nextInt(256),
// //                                 1,
// //                               ),
// //                               child: CachedNetworkImage(
// //                                 imageUrl: wallpaper.imageUrl,
// //                                 fit: BoxFit.cover,
// //                                 errorWidget: (BuildContext context, String error, dynamic _) {
// //                                   return Container(
// //                                     color: Color.fromRGBO(
// //                                       random.nextInt(256),
// //                                       random.nextInt(256),
// //                                       random.nextInt(256),
// //                                       1,
// //                                     ),
// //                                     child: const Center(
// //                                       child: Text("Error loading image"),
// //                                     ),
// //                                   );
// //                                 },
// //                                 placeholder: (BuildContext context, String url) {
// //                                   return Container(
// //                                     color: Color.fromRGBO(
// //                                       random.nextInt(256),
// //                                       random.nextInt(256),
// //                                       random.nextInt(256),
// //                                       1,
// //                                     ),
// //                                     child: const Center(
// //                                       child: CircularProgressIndicator(),
// //                                     ),
// //                                   );
// //                                 },
// //                               )
// //                               // Image.network(
// //                               //   wallpaper.imageUrl,
// //                               //   fit: BoxFit.cover,
// //                               //   errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
// //                               //     return Container(
// //                               //       color: Color.fromRGBO(
// //                               //         random.nextInt(256),
// //                               //         random.nextInt(256),
// //                               //         random.nextInt(256),
// //                               //         1,
// //                               //       ),
// //                               //       child: const Center(
// //                               //         child: Text("Loading..."),
// //                               //       ),
// //                               //     );
// //                               //   },
// //                               // )
// //                           ),
// //                           Align(
// //                             alignment: Alignment.topRight,
// //                             child: GestureDetector(
// //                               onTap: () async {
// //                                 if(loggedIn){
// //                                   removeFromFavorites(wallpaper.id);
// //                                   showToast("Successfully Removed");
// //                                   Navigator.of(context).pop();
// //                                   Navigator.of(context).pop();
// //                                 }else{
// //                                   showToast('You are not logged in');
// //                                 }
// //                               },
// //                               child: const Icon(Icons.delete,color: Colors.white,)
// //                             ),
// //                           )
// //                         ]
// //                       )
// //
// //                   ),
// //                 );
// //               });
// //         }
// //         else{
// //           return Center(
// //             child: Text("You have not added any wallpapers to favorites",style: TextStyle(fontSize: Dimensions.twenty,height: 1.5),textAlign: TextAlign.center,),
// //           );
// //         }
// //       },
// //     );
// //   }
// //
// //   void setValue(int length) {
// //     setState(() {
// //       length = length;
// //     });
// //   }
// // }
//
//
//

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
//
// class FavoritesScreen extends StatefulWidget {
//   @override
//   FavoritesScreenState createState() => FavoritesScreenState();
// }
//
// class FavoritesScreenState extends State<FavoritesScreen> {
//   List<Map<String, dynamic>> favorites = [];
//
//   @override
//   void initState() {
//     super.initState();
//     loadFavorites();
//   }
//
//   Future<void> loadFavorites() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? favoritesJson = prefs.getString('favorites');
//     if (favoritesJson != null) {
//       setState(() {
//         favorites = List<Map<String, dynamic>>.from(jsonDecode(favoritesJson));
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Favorites'),
//       ),
//       body: ListView.builder(
//         itemCount: favorites.length,
//         itemBuilder: (context, index) {
//           Map<String, dynamic> favorite = favorites[index];
//           return ListTile(
//             title: Text(favorite['name']),
//             subtitle: Text(favorite['description']),
//             // Add other fields as needed
//           );
//         },
//       ),
//     );
//   }
// }

import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../constants/dimensions.dart';
import '../../repository/auth_repository.dart';
import '../../services/shared_preferences_service.dart';
import '../../widgets/show_message.dart';
import '../detail_screens/detail_screen_for_3d_model.dart';
import '../detail_screens/detail_screen_for_filaments.dart';
import '../detail_screens/detail_screen_for_machine.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  FavoritesScreenState createState() => FavoritesScreenState();
}

class FavoritesScreenState extends State<FavoritesScreen> {
  List<Map<dynamic, dynamic>> favorites = [];
  // final favorites = [];

  @override
  void initState() {
    super.initState();
    loadFavorites();
    FavoritesManager.init();
  }

  Future<void> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // List<String>? favoritesJson = prefs.getStringList('favorites');
    // if (favoritesJson != null) {
    //   setState(() {
    //     favorites = favoritesJson
    //         .map((favorite) => jsonDecode(favorite))
    //         .toList()
    //         .cast<Map<String, dynamic>>();
    //   });
    // final favoritesList = FavoritesManager.getFromFavorite();
    // final favoritesList = FavoritesManager.getFavorites();
    // final favoritesList2 = FavoritesManager.getFavorite2();
    // final favoritesList2 = FavoritesManager.getFavorites();
    // setState(() {
    //   favorites.add(favoritesList2);
    //   // print(favoritesList2);
    // });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ChangeNotifierProvider(
              create: (_) => FavoritesManager(),
              child: FavoritesList(),
            ),
            // const FavoritesList(),
          ],
        ),
      ),
      // body:
      // ListView.builder(
      //   itemCount: favorites.length,
      //   itemBuilder: (context, index) {
      //     // Map<String, dynamic> favorite = favorites![index];
      //     return ListTile(
      //       title: Text(favorites[index]['name']),
      //       subtitle: Text(favorites[index]['color']),
      //       // Add other fields as needed
      //     );
      //   },
      // ),
    );
  }
}

class FavoritesList extends StatefulWidget {
  const FavoritesList({Key? key}) : super(key: key);

  @override
  State<FavoritesList> createState() => _FavoritesListState();
}

class _FavoritesListState extends State<FavoritesList> {
  final random = Random();


  late Stream<List> _favoritesStream;
  // late GetWallpaperHandler _getWallpaperHandler;

  final loggedIn = checkLoggedIn();

  @override
  void initState() {
    super.initState();
    // _getWallpaperHandler = GetWallpaperHandler();
    _favoritesStream = FavoritesManager.getFavoritesStream();
  }

  Future<void> removeFromFavorites(BuildContext context, item) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove From Favorites ?'),
          content: const Text("This item will be removed from favorites, and cannot be recovered",textAlign: TextAlign.center,),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: const Text('Cancel',style: TextStyle(color: Colors.grey),),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Confirm',style: TextStyle(color: Colors.grey),),
                  onPressed: () {
                    FavoritesManager.removeFromFavorites(item);
                    Navigator.of(context).pop();
                    FavoritesManager favoritesManager = FavoritesManager();
                    favoritesManager.notifyListeners();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {

    var shadowColor = Theme.of(context).brightness == Brightness.dark ? Colors.transparent : Colors.black38;
    var cardColor = Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade700 : Colors.white;

    return Consumer<FavoritesManager>(
      builder: (context, favoritesNotifier, _) {
        return Padding(
          padding: EdgeInsets.all(Dimensions.ten),
          child: StreamBuilder<List>(
            stream: _favoritesStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if(snapshot.hasData) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    width: double.maxFinite,
                    height: Dimensions.hundred,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(color: Colors.grey,),
                        SizedBox(height: Dimensions.thirty,),
                        const Text('Loading...'),
                      ],
                    ),
                  );
                }

                final items = snapshot.data!;
                return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 2/2.5,
                      crossAxisCount: 2,
                      crossAxisSpacing: Dimensions.ten,
                      mainAxisSpacing: Dimensions.ten,
                    ),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return GestureDetector(
                        onTap: () {
                          if(item['tags'][0] == "3d filament"){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreenForFilament(
                                id: 'id',
                                name: item['name'],
                                description: item['description'],
                                displayImage: item['displayImage'],
                                imageGallery: item['imageGallery'],
                                brand: item['brand'],
                                modelNumber: item['modelNumber'],
                                color: item['color'],
                                material: item['material'],
                                printTempRange: item['printTempRange'],
                                compatibleWith: item['compatibleWith'],
                                length: item['length'],
                                filamentDiameter: item['filamentDiameter'],
                                filamentWeight: item['filamentWeight'],
                                tags: item['tags']
                            )));
                          }
                          else if(item['tags'][0] == "3d printer"){
                            double actualPrice = double.parse(item['actualPrice'].toString());
                            double salePrice = double.parse(item['salePrice'].toString());

                            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(
                                name: item['name'],
                                actualPrice: actualPrice,
                                salePrice: salePrice,
                                description: item['description'],
                                displayImage: item['imageGallery'][0],
                                imageGallery: item['imageGallery'],
                                color: item['color'],
                                printingSpeed: item['printingSpeed'],
                                autoCalibration: item['autoCalibration'],
                                printingTechnology: item['printingTechnology'],
                                bedType: item['bedType'],
                                sdCardSupported: item['sdCardSupported'],
                                buildVolume: item['buildVolume'],
                                powerConsumption: item['powerConsumption'],
                                nozzleDiameter: item['nozzleDiameter'],
                                filamentDiameter: item['filamentDiameter'],
                                height: item['height'],
                                width: item['width'],
                                weight: item['weight'],
                                warrantySummary: item['warrantySummary'],
                                serviceType: item['serviceType'],
                                coveredInWarranty: item['coveredInWarranty'],
                                notCoveredInWarranty: item['notCoveredInWarranty'],
                                tags: item['tags']
                            )));
                          }
                          else if(item['tags'][0] == "3d model"){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreenFor3dModel(
                                name: item['name'],
                                description: item['description'],
                                modelFileUrl: item['modelFileUrl'],
                                thumbnailUrl: item['displayImage'],
                                imageGallery: item['imageGallery'],
                                tags: item['tags'],
                                author: item['author'],
                                dateUploaded: item['dateUploaded'],
                                category: item['category']
                            )));
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.ten),
                              boxShadow: [
                                BoxShadow(
                                  // color: Colors.black38,
                                    color: shadowColor,
                                    blurRadius: Dimensions.five
                                )
                              ]
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(Dimensions.ten),
                            child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: cardColor,
                                      // border: Border.all(
                                      //   color: Colors.black38,
                                      //   width: 2.0
                                      // ),
                                      // image: DecorationImage(
                                      //   image: CachedNetworkImageProvider(_machines[index].displayImage),
                                      //     // CachedNetworkImage(
                                      //     //   imageUrl: _machines[index].displayImage,
                                      //     // )
                                      // )
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(Dimensions.ten),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // SizedBox(
                                          //   width: double.maxFinite,
                                          //   height: Dimensions.hundred,
                                          //   child: CachedNetworkImage(
                                          //     imageUrl: _machines[index].displayImage.toString(),
                                          //     fit: BoxFit.cover,
                                          //   ),
                                          // ),
                                          Expanded(
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(Dimensions.five),
                                              child: CachedNetworkImage(
                                                imageUrl: item['displayImage'] ?? item['imageGallery'][0],
                                                fit: BoxFit.cover,
                                                errorWidget: (BuildContext context, String error, dynamic _) {
                                                  return Container(
                                                    color: Color.fromRGBO(
                                                      random.nextInt(256),
                                                      random.nextInt(256),
                                                      random.nextInt(256),
                                                      1,
                                                    ),
                                                    child: const Center(
                                                      child: Text("Error loading image"),
                                                    ),
                                                  );
                                                },
                                                placeholder: (BuildContext context, String url) {
                                                  return Container(
                                                    color: Color.fromRGBO(
                                                      random.nextInt(256),
                                                      random.nextInt(256),
                                                      random.nextInt(256),
                                                      1,
                                                    ),
                                                    child: const Center(
                                                      child: CircularProgressIndicator(),
                                                    ),
                                                  );
                                                },
                                              )
                                            ),
                                          ),
                                          // SizedBox(height: Dimensions.ten,),
                                          SizedBox(height: Dimensions.five,),
                                          Text(item['name'], style: TextStyle(fontSize: Dimensions.twenty, fontWeight: FontWeight.w400),maxLines: 1, overflow: TextOverflow.ellipsis,),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Container(
                                  //   decoration: BoxDecoration(
                                  //     borderRadius: BorderRadius.circular(10),
                                  //     color: cardColor,
                                  //     // border: Border.all(
                                  //     //   color: Colors.black38,
                                  //     //   width: 2.0
                                  //     // ),
                                  //     // image: DecorationImage(
                                  //     //   image: CachedNetworkImageProvider(_machines[index].displayImage),
                                  //     //     // CachedNetworkImage(
                                  //     //     //   imageUrl: _machines[index].displayImage,
                                  //     //     // )
                                  //     // )
                                  //   ),
                                  //   child: Padding(
                                  //     padding: EdgeInsets.all(Dimensions.ten),
                                  //     child: Column(
                                  //       crossAxisAlignment: CrossAxisAlignment.start,
                                  //       children: [
                                  //         // SizedBox(
                                  //         //   width: double.maxFinite,
                                  //         //   height: Dimensions.hundred,
                                  //         //   child: CachedNetworkImage(
                                  //         //     imageUrl: _machines[index].displayImage.toString(),
                                  //         //     fit: BoxFit.cover,
                                  //         //   ),
                                  //         // ),
                                  //         Expanded(
                                  //           child: ClipRRect(
                                  //             borderRadius: BorderRadius.circular(Dimensions.five),
                                  //             child: CachedNetworkImage(
                                  //                       imageUrl: item['displayImage'] ?? item['imageGallery'][0],
                                  //                       fit: BoxFit.cover,
                                  //                       errorWidget: (BuildContext context, String error, dynamic _) {
                                  //                         return Container(
                                  //                           color: Color.fromRGBO(
                                  //                             random.nextInt(256),
                                  //                             random.nextInt(256),
                                  //                             random.nextInt(256),
                                  //                             1,
                                  //                           ),
                                  //                           child: const Center(
                                  //                             child: Text("Error loading image"),
                                  //                           ),
                                  //                         );
                                  //                       },
                                  //                       placeholder: (BuildContext context, String url) {
                                  //                         return Container(
                                  //                           color: Color.fromRGBO(
                                  //                             random.nextInt(256),
                                  //                             random.nextInt(256),
                                  //                             random.nextInt(256),
                                  //                             1,
                                  //                           ),
                                  //                           child: const Center(
                                  //                             child: CircularProgressIndicator(),
                                  //                           ),
                                  //                         );
                                  //                       },
                                  //                     )
                                  //           ),
                                  //         ),
                                  //         SizedBox(height: Dimensions.ten,),
                                  //         Text(item['name'], style: TextStyle(fontSize: Dimensions.twenty, fontWeight: FontWeight.w400),maxLines: 1, overflow: TextOverflow.ellipsis,),
                                  //         // SizedBox(height: Dimensions.ten,),
                                  //
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                  Positioned(
                                      width: Dimensions.forty,
                                      height: Dimensions.forty,
                                      right: Dimensions.five,
                                      top: Dimensions.five,
                                      child: GestureDetector(
                                        onTap: () {
                                          // FavoritesManager.removeFromFavorites(item);
                                          removeFromFavorites(context, item);
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(Dimensions.fifty),
                                                // color: cardColor
                                                color: Colors.white,
                                                boxShadow: const [
                                                  BoxShadow(
                                                      color: Colors.grey,
                                                      blurRadius: 3
                                                  )
                                                ]
                                            ),
                                            child: Icon(Icons.delete)
                                        ),
                                      )
                                  ),


                                  // index.isEven
                                  //   ? Positioned(
                                  //     // width: Dimensions.forty,
                                  //     // height: Dimensions.forty,
                                  //     left: Dimensions.five,
                                  //     top: Dimensions.five,
                                  //     child: Container(
                                  //       decoration: BoxDecoration(
                                  //           borderRadius: BorderRadius.circular(Dimensions.five),
                                  //           color: Colors.green
                                  //       ),
                                  //       child: Padding(
                                  //         padding: EdgeInsets.all(Dimensions.five),
                                  //         child: Center(child: Text("free",style: TextStyle(color: Colors.white,fontSize: Dimensions.fifteen,fontWeight: FontWeight.w300),)),
                                  //       ),
                                  //     )
                                  // )
                                  //   : Positioned(
                                  //     // width: Dimensions.forty,
                                  //     // height: Dimensions.twenty,
                                  //     left: Dimensions.five,
                                  //     top: Dimensions.five,
                                  //     child: Container(
                                  //       decoration: BoxDecoration(
                                  //           borderRadius: BorderRadius.circular(Dimensions.five),
                                  //           color: Colors.orange
                                  //       ),
                                  //       child: Padding(
                                  //         padding: EdgeInsets.all(Dimensions.five),
                                  //         child: Center(child: Text("paid",style: TextStyle(color: Colors.white,fontSize: Dimensions.fifteen,fontWeight: FontWeight.w300),)),
                                  //       ),
                                  //     )
                                  // ) ,
                                ]
                            ),
                          ),
                          // ClipRRect(
                          //     borderRadius: BorderRadius.circular(Dimensions.fifteen),
                          //     child: Stack(
                          //         fit: StackFit.expand,
                          //         children: [
                          //           Container(
                          //               color: Color.fromRGBO(
                          //                 random.nextInt(256),
                          //                 random.nextInt(256),
                          //                 random.nextInt(256),
                          //                 1,
                          //               ),
                          //               child: CachedNetworkImage(
                          //                 imageUrl: item['displayImage'] ?? item['imageGallery'][0],
                          //                 fit: BoxFit.cover,
                          //                 errorWidget: (BuildContext context, String error, dynamic _) {
                          //                   return Container(
                          //                     color: Color.fromRGBO(
                          //                       random.nextInt(256),
                          //                       random.nextInt(256),
                          //                       random.nextInt(256),
                          //                       1,
                          //                     ),
                          //                     child: const Center(
                          //                       child: Text("Error loading image"),
                          //                     ),
                          //                   );
                          //                 },
                          //                 placeholder: (BuildContext context, String url) {
                          //                   return Container(
                          //                     color: Color.fromRGBO(
                          //                       random.nextInt(256),
                          //                       random.nextInt(256),
                          //                       random.nextInt(256),
                          //                       1,
                          //                     ),
                          //                     child: const Center(
                          //                       child: CircularProgressIndicator(),
                          //                     ),
                          //                   );
                          //                 },
                          //               )
                          //             // Image.network(
                          //             //   wallpaper.imageUrl,
                          //             //   fit: BoxFit.cover,
                          //             //   errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                          //             //     return Container(
                          //             //       color: Color.fromRGBO(
                          //             //         random.nextInt(256),
                          //             //         random.nextInt(256),
                          //             //         random.nextInt(256),
                          //             //         1,
                          //             //       ),
                          //             //       child: const Center(
                          //             //         child: Text("Loading..."),
                          //             //       ),
                          //             //     );
                          //             //   },
                          //             // )
                          //           ),
                          //           Positioned(
                          //               width: Dimensions.forty,
                          //               height: Dimensions.forty,
                          //               right: Dimensions.five,
                          //               top: Dimensions.five,
                          //               child: GestureDetector(
                          //                 onTap: () {
                          //
                          //                 },
                          //                 child: Container(
                          //                     decoration: BoxDecoration(
                          //                         borderRadius: BorderRadius.circular(Dimensions.fifty),
                          //                         // color: cardColor
                          //                         color: Colors.white,
                          //                         boxShadow: const [
                          //                           BoxShadow(
                          //                               color: Colors.grey,
                          //                               blurRadius: 3
                          //                           )
                          //                         ]
                          //                     ),
                          //                     child: Icon(Icons.delete)
                          //                 ),
                          //               )
                          //           ),
                          //           // Align(
                          //           //   alignment: Alignment.topRight,
                          //           //   child: GestureDetector(
                          //           //       onTap: () async {
                          //           //         // if(loggedIn){
                          //           //         //   removeFromFavorites(wallpaper.id);
                          //           //         //   showToast("Successfully Removed");
                          //           //         //   Navigator.of(context).pop();
                          //           //         //   Navigator.of(context).pop();
                          //           //         // }else{
                          //           //         //   showToast('You are not logged in');
                          //           //         // }
                          //           //       },
                          //           //       child: Container(
                          //           //         decoration: BoxDecoration(
                          //           //             borderRadius: BorderRadius.circular(Dimensions.fifty),
                          //           //             color: Colors.white,
                          //           //             boxShadow: const [
                          //           //               BoxShadow(
                          //           //                   color: Colors.grey,
                          //           //                   blurRadius: 3
                          //           //               )
                          //           //             ]
                          //           //         ),
                          //           //           child: const Icon(Icons.delete,color: Colors.white,)
                          //           //       )
                          //           //   ),
                          //           // )
                          //         ]
                          //     )
                          //
                          // ),
                        ),
                      );
                    });
              }
              else{
                return Center(
                  child: Text("You have not added any wallpapers to favorites",style: TextStyle(fontSize: Dimensions.twenty,height: 1.5),textAlign: TextAlign.center,),
                );
              }
            },
          ),
        );
      }
    );
  }

  void setValue(int length) {
    setState(() {
      length = length;
    });
  }
}