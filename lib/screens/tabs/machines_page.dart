import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:printzkart/constants/dimensions.dart';
import 'package:printzkart/repository/auth_repository.dart';
import 'package:printzkart/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/machine_model.dart';
import '../../services/data_service.dart';
import '../../services/shared_preferences_service.dart';
import '../../widgets/show_message.dart';
import '../detail_screens/detail_screen_for_machine.dart';

class MachinesPage extends StatefulWidget {
  const MachinesPage({Key? key}) : super(key: key);

  @override
  State<MachinesPage> createState() => _MachinesPageState();
}

class _MachinesPageState extends State<MachinesPage> {

  bool isLoading = false;

  List<MachineModel> _machines = [];

  void loadMachineData() async {
    DataService dataService = DataService();
    List<MachineModel> machines = await dataService.getMachinesData();
    setState(() {
      _machines = machines;
      isLoading = false;
    });
  }

  void addMachineDataToFirestore() async {
    try {
      // Create a Firestore collection reference
      CollectionReference productsRef = FirebaseFirestore.instance.collection('machines');

      var name = "DEX N";
      var actualPrice = 31499;
      var salePrice = 16499;
      var description = "A 3D printer is a type of machine that can create three-dimensional objects by layering materials on top of each other based on a digital model or design. It is a versatile tool used in various industries such as manufacturing, prototyping, engineering, design, architecture, medicine, and education.";
      var imageGallery = [
        "https://firebasestorage.googleapis.com/v0/b/printzkart-flutter.appspot.com/o/machines%2FDEX%20N.jpg?alt=media&token=778a2d71-0375-459f-a801-9e5563df5639",
        "https://firebasestorage.googleapis.com/v0/b/printzkart-flutter.appspot.com/o/machines%2Fdex300.png?alt=media&token=bbf31ddd-fa95-49b3-9c6c-997ad64814c3",
        "https://firebasestorage.googleapis.com/v0/b/printzkart-flutter.appspot.com/o/machines%2Fdex300N.255.png?alt=media&token=fbc08f12-3667-468c-8f60-1f79dbe50de1"
      ];
      var color = "black";
      var printingSpeed = "60 mm/sec";
      var autoCalibration = "No";
      var printingTechnology = "Fused Deposition Modeling";
      var bedType = "Heated";
      var sdCardSupported = "Yes";
      var buildVolume = "43 x 39 x 24 cm";
      var powerConsumption = "15 V";
      var nozzleDiameter = "0.4 mm";
      var filamentDiameter = "1.75 mm";
      var height = "43 cm";
      var width = "24 cm";
      var weight = "8 kg";
      var warrantySummary = "12 Months Warranty of the product is limited to manufacturing defects only.";
      var serviceType = "Replacement Warranty";
      var coveredInWarranty = "Manufacturing defects only";
      var notCoveredInWarranty = "Customer damage, Physical Damage, Liquid damage or Burnt damage";
      var tags = ["3d printer","black","FDM","8kg","printer","aluminium","step"];

      // Create a new document in the "products" collection
      await productsRef.add({
        'name': name,
        'actualPrice': actualPrice,
        'salePrice': salePrice,
        'description': description,
        'imageGallery': imageGallery,
        'color': color,
        'printingSpeed': printingSpeed,
        'autoCalibration': autoCalibration,
        'printingTechnology': printingTechnology,
        'bedType': bedType,
        'sdCardSupported': sdCardSupported,
        'buildVolume': buildVolume,
        'powerConsumption': powerConsumption,
        'nozzleDiameter': nozzleDiameter,
        'filamentDiameter': filamentDiameter,
        'height': height,
        'width': width,
        'weight': weight,
        'warrantySummary': warrantySummary,
        'serviceType': serviceType,
        'coveredInWarranty': coveredInWarranty,
        'notCoveredInWarranty': notCoveredInWarranty,
        'tags': tags,
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
                    Text("3d Printing Machines", style: TextStyle(fontSize: Dimensions.thirty),textAlign: TextAlign.center,),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(10),
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
                        itemCount: _machines.length,
                        itemBuilder: (context, index) {
                          // var actualPrice = 32199;
                          // var salePrice = 16199;
                          // var res = ((actualPrice - salePrice) / actualPrice ) * 100;
                          // int discount = res.toInt();
                          var actualPrice = _machines[index].actualPrice.toDouble();
                          var salePrice = _machines[index].salePrice.toDouble();
                          var res = ((actualPrice - salePrice) / actualPrice ) * 100;
                          int discount = res.toInt();

                          var formatter = NumberFormat('#,###');
                          var formattedActualPrice = formatter.format(actualPrice);
                          var formattedSalePrice = formatter.format(salePrice);

                          //---------------------------------------------------------------
                          final exists = FavoritesManager.checkIfFavoriteExists(_machines[index].name);
                          bool isExists = false;

                          if(exists == true){
                            isExists = true;
                          }
                          else{
                            isExists = false;
                          }

                          return GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(
                                    name: _machines[index].name,
                                    actualPrice: _machines[index].actualPrice,
                                    salePrice: _machines[index].salePrice,
                                    description: _machines[index].description,
                                    displayImage: _machines[index].displayImage,
                                    imageGallery: _machines[index].imageGallery,
                                    color: _machines[index].color,
                                    printingSpeed: _machines[index].printingSpeed,
                                    autoCalibration: _machines[index].autoCalibration,
                                    printingTechnology: _machines[index].printingTechnology,
                                    bedType: _machines[index].bedType,
                                    sdCardSupported: _machines[index].sdCardSupported,
                                    buildVolume: _machines[index].buildVolume,
                                    powerConsumption: _machines[index].powerConsumption,
                                    nozzleDiameter: _machines[index].nozzleDiameter,
                                    filamentDiameter: _machines[index].filamentDiameter,
                                    height: _machines[index].height,
                                    width: _machines[index].width,
                                    weight: _machines[index].weight,
                                    warrantySummary: _machines[index].warrantySummary,
                                    serviceType: _machines[index].serviceType,
                                    coveredInWarranty: _machines[index].coveredInWarranty,
                                    notCoveredInWarranty: _machines[index].notCoveredInWarranty,
                                    tags: _machines[index].tags
                                )
                              )
                              );
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
                                                    imageUrl: _machines[index].displayImage.toString(),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: Dimensions.ten,),
                                              Text(_machines[index].name, style: TextStyle(fontSize: Dimensions.twenty, fontWeight: FontWeight.w400),maxLines: 1, overflow: TextOverflow.ellipsis,),
                                              // SizedBox(height: Dimensions.ten,),
                                              // Column(
                                              //   crossAxisAlignment: CrossAxisAlignment.start,
                                              //   children: [
                                              // Text("49% off",style: TextStyle(fontSize: Dimensions.eighteen, color: Colors.green, fontWeight: FontWeight.bold),),
                                              Row(
                                                children: [
                                                  Text(formattedActualPrice.toString(),style: TextStyle(fontSize: Dimensions.fifteen, fontWeight: FontWeight.w400, color: Colors.black38, decoration: TextDecoration.lineThrough),),
                                                  Text(" ₹$formattedSalePrice/-",style: TextStyle(fontSize: Dimensions.eighteen, fontWeight: FontWeight.bold),),
                                                ],
                                              )
                                              //   ],
                                              // ),
                                              // CustomButton(title: "View", onPressed: (){})
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
                                                  final item = _machines[index].toJson();
                                                  FavoritesManager.removeFromFavorites(item);
                                                  favoritesNotifier.notifyListeners();
                                                }
                                                else {
                                                  Map<String, dynamic> itemMap = _machines[index].toJson();
                                                  await FavoritesManager.saveToFavorites(itemMap);
                                                  favoritesNotifier.notifyListeners();
                                                }
                                              }
                                              else{
                                                showToast("You are not logged in");
                                              }
                                            //   Map<String, dynamic> itemMap = _machines[index].toJson();
                                            //   await FavoritesManager.saveToFavorites(itemMap);
                                            },
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(Dimensions.fifty),
                                                  // color: cardColor,
                                                  // boxShadow: [
                                                  //   BoxShadow(
                                                  //       color: Colors.grey,
                                                  //       blurRadius: 3
                                                  //   )
                                                  // ]
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
                          child: ElevatedButton(
                              onPressed: (){
                                // launchURL("https://www.printzkart.in/shop");
                                var url = Uri.parse("https://www.printzkart.in/shop?Category=3D+Printers");
                                launchUrl(url);
                              },
                              child: const Text("View All Machines")
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
      //     addMachineDataToFirestore();
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }

}
