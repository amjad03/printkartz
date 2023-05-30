import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:printzkart/repository/auth_repository.dart';
import 'package:printzkart/screens/detail_screens/detail_screen_for_3d_model.dart';
import 'package:printzkart/services/data_service.dart';
import 'package:printzkart/widgets/show_message.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/dimensions.dart';
import '../../models/threeDmodels_model.dart';
import '../../services/shared_preferences_service.dart';
import '../detail_screens/detail_screen_for_machine.dart';

class ModelsPage extends StatefulWidget {
  const ModelsPage({Key? key}) : super(key: key);

  @override
  State<ModelsPage> createState() => _ModelsPageState();
}

class _ModelsPageState extends State<ModelsPage> {

  List<ThreeDObjectsModel> models = [];
  bool isLoading = false;

  void loadModels() async{
    DataService dataService = DataService();
    List<ThreeDObjectsModel> _models = await dataService.getModelsData();
    setState(() {
      models = _models;
      isLoading = false;
    });
  }

  void addModelDataToFirestore() async {
    try {
      // Create a Firestore collection reference
      CollectionReference productsRef = FirebaseFirestore.instance.collection('models');

      var name = "Black Statue";
      var description = "this is a digital model or design. It is a versatile tool used in various industries such as manufacturing, prototyping, engineering, design, architecture, medicine, and education.";
      var modelFileUrl = "dummy";
      var displayImage = "https://firebasestorage.googleapis.com/v0/b/printzkart-flutter.appspot.com/o/models%2F02b694d65213fecd7972ae2f82358e18.jpg?alt=media&token=3b461963-13ab-40aa-bfd6-4eccb950bb2a";
      var dateUploaded = "13-05-2023";
      var author = "Alex";
      var category = "free";
      var imageGallery = [
        "https://firebasestorage.googleapis.com/v0/b/printzkart-flutter.appspot.com/o/models%2F02b694d65213fecd7972ae2f82358e18.jpg?alt=media&token=3b461963-13ab-40aa-bfd6-4eccb950bb2a",
        "https://firebasestorage.googleapis.com/v0/b/printzkart-flutter.appspot.com/o/models%2F02b694d65213fecd7972ae2f82358e18.jpg?alt=media&token=3b461963-13ab-40aa-bfd6-4eccb950bb2a",
        "https://firebasestorage.googleapis.com/v0/b/printzkart-flutter.appspot.com/o/models%2F02b694d65213fecd7972ae2f82358e18.jpg?alt=media&token=3b461963-13ab-40aa-bfd6-4eccb950bb2a",
      ];
      var tags = ["3d printer","black","FDM","8kg","printer","aluminium","step"];

      // Create a new document in the "products" collection
      await productsRef.add({
        'name': name,
        'description': description,
        'modelFileUrl': modelFileUrl,
        'displayImage': displayImage,
        'imageGallery': imageGallery,
        'tags': tags,
        'author': author,
        'dateUploaded': dateUploaded,
        'category': category
      });

      print('Data added to Firestore successfully!');
    } catch (e) {
      print('Error adding data to Firestore: $e');
    }
  }


  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    loadModels();
    FavoritesManager.init();
  }

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black;
    var cardColor = Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade700 : Colors.white;
    var shadowColor = Theme.of(context).brightness == Brightness.dark ? Colors.transparent : Colors.black38;
    var discountBadgeColor = Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade800 : Colors.redAccent.shade400;
    // return ChangeNotifierProvider(
    //   create: (_) => FavoritesManager(),
    //   child: Consumer<FavoritesManager>(
    //       builder: (context, favoritesNotifier, _) {
    //         // Use favoritesNotifier.favoriteItems to check if an item is favorited
    //         // bool isFavorite = FavoritesManager.checkIfFavoriteExists(
    //         //     models[index].name);
    //         // bool isFavorite = FavoritesManager.checkIfFavoriteExists(models[index].name);
    //
    //         return Scaffold(
    //           body: Stack(
    //               children: [
    //                 isLoading
    //                 ? SizedBox(
    //                   width: double.infinity,
    //                   height: double.infinity,
    //                   child: Center(
    //                     child: CircularProgressIndicator(
    //                       color: color,
    //                     ),
    //                   ),
    //                 )
    //                 : Container(),
    //                 SingleChildScrollView(
    //                   child: Column(
    //                     children: [
    //                       SizedBox(height: Dimensions.ten,),
    //                       Text("3d Models",
    //                         style: TextStyle(fontSize: Dimensions.thirty),
    //                         textAlign: TextAlign.center,),
    //                       const Divider(),
    //                       Padding(
    //                         padding: const EdgeInsets.all(10),
    //                         child: GridView.builder(
    //                             primary: false,
    //                             shrinkWrap: true,
    //                             scrollDirection: Axis.vertical,
    //                             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //                                 childAspectRatio: 2 / 2.5,
    //                                 crossAxisCount: 2,
    //                                 crossAxisSpacing: Dimensions.fifteen,
    //                                 mainAxisSpacing: Dimensions.fifteen
    //                             ),
    //                             itemCount: models.length,
    //                             itemBuilder: (context, index) {
    //                               final exists = FavoritesManager
    //                                   .checkIfFavoriteExists(models[index].name);
    //                               bool isExists = false;
    //
    //                               if (exists == true) {
    //                                 isExists = true;
    //                               }
    //                               else {
    //                                 isExists = false;
    //                               }
    //
    //                               return GestureDetector(
    //                                 onTap: () {
    //                                   // Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(
    //                                   //       modelUrl: models[index].modelUrl,
    //                                   //       itemCategory: models[index].category,
    //                                   //       itemName: models[index].name,
    //                                   //       itemImage: models[index].displayImage,
    //                                   //       isMachine: false,
    //                                   //       isModel: true,
    //                                   //       isFilament: false,
    //                                   //     )
    //                                   //   )
    //                                   // );
    //                                   Navigator.push(context,
    //                                       MaterialPageRoute(builder: (context) =>
    //                                           DetailScreenFor3dModel(
    //                                               name: models[index].name,
    //                                               description: models[index]
    //                                                   .description,
    //                                               modelFileUrl: models[index]
    //                                                   .modelFileUrl,
    //                                               thumbnailUrl: models[index]
    //                                                   .displayImage,
    //                                               imageGallery: models[index]
    //                                                   .imageGallery,
    //                                               tags: models[index].tags,
    //                                               author: models[index].author,
    //                                               dateUploaded: models[index]
    //                                                   .dateUploaded,
    //                                               category: models[index].category
    //                                           )
    //                                       )
    //                                   );
    //                                 },
    //                                 child: Container(
    //                                   decoration: BoxDecoration(
    //                                       borderRadius: BorderRadius.circular(
    //                                           Dimensions.ten),
    //                                       boxShadow: [
    //                                         BoxShadow(
    //                                             color: shadowColor,
    //                                             blurRadius: Dimensions.five
    //                                         )
    //                                       ]
    //                                   ),
    //                                   child: ClipRRect(
    //                                     borderRadius: BorderRadius.circular(
    //                                         Dimensions.ten),
    //                                     child: Stack(
    //                                         fit: StackFit.expand,
    //                                         children: [
    //                                           Container(
    //                                             decoration: BoxDecoration(
    //                                               borderRadius: BorderRadius
    //                                                   .circular(10),
    //                                               color: cardColor,
    //                                               // border: Border.all(
    //                                               //   color: Colors.black38,
    //                                               //   width: 2.0
    //                                               // ),
    //                                               // image: DecorationImage(
    //                                               //   image: CachedNetworkImageProvider(_machines[index].displayImage),
    //                                               //     // CachedNetworkImage(
    //                                               //     //   imageUrl: _machines[index].displayImage,
    //                                               //     // )
    //                                               // )
    //                                             ),
    //                                             child: Padding(
    //                                               padding: EdgeInsets.all(
    //                                                   Dimensions.ten),
    //                                               child: Column(
    //                                                 crossAxisAlignment: CrossAxisAlignment
    //                                                     .start,
    //                                                 children: [
    //                                                   // SizedBox(
    //                                                   //   width: double.maxFinite,
    //                                                   //   height: Dimensions.hundred,
    //                                                   //   child: CachedNetworkImage(
    //                                                   //     imageUrl: _machines[index].displayImage.toString(),
    //                                                   //     fit: BoxFit.cover,
    //                                                   //   ),
    //                                                   // ),
    //                                                   Expanded(
    //                                                     child: ClipRRect(
    //                                                       borderRadius: BorderRadius
    //                                                           .circular(
    //                                                           Dimensions.five),
    //                                                       child: CachedNetworkImage(
    //                                                         imageUrl: models[index]
    //                                                             .displayImage
    //                                                             .toString(),
    //                                                         fit: BoxFit.cover,
    //                                                       ),
    //                                                     ),
    //                                                   ),
    //                                                   // SizedBox(height: Dimensions.ten,),
    //                                                   SizedBox(
    //                                                     height: Dimensions.five,),
    //                                                   Text(models[index].name,
    //                                                     style: TextStyle(
    //                                                         fontSize: Dimensions
    //                                                             .twenty,
    //                                                         fontWeight: FontWeight
    //                                                             .w400),
    //                                                     maxLines: 1,
    //                                                     overflow: TextOverflow
    //                                                         .ellipsis,),
    //                                                   // SizedBox(height: Dimensions.five,),
    //                                                   Row(
    //                                                     children: [
    //                                                       Text("Author : ",
    //                                                         style: TextStyle(
    //                                                           fontSize: Dimensions
    //                                                               .fifteen,
    //                                                           fontWeight: FontWeight
    //                                                               .w300,),
    //                                                         maxLines: 1,
    //                                                         overflow: TextOverflow
    //                                                             .ellipsis,),
    //                                                       Text(
    //                                                         models[index].author,
    //                                                         style: TextStyle(
    //                                                           fontSize: Dimensions
    //                                                               .fifteen,
    //                                                           fontWeight: FontWeight
    //                                                               .w400,),
    //                                                         maxLines: 1,
    //                                                         overflow: TextOverflow
    //                                                             .ellipsis,),
    //                                                     ],
    //                                                   )
    //                                                 ],
    //                                               ),
    //                                             ),
    //                                           ),
    //                                           Positioned(
    //                                               width: Dimensions.forty,
    //                                               height: Dimensions.forty,
    //                                               right: Dimensions.five,
    //                                               top: Dimensions.five,
    //                                               child: GestureDetector(
    //                                                 onTap: () async {
    //                                                   Map<String,
    //                                                       dynamic> itemMap = models[index]
    //                                                       .toJson();
    //                                                   await FavoritesManager
    //                                                       .saveToFavorites(
    //                                                       itemMap);
    //                                                   // print(itemMap);
    //                                                 },
    //                                                 child: Container(
    //                                                     decoration: BoxDecoration(
    //                                                         borderRadius: BorderRadius
    //                                                             .circular(
    //                                                             Dimensions.fifty),
    //                                                         color: Colors.white,
    //                                                         boxShadow: const [
    //                                                           BoxShadow(
    //                                                               color: Colors
    //                                                                   .grey,
    //                                                               blurRadius: 3
    //                                                           )
    //                                                         ]
    //                                                     ),
    //                                                     child: isExists ? Icon(
    //                                                       Icons.favorite,
    //                                                       color: Colors.red,
    //                                                       size: Dimensions
    //                                                           .thirty,) : Icon(
    //                                                       Icons.favorite_outline,
    //                                                       color: Colors.red,
    //                                                       size: Dimensions
    //                                                           .thirty,)
    //                                                 ),
    //                                               )
    //                                           ),
    //                                           Positioned(
    //                                             // width: Dimensions.forty,
    //                                             // height: Dimensions.forty,
    //                                               left: Dimensions.five,
    //                                               top: Dimensions.five,
    //                                               child: Container(
    //                                                 decoration: BoxDecoration(
    //                                                     borderRadius: BorderRadius
    //                                                         .circular(
    //                                                         Dimensions.five),
    //                                                     color: models[index]
    //                                                         .category == "free"
    //                                                         ? Colors.green
    //                                                         : Colors.orange
    //                                                 ),
    //                                                 child: Padding(
    //                                                   padding: EdgeInsets.all(
    //                                                       Dimensions.five),
    //                                                   child: Center(child: Text(
    //                                                     models[index].category,
    //                                                     style: TextStyle(
    //                                                         color: Colors.white,
    //                                                         fontSize: Dimensions
    //                                                             .fifteen,
    //                                                         fontWeight: FontWeight
    //                                                             .w300),)),
    //                                                 ),
    //                                               )
    //                                           )
    //                                           // index.isEven
    //                                           //   ? Positioned(
    //                                           //     // width: Dimensions.forty,
    //                                           //     // height: Dimensions.forty,
    //                                           //     left: Dimensions.five,
    //                                           //     top: Dimensions.five,
    //                                           //     child: Container(
    //                                           //       decoration: BoxDecoration(
    //                                           //           borderRadius: BorderRadius.circular(Dimensions.five),
    //                                           //           color: Colors.green
    //                                           //       ),
    //                                           //       child: Padding(
    //                                           //         padding: EdgeInsets.all(Dimensions.five),
    //                                           //         child: Center(child: Text("free",style: TextStyle(color: Colors.white,fontSize: Dimensions.fifteen,fontWeight: FontWeight.w300),)),
    //                                           //       ),
    //                                           //     )
    //                                           // )
    //                                           //   : Positioned(
    //                                           //     // width: Dimensions.forty,
    //                                           //     // height: Dimensions.twenty,
    //                                           //     left: Dimensions.five,
    //                                           //     top: Dimensions.five,
    //                                           //     child: Container(
    //                                           //       decoration: BoxDecoration(
    //                                           //           borderRadius: BorderRadius.circular(Dimensions.five),
    //                                           //           color: Colors.orange
    //                                           //       ),
    //                                           //       child: Padding(
    //                                           //         padding: EdgeInsets.all(Dimensions.five),
    //                                           //         child: Center(child: Text("paid",style: TextStyle(color: Colors.white,fontSize: Dimensions.fifteen,fontWeight: FontWeight.w300),)),
    //                                           //       ),
    //                                           //     )
    //                                           // ) ,
    //                                         ]
    //                                     ),
    //                                   ),
    //                                 ),
    //                               );
    //                             }
    //                         ),
    //                       ),
    //                       Visibility(
    //                         visible: !isLoading ? true : false,
    //                         child: Padding(
    //                           padding: EdgeInsets.all(Dimensions.ten),
    //                           child: SizedBox(
    //                             width: double.infinity,
    //                             height: Dimensions.fifty,
    //                             child: ElevatedButton(
    //                                 onPressed: () {
    //                                   // launchURL("https://www.printzkart.in/shop");
    //                                   var url = Uri.parse(
    //                                       "https://www.printzkart.in/shop");
    //                                   launchUrl(url);
    //                                 },
    //                                 child: const Text("View All Models")
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                       SizedBox(height: Dimensions.ten,),
    //                     ],
    //                   ),
    //                 ),
    //               ]
    //           ),
    //           // floatingActionButton: FloatingActionButton(
    //           //   onPressed: (){
    //           //     addModelDataToFirestore();
    //           //   },
    //           //   child: Text("3d"),
    //           // ),
    //         );
    //       }
    //   ),
    // );
    return Scaffold(
      body: Consumer<FavoritesManager>(
        builder: (context, favoritesNotifier, _) {
          return Stack(
              children: [
                isLoading
                ? SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: color,
                    ),
                  ),
                )
                : Container(),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: Dimensions.ten,),
                      Text("3d Models",
                        style: TextStyle(fontSize: Dimensions.thirty),
                        textAlign: TextAlign.center,),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: GridView.builder(
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 2 / 2.5,
                                crossAxisCount: 2,
                                crossAxisSpacing: Dimensions.fifteen,
                                mainAxisSpacing: Dimensions.fifteen
                            ),
                            itemCount: models.length,
                            itemBuilder: (context, index) {
                              final exists = FavoritesManager
                                  .checkIfFavoriteExists(models[index].name);
                              bool isExists = false;

                              if (exists == true) {
                                isExists = true;
                              }
                              else {
                                isExists = false;
                              }

                              return GestureDetector(
                                onTap: () {
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(
                                  //       modelUrl: models[index].modelUrl,
                                  //       itemCategory: models[index].category,
                                  //       itemName: models[index].name,
                                  //       itemImage: models[index].displayImage,
                                  //       isMachine: false,
                                  //       isModel: true,
                                  //       isFilament: false,
                                  //     )
                                  //   )
                                  // );
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) =>
                                          DetailScreenFor3dModel(
                                              name: models[index].name,
                                              description: models[index]
                                                  .description,
                                              modelFileUrl: models[index]
                                                  .modelFileUrl,
                                              thumbnailUrl: models[index]
                                                  .displayImage,
                                              imageGallery: models[index]
                                                  .imageGallery,
                                              tags: models[index].tags,
                                              author: models[index].author,
                                              dateUploaded: models[index]
                                                  .dateUploaded,
                                              category: models[index].category
                                          )
                                      )
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.ten),
                                      boxShadow: [
                                        BoxShadow(
                                            color: shadowColor,
                                            blurRadius: Dimensions.five
                                        )
                                      ]
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.ten),
                                    child: Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius
                                                  .circular(10),
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
                                              padding: EdgeInsets.all(
                                                  Dimensions.ten),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
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
                                                      borderRadius: BorderRadius
                                                          .circular(
                                                          Dimensions.five),
                                                      child: CachedNetworkImage(
                                                        imageUrl: models[index]
                                                            .displayImage
                                                            .toString(),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  // SizedBox(height: Dimensions.ten,),
                                                  SizedBox(
                                                    height: Dimensions.five,),
                                                  Text(models[index].name,
                                                    style: TextStyle(
                                                        fontSize: Dimensions
                                                            .twenty,
                                                        fontWeight: FontWeight
                                                            .w400),
                                                    maxLines: 1,
                                                    overflow: TextOverflow
                                                        .ellipsis,),
                                                  // SizedBox(height: Dimensions.five,),
                                                  Row(
                                                    children: [
                                                      Text("Author : ",
                                                        style: TextStyle(
                                                          fontSize: Dimensions
                                                              .fifteen,
                                                          fontWeight: FontWeight
                                                              .w300,),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,),
                                                      Text(models[index].author,
                                                        style: TextStyle(
                                                          fontSize: Dimensions
                                                              .fifteen,
                                                          fontWeight: FontWeight
                                                              .w400,),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                              width: Dimensions.forty,
                                              height: Dimensions.forty,
                                              right: Dimensions.five,
                                              top: Dimensions.five,
                                              child: GestureDetector(
                                                onTap: () async {
                                                  if(checkLoggedIn()){
                                                    if(isExists){
                                                      final item = models[index].toJson();
                                                      FavoritesManager.removeFromFavorites(item);
                                                      favoritesNotifier.notifyListeners();
                                                    }
                                                    else {
                                                      Map<String, dynamic> itemMap = models[index].toJson();
                                                      await FavoritesManager.saveToFavorites(itemMap);
                                                      favoritesNotifier.notifyListeners();
                                                    }
                                                  }
                                                  else{
                                                    showToast("You are not logged in");
                                                  }

                                                  // print(itemMap);
                                                },
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius
                                                            .circular(
                                                            Dimensions.fifty),
                                                        color: Colors.white,
                                                        boxShadow: const [
                                                          BoxShadow(
                                                              color: Colors
                                                                  .grey,
                                                              blurRadius: 3
                                                          )
                                                        ]
                                                    ),
                                                    child: isExists
                                                        ? Icon(Icons.favorite,
                                                      color: Colors.red,
                                                      size: Dimensions.thirty,)
                                                        : Icon(
                                                      Icons.favorite_outline,
                                                      color: Colors.red,
                                                      size: Dimensions.thirty,)
                                                ),
                                              )
                                          ),
                                          Positioned(
                                            // width: Dimensions.forty,
                                            // height: Dimensions.forty,
                                              left: Dimensions.five,
                                              top: Dimensions.five,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius
                                                        .circular(
                                                        Dimensions.five),
                                                    color: models[index]
                                                        .category == "free"
                                                        ? Colors.green
                                                        : Colors.orange
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(
                                                      Dimensions.five),
                                                  child: Center(child: Text(
                                                    models[index].category,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: Dimensions
                                                            .fifteen,
                                                        fontWeight: FontWeight
                                                            .w300),)),
                                                ),
                                              )
                                          )
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
                                ),
                              );
                            }
                        ),
                      ),
                      Visibility(
                        visible: !isLoading ? true : false,
                        child: Padding(
                          padding: EdgeInsets.all(Dimensions.ten),
                          child: SizedBox(
                            width: double.infinity,
                            height: Dimensions.fifty,
                            child: ElevatedButton(
                                onPressed: () {
                                  // launchURL("https://www.printzkart.in/shop");
                                  var url = Uri.parse(
                                      "https://www.printzkart.in/shop");
                                  launchUrl(url);
                                },
                                child: const Text("View All Models")
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Dimensions.ten,),
                    ],
                  ),
                ),
              ]
          );
        }
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){
      //     addModelDataToFirestore();
      //   },
      //   child: Text("3d"),
      // ),
    );
  }
}
