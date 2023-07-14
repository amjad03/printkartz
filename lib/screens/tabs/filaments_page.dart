import 'package:Printzkart/widgets/custom_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Printzkart/repository/auth_repository.dart';
import 'package:Printzkart/widgets/show_message.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/dimensions.dart';
import '../../models/filaments_model.dart';
import '../../services/data_service.dart';
import '../../services/shared_preferences_service.dart';
import '../detail_screens/detail_screen_for_filaments.dart';
import '../detail_screens/detail_screen_for_machine.dart';

class FilamentsPage extends StatefulWidget {
  const FilamentsPage({Key? key}) : super(key: key);

  @override
  State<FilamentsPage> createState() => _FilamentsPageState();
}

class _FilamentsPageState extends State<FilamentsPage> {

  bool isLoading = false;

  List<FilamentModel> filaments = [];


  void addFilamentDataToFirestore() async {
    try {
      // Create a Firestore collection reference
      CollectionReference productsRef = FirebaseFirestore.instance.collection('filaments');

      var name = 'Yellow PLA 3D Filament';
      var description = 'PLA (Polylactic Acid): Easy-to-use and environmentally friendly filament derived from renewable resources. Suitable for a wide range of applications with low warping and good printability.';
      var displayImage = 'https://rukminim1.flixcart.com/image/416/416/kcqk4nk0/printer-filament/f/z/t/1-75-1-kg-1-75mm-yellow-pla-filament-3d-printing-filament-for-3d-original-imaftsyqy8qzz6ag.jpeg?q=70';
      var imageGallery = ['https://rukminim1.flixcart.com/image/416/416/kcqk4nk0/printer-filament/f/z/t/1-75-1-kg-1-75mm-yellow-pla-filament-3d-printing-filament-for-3d-original-imaftsyqy8qzz6ag.jpeg?q=70', 'https://rukminim1.flixcart.com/image/416/416/kcqk4nk0/printer-filament/f/z/t/1-75-1-kg-1-75mm-yellow-pla-filament-3d-printing-filament-for-3d-original-imaftsyqy8qzz6ag.jpeg?q=70'];
      var brand = 'brand name';
      var modelNumber = '#76546';
      var color = 'Yellow';
      var material = 'PLA';
      var printTempRange = '190°C - 230°C';
      var compatibleWith = '3D Printers';
      var length = '175 m';
      var filamentDiameter = '1.75 mm';
      var filamentWeight = '1 kg';
      var tags = ['3d filament','3d','3d printer','yellow','pla'];

      // Create a new document in the "products" collection
      await productsRef.add({
        'name': name,
        'description': description,
        'displayImage': displayImage,
        'imageGallery': imageGallery,
        'brand': brand,
        'modelNumber': modelNumber,
        'color': color,
        'material': material,
        'printTempRange': printTempRange,
        'compatibleWith': compatibleWith,
        'length': length,
        'filamentDiameter': filamentDiameter,
        'filamentWeight': filamentWeight,
        'tags': tags,
      });

      print('Data added to Firestore successfully!');
    } catch (e) {
      print('Error adding data to Firestore: $e');
    }
  }


  void loadMachineData() async {
    DataService dataService = DataService();
    List<FilamentModel> _filaments = await dataService.getFilamentsData();
    setState(() {
      filaments = _filaments;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    loadMachineData();
    FavoritesManager.init();
  }

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black;
    var cardColor = Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade700 : Colors.white;
    var shadowColor = Theme.of(context).brightness == Brightness.dark ? Colors.transparent : Colors.black38;
    var discountBadgeColor = Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade800 : Colors.redAccent.shade400;

    return Scaffold(
      body: Consumer<FavoritesManager>(
          builder: (context, favoritesNotifier, _) {
            return Stack(
              children:[
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
                      Text("3d Printing Filament", style: TextStyle(fontSize: Dimensions.thirty),textAlign: TextAlign.center,),
                      const Divider(),
                      Padding(
                        padding: EdgeInsets.all(Dimensions.ten),
                        child: GridView.builder(
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 2/3,
                              crossAxisCount: 2,
                              crossAxisSpacing: Dimensions.fifteen,
                              mainAxisSpacing: Dimensions.fifteen
                          ),
                          itemCount: filaments.length,
                          itemBuilder: (context, index) {
                            var actualPrice = 1299;
                            var salePrice = 999;
                            var res = ((actualPrice - salePrice) / actualPrice ) * 100;
                            int discount = res.toInt();

                            var formatter = NumberFormat('#,###');
                            var formattedActualPrice = formatter.format(actualPrice);
                            var formattedSalePrice = formatter.format(salePrice);

                            //-------------------------------------------------------------
                            final exists = FavoritesManager.checkIfFavoriteExists(filaments[index].name);
                            bool isExists = false;

                            if(exists == true){
                              isExists = true;
                            }
                            else{
                              isExists = false;
                            }
                            return GestureDetector(
                              onTap: (){
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(
                                //       color: filaments[index].color,
                                //       itemName: filaments[index].name,
                                //       itemImage: filaments[index].displayImage,
                                //       isMachine: false,
                                //       isModel: false,
                                //       isFilament: true,
                                //     )
                                //   )
                                // );
                                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreenForFilament(
                                    id: filaments[index].id,
                                    name:  filaments[index].name,
                                    description:  filaments[index].description,
                                    displayImage:  filaments[index].displayImage,
                                    imageGallery:  filaments[index].imageGallery,
                                    brand:  filaments[index].brand,
                                    modelNumber:  filaments[index].modelNumber,
                                    color:  filaments[index].color,
                                    material:  filaments[index].material,
                                    printTempRange:  filaments[index].printTempRange,
                                    compatibleWith:  filaments[index].compatibleWith,
                                    length:  filaments[index].length,
                                    filamentDiameter:  filaments[index].filamentDiameter,
                                    filamentWeight:  filaments[index].filamentWeight,
                                    tags:  filaments[index].tags
                                )));
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
                                                    child: SizedBox(
                                                      width: double.maxFinite,
                                                      child: CachedNetworkImage(
                                                        imageUrl: filaments[index].displayImage.toString(),
                                                        // 'https://rukminim1.flixcart.com/image/416/416/kcqk4nk0/printer-filament/f/z/t/1-75-1-kg-1-75mm-yellow-pla-filament-3d-printing-filament-for-3d-original-imaftsyqy8qzz6ag.jpeg?q=70',
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: Dimensions.ten,),
                                                Text(filaments[index].name, style: TextStyle(fontSize: Dimensions.twenty, fontWeight: FontWeight.w400),maxLines: 1, overflow: TextOverflow.ellipsis,),
                                                // SizedBox(height: Dimensions.ten,),
                                                Row(
                                                  children: [
                                                    Text(formattedActualPrice.toString(),style: TextStyle(fontSize: Dimensions.fifteen, fontWeight: FontWeight.w400, color: Colors.black38, decoration: TextDecoration.lineThrough),),
                                                    Text(" ₹$formattedSalePrice/-",style: TextStyle(fontSize: Dimensions.eighteen, fontWeight: FontWeight.bold),),
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
                                              onTap: () async{
                                                if(checkLoggedIn()){
                                                  if(isExists){
                                                    final item = filaments[index].toJson();
                                                    FavoritesManager.removeFromFavorites(item);
                                                    favoritesNotifier.notifyListeners();
                                                  }
                                                  else {
                                                    Map<String, dynamic> itemMap = filaments[index].toJson();
                                                    await FavoritesManager.saveToFavorites(itemMap);
                                                    favoritesNotifier.notifyListeners();
                                                  }
                                                }
                                                else{
                                                  showToast("You are not logged in");
                                                }
                                                // Map<String, dynamic> itemMap = filaments[index].toJson();
                                                // await FavoritesManager.saveToFavorites(itemMap);
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
                                                  child: isExists ? Icon(Icons.favorite,color: Colors.red,size: Dimensions.thirty,) : Icon(Icons.favorite_outline,color: Colors.red,size: Dimensions.thirty,)
                                              ),
                                            )
                                        ),
                                        Positioned(
                                            width: Dimensions.forty,
                                            height: Dimensions.forty,
                                            left: Dimensions.five,
                                            top: Dimensions.five,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(Dimensions.fifty),
                                                  // color: Colors.redAccent.shade400
                                                  color: discountBadgeColor
                                              ),
                                              child: Center(child: Text("$discount %\n off",style: TextStyle(color: Colors.white,fontSize: Dimensions.fifteen,fontWeight: FontWeight.w300),)),
                                            )
                                        ),
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
                            child: CustomButton(
                                onPressed: (){
                                  // launchURL("https://www.printzkart.in/shop");
                                  var url = Uri.parse("https://www.printzkart.in/shop");
                                  launchUrl(url);
                                },
                                title: "View All"
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
      //     addFilamentDataToFirestore();
      //   },
      //   child: Text("3d"),
      // ),
    );
  }
}
