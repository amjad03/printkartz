import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:printzkart/repository/auth_repository.dart';
import 'package:printzkart/screens/detail_screens/detail_screen_for_3d_model.dart';
import 'package:printzkart/screens/detail_screens/detail_screen_for_filaments.dart';
import 'package:printzkart/screens/detail_screens/detail_screen_for_machine.dart';
import 'package:provider/provider.dart';

import '../constants/dimensions.dart';
import '../services/data_service.dart';
import '../services/shared_preferences_service.dart';
import '../widgets/show_message.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {


  final _searchController = TextEditingController();
  bool isLoading = false;
  var discount;
  var formattedActualPrice;
  var formattedSalePrice;

  List result = [];

  void _search(String searchText) async {
    DataService dataService = DataService();
    List _result = await dataService.getSearchResult(searchText);
    setState(() {
      result = _result;
      result.shuffle(Random());
      result.shuffle(Random());
      result.shuffle(Random());
      isLoading = false;
    });
    print("\n\n${result.length}");
  }

  // void _load(){
  //
  // }

  @override
  void initState() {
    super.initState();
    // _load();
    setState(() {
      isLoading = true;
    });
    _search("DEX N");
    FavoritesManager.init();
  }

  @override
  Widget build(BuildContext context) {

    // var color = Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black;
    var color = Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black;
    var cardColor = Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade700 : Colors.white;
    var shadowColor = Theme.of(context).brightness == Brightness.dark ? Colors.transparent : Colors.black38;
    var discountBadgeColor = Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade800 : Colors.redAccent.shade400;

    // print(result[0]);

    return Scaffold(
      appBar: AppBar(
        title: Container(
          // width: Dimensions.twoHundred,
          height: Dimensions.forty,
          decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(Dimensions.ten)
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.ten),
            child: TextField(
              controller: _searchController,
              // enabled: false,
              // cursorColor: Colors.black,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusColor: Colors.black,
                hintText: 'Search here...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search,color: Colors.grey,),
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                    });
                   _search(_searchController.text.trim());
                  }
                ),
              ),
              onChanged: (e) => _search(_searchController.text.trim()),
            ),
          ),
        ),
      ),
      body: Consumer<FavoritesManager>(
        builder: (context, favoritesNotifier, _) {
          return Stack(
            children: [
              isLoading
              ?
            SizedBox(
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
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.ten),
                  child: GridView.builder(
                    primary: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 2/2.5,
                        crossAxisCount: 2,
                        crossAxisSpacing: Dimensions.fifteen,
                        mainAxisSpacing: Dimensions.fifteen
                    ),
                    itemCount: result.length,
                    itemBuilder: (context, index) {
                      if(result[index]['salePrice'] != null){
                        var actualPrice = result[index]['actualPrice'].toDouble() ??
                            0.0;
                        var salePrice = result[index]['salePrice'].toDouble() ?? 0.0;
                        var res = ((actualPrice - salePrice) / actualPrice) * 100;
                        discount = res.toInt();

                        var formatter = NumberFormat('#,###');
                        formattedActualPrice = formatter.format(actualPrice);
                        formattedSalePrice = formatter.format(salePrice);
                      }
                      //
                      // var formatter = NumberFormat('#,###');
                      // var formattedActualPrice = formatter.format(actualPrice);
                      // var formattedSalePrice = formatter.format(salePrice);
                      final exists = FavoritesManager.checkIfFavoriteExists(result[index]['name']);
                      bool isExists = false;

                      if(exists == true){
                        isExists = true;
                      }
                      else{
                        isExists = false;
                      }
                      return GestureDetector(
                        onTap: (){
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreenFor3dModel(
                          //     name: models[index].name,
                          //     description: models[index].description,
                          //     modelFileUrl: models[index].modelFileUrl,
                          //     thumbnailUrl: models[index].displayImage,
                          //     imageGallery: models[index].imageGallery,
                          //     tags: models[index].tags,
                          //     author: models[index].author,
                          //     dateUploaded: models[index].dateUploaded,
                          //     category: models[index].category
                          // )
                          // )
                          // );
                          if(result[index]['tags'][0] == "3d filament"){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreenForFilament(
                                id: 'id',
                                name: result[index]['name'],
                                description: result[index]['description'],
                                displayImage: result[index]['displayImage'],
                                imageGallery: result[index]['imageGallery'],
                                brand: result[index]['brand'],
                                modelNumber: result[index]['modelNumber'],
                                color: result[index]['color'],
                                material: result[index]['material'],
                                printTempRange: result[index]['printTempRange'],
                                compatibleWith: result[index]['compatibleWith'],
                                length: result[index]['length'],
                                filamentDiameter: result[index]['filamentDiameter'],
                                filamentWeight: result[index]['filamentWeight'],
                                tags: result[index]['tags']
                            )));
                          }
                          else if(result[index]['tags'][0] == "3d printer"){
                            double actualPrice = double.parse(result[index]['actualPrice'].toString());
                            double salePrice = double.parse(result[index]['salePrice'].toString());

                            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(
                                name: result[index]['name'],
                                actualPrice: actualPrice,
                                salePrice: salePrice,
                                description: result[index]['description'],
                                displayImage: result[index]['imageGallery'][0],
                                imageGallery: result[index]['imageGallery'],
                                color: result[index]['color'],
                                printingSpeed: result[index]['printingSpeed'],
                                autoCalibration: result[index]['autoCalibration'],
                                printingTechnology: result[index]['printingTechnology'],
                                bedType: result[index]['bedType'],
                                sdCardSupported: result[index]['sdCardSupported'],
                                buildVolume: result[index]['buildVolume'],
                                powerConsumption: result[index]['powerConsumption'],
                                nozzleDiameter: result[index]['nozzleDiameter'],
                                filamentDiameter: result[index]['filamentDiameter'],
                                height: result[index]['height'],
                                width: result[index]['width'],
                                weight: result[index]['weight'],
                                warrantySummary: result[index]['warrantySummary'],
                                serviceType: result[index]['serviceType'],
                                coveredInWarranty: result[index]['coveredInWarranty'],
                                notCoveredInWarranty: result[index]['notCoveredInWarranty'],
                                tags: result[index]['tags']
                            )));
                          }
                          else if(result[index]['tags'][0] == "3d model"){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreenFor3dModel(
                                name: result[index]['name'],
                                description: result[index]['description'],
                                modelFileUrl: result[index]['modelFileUrl'],
                                thumbnailUrl: result[index]['displayImage'],
                                imageGallery: result[index]['imageGallery'],
                                tags: result[index]['tags'],
                                author: result[index]['author'],
                                dateUploaded: result[index]['dateUploaded'],
                                category: result[index]['category']
                            )));
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.ten),
                              boxShadow: [
                                BoxShadow(
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
                                                imageUrl: result[index]['displayImage'] ?? result[index]['imageGallery'][0],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: Dimensions.ten,),
                                          Text(result[index]['name'], style: TextStyle(fontSize: Dimensions.twenty, fontWeight: FontWeight.w400),maxLines: 1, overflow: TextOverflow.ellipsis,),
                                          SizedBox(height: Dimensions.ten,),
                                          result[index]['author'] != null
                                            ?
                                              Row(
                                                children: [
                                                  Text("Author : ", style: TextStyle(fontSize: Dimensions.fifteen, fontWeight: FontWeight.w300, color: Colors.black38),maxLines: 1, overflow: TextOverflow.ellipsis,),
                                                  Text(result[index]['author'], style: TextStyle(fontSize: Dimensions.fifteen, fontWeight: FontWeight.w400, color: Colors.black54),maxLines: 1, overflow: TextOverflow.ellipsis,),
                                                ],
                                              )
                                            : Container(),
                                          result[index]['salePrice'] != null
                                            ?
                                              Row(
                                                children: [
                                                  Text(formattedActualPrice.toString(),style: TextStyle(fontSize: Dimensions.fifteen, fontWeight: FontWeight.w400, color: Colors.black38, decoration: TextDecoration.lineThrough),),
                                                  Text(" ₹$formattedSalePrice/-",style: TextStyle(fontSize: Dimensions.eighteen, fontWeight: FontWeight.bold),),
                                                ],
                                              )
                                            : Container(),
                                          // Row(
                                          //   children: [
                                          //     Text(formattedActualPrice.toString(),style: TextStyle(fontSize: Dimensions.fifteen, fontWeight: FontWeight.w400, color: Colors.black38, decoration: TextDecoration.lineThrough),),
                                          //     Text(" ₹$formattedSalePrice/-",style: TextStyle(fontSize: Dimensions.eighteen, fontWeight: FontWeight.bold),),
                                          //     Text("Author : ", style: TextStyle(fontSize: Dimensions.fifteen, fontWeight: FontWeight.w300, color: Colors.black38),maxLines: 1, overflow: TextOverflow.ellipsis,),
                                          //     Text(result[index]['author'], style: TextStyle(fontSize: Dimensions.fifteen, fontWeight: FontWeight.w400, color: Colors.black54),maxLines: 1, overflow: TextOverflow.ellipsis,),
                                          //   ],
                                          // )
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
                                      onTap: () async{
                                        if(checkLoggedIn()){
                                          if(isExists){
                                            final item = result[index];
                                            FavoritesManager.removeFromFavorites(item);
                                            favoritesNotifier.notifyListeners();
                                          }
                                          else {
                                            Map<String, dynamic> itemMap = result[index];
                                            await FavoritesManager.saveToFavorites(itemMap);
                                            favoritesNotifier.notifyListeners();
                                          }
                                        }
                                        else{
                                          showToast("You are not logged in");
                                        }
                                        // // Map<String, dynamic> map = Map<String, dynamic>.from(result[index]);
                                        // // final jsonData = jsonEncode(result[index]);
                                        //
                                        // await FavoritesManager.saveToFavorites(result[index]);

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
                                            // child: Icon(Icons.favorite_outline,color: Colors.red,size: Dimensions.thirty,)
                                          child: isExists ? Icon(Icons.favorite,color: Colors.red,size: Dimensions.thirty,) : Icon(Icons.favorite_outline,color: Colors.red,size: Dimensions.thirty,)
                                      ),
                                    ),
                                  ),
                                  result[index]['category'] != null
                                  ? Positioned(
                                    // width: Dimensions.forty,
                                    // height: Dimensions.forty,
                                      left: Dimensions.five,
                                      top: Dimensions.five,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(Dimensions.five),
                                            color: result[index]['category'] == "free" ?Colors.green : Colors.orange
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(Dimensions.five),
                                          child: Center(child: Text(result[index]['category'],style: TextStyle(color: Colors.white,fontSize: Dimensions.fifteen,fontWeight: FontWeight.w300),)),
                                        ),
                                      )
                                    )
                                  : Container(),
                                  result[index]['salePrice'] != null
                                  ? Positioned(
                                      width: Dimensions.forty,
                                      height: Dimensions.forty,
                                      left: Dimensions.five,
                                      top: Dimensions.five,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(Dimensions.fifty),
                                            color: discountBadgeColor
                                        ),
                                        child: Center(child: Text("$discount %\n off",style: TextStyle(color: Colors.white,fontSize: Dimensions.fifteen,fontWeight: FontWeight.w300),)),
                                      )
                                  )
                                  : Container()


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
              ),
              // !isLoading ?
              // ListView.builder(
              //   itemCount: result.length,
              //   itemBuilder: (context, index) => Padding(
              //     padding: EdgeInsets.all(Dimensions.ten),
              //     child: Container(
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(Dimensions.ten),
              //           boxShadow: [
              //             BoxShadow(
              //                 color: Colors.black38,
              //                 blurRadius: Dimensions.five
              //             )
              //           ]
              //       ),
              //       child: ClipRRect(
              //         borderRadius: BorderRadius.circular(Dimensions.ten),
              //         child: Container(
              //           height: Dimensions.oneFifty,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(10),
              //             color: Colors.white,
              //           ),
              //           child: Row(
              //             children: [
              //               result.isNotEmpty ? SizedBox(
              //                 width: Dimensions.hundred,
              //                 child: Image.network(
              //                   result[index]['displayImage'] ?? result[index]['imageGallery'][0]
              //                 ),
              //                 // child: Text(result[index]['name']),
              //               ) : Text("No Data")
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // )
                  // : Container()
            ],
          );
        }
      ),
    );
  }
}
