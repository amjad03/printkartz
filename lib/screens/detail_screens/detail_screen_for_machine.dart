import 'dart:typed_data';
import 'dart:io';
import 'package:share/share.dart';
import 'package:path_provider/path_provider.dart';

import 'package:http/http.dart' as http;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:Printzkart/constants/dimensions.dart';
import 'package:share/share.dart';

import '../../constants/constants.dart';
import '../../services/helper_class.dart';

class DetailScreen extends StatefulWidget {

  // const DetailScreen({
  //   Key? key,
  //   required this.itemName,
  //   this.itemDescription = "",
  //   required this.itemImage,
  //   required this.isMachine,
  //   required this.isModel,
  //   required this.isFilament,
  //   this.itemCategory = "",
  //   this.modelUrl = "",
  //   this.color = ""
  // }) : super(key: key);

  // final String itemName;
  // final String itemDescription;
  // final String itemCategory;
  // final String modelUrl;
  // final String color;
  // final String itemImage;
  // final bool isMachine;
  // final bool isModel;
  // final bool isFilament;

  final String name;
  // final double actualPrice;
  // final double salePrice;
  final double actualPrice;
  final double salePrice;
  final String description;
  final String displayImage;
  final List imageGallery;
  final String color;
  final String printingSpeed;
  final String autoCalibration;
  final String printingTechnology;
  final String bedType;
  final String sdCardSupported;
  final String buildVolume;
  final String powerConsumption;
  final String nozzleDiameter;
  final String filamentDiameter;
  final String height;
  final String width;
  final String weight;
  final String warrantySummary;
  final String serviceType;
  final String coveredInWarranty;
  final String notCoveredInWarranty;
  final List tags;

  const DetailScreen({super.key,
    required this.name,
    required this.actualPrice,
    required this.salePrice,
    required this.description,
    required this.displayImage,
    required this.imageGallery,
    required this.color,
    required this.printingSpeed,
    required this.autoCalibration,
    required this.printingTechnology,
    required this.bedType,
    required this.sdCardSupported,
    required this.buildVolume,
    required this.powerConsumption,
    required this.nozzleDiameter,
    required this.filamentDiameter,
    required this.height,
    required this.width,
    required this.weight,
    required this.warrantySummary,
    required this.serviceType,
    required this.coveredInWarranty,
    required this.notCoveredInWarranty,
    required this.tags
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  bool readMore = false;
  int currentPage = 0;
  bool isLoading = false;
  bool _showProgressIndicator = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: Dimensions.fifteen,),
                Stack(
                    children: [
                      Center(
                        child: SizedBox(
                          width: Dimensions.sixHundred,
                          child: CarouselSlider(
                            options: CarouselOptions(
                              height: 200.0,
                              viewportFraction: 1,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  currentPage = index;
                                });
                              },
                            ),
                            items: widget.imageGallery.map((imageUrl) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    width: Dimensions.threeHundred,
                                    margin: EdgeInsets.symmetric(horizontal: Dimensions.ten),
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 0.5)
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: imageUrl,
                                      // fit: BoxFit.cover,
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // shareFile(widget.displayImage, "Hey, I found a very good quality 3D printer! Do check this out!");
                          // setState(() {
                          //   _showProgressIndicator = true;
                          // });
                          var msg = 'Hey,Check out this amazing 3D Printer I found on ${Strings.appTitle}! You can download the app and discover more like this from the Google Play Store: ${Strings.playStoreLink}';
                          _shareFile(widget.displayImage, msg);
                          // setState(() {
                          //   _showProgressIndicator = false;
                          // });
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: Dimensions.ten, right: Dimensions.ten),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              // padding: EdgeInsets.all(Dimensions.ten),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimensions.five),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black38,
                                          blurRadius: Dimensions.five
                                      )
                                    ]
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(Dimensions.five),
                                  child: Icon(Icons.share, size: Dimensions.thirty,),
                                )
                            ),
                          ),
                        ),
                      ),
                    ]
                ),
                SizedBox(height: Dimensions.ten,),
                Padding(
                  padding: EdgeInsets.all(Dimensions.ten),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Dimensions.fifteen,
                        width: double.infinity,
                        child: Align(
                          alignment: Alignment.center,
                          child: ListView.builder(
                            itemCount: widget.imageGallery.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                width: Dimensions.ten,
                                height: Dimensions.ten,
                                margin: EdgeInsets.only(right: Dimensions.five),
                                decoration: BoxDecoration(
                                    color: currentPage == index ? Colors.black : Colors.grey.shade400,
                                    shape: BoxShape.circle
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Divider(),
                      Text(widget.name,style: TextStyle(fontSize: Dimensions.twenty, fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left,),
                      SizedBox(height: Dimensions.fifteen,),
                      Text( widget.description,style: TextStyle(fontSize: Dimensions.fifteen, fontWeight: FontWeight.w300), maxLines: readMore ? 30 : 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left,),
                      widget.description.length > 80 ? Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {
                              setState(() {
                                readMore = !readMore;
                              });
                            },
                            child: Text(readMore ? "Read Less" : "Read More",style: TextStyle(color: Colors.blue,decoration: TextDecoration.underline),)),
                      ) : Container(),
                      Divider(),
                      Text("Specifications", style: TextStyle(fontSize: Dimensions.twenty,fontWeight: FontWeight.bold),),
                      SizedBox(height: Dimensions.fifteen,),
                      Text("General", style: TextStyle(fontSize: Dimensions.fifteen,fontWeight: FontWeight.bold),),
                      SizedBox(height: Dimensions.fifteen,),
                      TwoTextInRow(title: 'Color', pair: widget.color,),
                      TwoTextInRow(title: 'Print Speed', pair: widget.printingSpeed,),
                      TwoTextInRow(title: 'Auto Calibration Present', pair: widget.autoCalibration,),
                      TwoTextInRow(title: 'Printing Technology', pair: widget.printingTechnology,),
                      TwoTextInRow(title: 'Print Bed Type', pair: widget.bedType,),
                      TwoTextInRow(title: 'SD Card Support', pair: widget.sdCardSupported,),
                      TwoTextInRow(title: 'Build Volume', pair: widget.buildVolume,),
                      TwoTextInRow(title: 'Power Consumption', pair: widget.powerConsumption,),
                      TwoTextInRow(title: 'Nozzle Diameter', pair: widget.nozzleDiameter,),
                      TwoTextInRow(title: 'Filament Diameter', pair: widget.filamentDiameter,),

                      Text("Dimensions", style: TextStyle(fontSize: Dimensions.fifteen,fontWeight: FontWeight.bold),),
                      SizedBox(height: Dimensions.fifteen,),
                      TwoTextInRow(title: 'Height', pair: widget.height,),
                      TwoTextInRow(title: 'Width', pair: widget.width,),
                      TwoTextInRow(title: 'Weight', pair: widget.weight,),

                      Text("Warranty", style: TextStyle(fontSize: Dimensions.fifteen,fontWeight: FontWeight.bold),),
                      SizedBox(height: Dimensions.fifteen,),
                      TwoTextInRow(title: 'Warranty Summary', pair: widget.warrantySummary,),
                      TwoTextInRow(title: 'Service Type', pair: widget.serviceType,),
                      TwoTextInRow(title: 'Covered in Warranty', pair: widget.coveredInWarranty,),
                      TwoTextInRow(title: 'Not Covered in Warranty', pair: widget.notCoveredInWarranty,),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: _showProgressIndicator,
            child: Opacity(
              opacity: 0.4,
              child: ModalBarrier(dismissible: false, color: Colors.black),
          )),
          Visibility(
            visible: _showProgressIndicator,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          ),
        ]
      ),
    );
  }
  void _shareFile(String imageUrl, String message) async{
    setState(() {
      _showProgressIndicator = true;
    });

    Future<Uint8List> getBytesFromUrl(String url) async {
      final response = await http.get(Uri.parse(url));
      return response.bodyBytes;
    }

    final bytes = await getBytesFromUrl(imageUrl);
    final tempDir = await getTemporaryDirectory();
    final file = await File('${tempDir.path}/image.jpg').create();
    await file.writeAsBytes(bytes.buffer.asUint8List());

    Share.shareFiles([file.path], text: message)
        .whenComplete(() {
      setState(() {
        _showProgressIndicator = false;
      });
    });

  }


    // Perform the sharing action here
    // Share.share(message, subject: 'Check out this 3D printer!', sharePositionOrigin: Rect.fromLTWH(0, 0, 10, 10),)
    //     .whenComplete(() {
    //   setState(() {
    //     _showProgressIndicator = false;
    //   });
    // });

}



class TwoTextInRow extends StatelessWidget {
  const TwoTextInRow({
    super.key, required this.title, required this.pair,
  });

  final String title;
  final String pair;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: Dimensions.oneFifty,
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(title,style: TextStyle(fontSize: Dimensions.fifteen,color: Colors.grey.shade600),)
              ),
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Text(":",style: TextStyle(fontSize: Dimensions.fifteen,color: Colors.grey.shade600),)
            ),
            SizedBox(width: Dimensions.fifteen,),
            Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(pair,style: TextStyle(fontSize: Dimensions.fifteen,color: Colors.grey.shade600),),
                )
            )
          ],
        ),
        SizedBox(height: Dimensions.ten,),
      ],
    );
  }
}


// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:printzkart/constants/dimensions.dart';
//
// import '../../services/helper_class.dart';
//
// class DetailScreen extends StatefulWidget {
//
//   // const DetailScreen({
//   //   Key? key,
//   //   required this.itemName,
//   //   this.itemDescription = "",
//   //   required this.itemImage,
//   //   required this.isMachine,
//   //   required this.isModel,
//   //   required this.isFilament,
//   //   this.itemCategory = "",
//   //   this.modelUrl = "",
//   //   this.color = ""
//   // }) : super(key: key);
//
//   // final String itemName;
//   // final String itemDescription;
//   // final String itemCategory;
//   // final String modelUrl;
//   // final String color;
//   // final String itemImage;
//   // final bool isMachine;
//   // final bool isModel;
//   // final bool isFilament;
//
//   final String name;
//   final double actualPrice;
//   final double salePrice;
//   final String description;
//   final String displayImage;
//   final List imageGallery;
//   final String color;
//   final String printingSpeed;
//   final String autoCalibration;
//   final String printingTechnology;
//   final String bedType;
//   final String sdCardSupported;
//   final String buildVolume;
//   final String powerConsumption;
//   final String nozzleDiameter;
//   final String filamentDiameter;
//   final String height;
//   final String width;
//   final String weight;
//   final String warrantySummary;
//   final String serviceType;
//   final String coveredInWarranty;
//   final String notCoveredInWarranty;
//   final List tags;
//
//   const DetailScreen({super.key,
//     required this.name,
//     required this.actualPrice,
//     required this.salePrice,
//     required this.description,
//     required this.displayImage,
//     required this.imageGallery,
//     required this.color,
//     required this.printingSpeed,
//     required this.autoCalibration,
//     required this.printingTechnology,
//     required this.bedType,
//     required this.sdCardSupported,
//     required this.buildVolume,
//     required this.powerConsumption,
//     required this.nozzleDiameter,
//     required this.filamentDiameter,
//     required this.height,
//     required this.width,
//     required this.weight,
//     required this.warrantySummary,
//     required this.serviceType,
//     required this.coveredInWarranty,
//     required this.notCoveredInWarranty,
//     required this.tags
//   });
//
//   @override
//   State<DetailScreen> createState() => _DetailScreenState();
// }
//
// class _DetailScreenState extends State<DetailScreen> {
//
//   bool readMore = false;
//   int currentPage = 0;
//   bool isLoading = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.name),
//       ),
//       body: Stack(
//           children: [
//             SingleChildScrollView(
//               child: Column(
//                 children: [
//                   SizedBox(height: Dimensions.fifteen,),
//                   Stack(
//                       children: [
//                         // CachedNetworkImage(
//                         //   imageUrl: widget.displayImage,
//                         //   fit: BoxFit.cover,
//                         // ),
//                         CarouselSlider(
//                           options: CarouselOptions(
//                             height: 200.0,
//                             viewportFraction: 0.8,
//                             onPageChanged: (index, reason) {
//                               setState(() {
//                                 currentPage = index;
//                               });
//                             },
//                             // You can customize other options like auto-play, slide duration, etc.
//                           ),
//                           items: widget.imageGallery.map((imageUrl) {
//                             return Builder(
//                               builder: (BuildContext context) {
//                                 return Container(
//                                   width: Dimensions.threeHundred,
//                                   margin: EdgeInsets.symmetric(horizontal: Dimensions.ten),
//                                   decoration: BoxDecoration(
//                                       border: Border.all(width: 0.5)
//                                   ),
//                                   child: CachedNetworkImage(
//                                     imageUrl: imageUrl,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 );
//                               },
//                             );
//                           }).toList(),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               isLoading = true;
//                             });
//                             Future.delayed(Duration(seconds: 3), () {
//                               shareFile(widget.displayImage, "Hey, I found a very good quality 3D printer! Do check this out!");
//                             });
//                             setState(() {
//                               isLoading = false;
//                             });
//                           },
//                           child: Padding(
//                             padding: EdgeInsets.only(top: Dimensions.ten, right: Dimensions.ten),
//                             child: Align(
//                               alignment: Alignment.centerRight,
//                               child: Container(
//                                 // padding: EdgeInsets.all(Dimensions.ten),
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(Dimensions.five),
//                                       color: Colors.white,
//                                       boxShadow: [
//                                         BoxShadow(
//                                             color: Colors.black38,
//                                             blurRadius: Dimensions.five
//                                         )
//                                       ]
//                                   ),
//                                   child: Padding(
//                                     padding: EdgeInsets.all(Dimensions.five),
//                                     child: Icon(Icons.share, size: Dimensions.thirty,),
//                                   )
//                               ),
//                             ),
//                           ),
//                         ),
//                       ]
//                   ),
//                   SizedBox(height: Dimensions.ten,),
//                   Padding(
//                     padding: EdgeInsets.all(Dimensions.ten),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           height: Dimensions.fifteen,
//                           width: double.infinity,
//                           child: Align(
//                             alignment: Alignment.center,
//                             child: ListView.builder(
//                               itemCount: widget.imageGallery.length,
//                               shrinkWrap: true,
//                               scrollDirection: Axis.horizontal,
//                               itemBuilder: (context, index) {
//                                 return Container(
//                                   width: Dimensions.ten,
//                                   height: Dimensions.ten,
//                                   margin: EdgeInsets.only(right: Dimensions.five),
//                                   decoration: BoxDecoration(
//                                       color: currentPage == index ? Colors.black : Colors.grey.shade400,
//                                       shape: BoxShape.circle
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
//                         Divider(),
//                         Text(widget.name,style: TextStyle(fontSize: Dimensions.twenty, fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left,),
//                         SizedBox(height: Dimensions.fifteen,),
//                         // widget.isMachine ? Text( widget.itemDescription,style: TextStyle(fontSize: Dimensions.fifteen, fontWeight: FontWeight.w300), maxLines: readMore ? 30 : 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left,) : Container(),
//                         // widget.isMachine ?
//                         // widget.itemDescription.length > 80 ? Align(
//                         //   alignment: Alignment.centerRight,
//                         //   child: TextButton(
//                         //       onPressed: () {
//                         //         setState(() {
//                         //           readMore = !readMore;
//                         //         });
//                         //       },
//                         //       child: Text(readMore ? "Read Less" : "Read More",style: TextStyle(color: Colors.blue,decoration: TextDecoration.underline),)),
//                         // ) : Container()
//                         // : Container(),
//                         Text( widget.description,style: TextStyle(fontSize: Dimensions.fifteen, fontWeight: FontWeight.w300), maxLines: readMore ? 30 : 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left,),
//                         widget.description.length > 80 ? Align(
//                           alignment: Alignment.centerRight,
//                           child: TextButton(
//                               onPressed: () {
//                                 setState(() {
//                                   readMore = !readMore;
//                                 });
//                               },
//                               child: Text(readMore ? "Read Less" : "Read More",style: TextStyle(color: Colors.blue,decoration: TextDecoration.underline),)),
//                         ) : Container(),
//                         Divider(),
//                         Text("Specifications", style: TextStyle(fontSize: Dimensions.twenty,fontWeight: FontWeight.bold),),
//                         SizedBox(height: Dimensions.fifteen,),
//                         Text("General", style: TextStyle(fontSize: Dimensions.fifteen,fontWeight: FontWeight.bold),),
//                         SizedBox(height: Dimensions.fifteen,),
//                         TwoTextInRow(title: 'Color', pair: widget.color,),
//                         TwoTextInRow(title: 'Print Speed', pair: widget.printingSpeed,),
//                         TwoTextInRow(title: 'Auto Calibration Present', pair: widget.autoCalibration,),
//                         TwoTextInRow(title: 'Printing Technology', pair: widget.printingTechnology,),
//                         TwoTextInRow(title: 'Print Bed Type', pair: widget.bedType,),
//                         TwoTextInRow(title: 'SD Card Support', pair: widget.sdCardSupported,),
//                         TwoTextInRow(title: 'Build Volume', pair: widget.buildVolume,),
//                         TwoTextInRow(title: 'Power Consumption', pair: widget.powerConsumption,),
//                         TwoTextInRow(title: 'Nozzle Diameter', pair: widget.nozzleDiameter,),
//                         TwoTextInRow(title: 'Filament Diameter', pair: widget.filamentDiameter,),
//
//                         Text("Dimensions", style: TextStyle(fontSize: Dimensions.fifteen,fontWeight: FontWeight.bold),),
//                         SizedBox(height: Dimensions.fifteen,),
//                         TwoTextInRow(title: 'Height', pair: widget.height,),
//                         TwoTextInRow(title: 'Width', pair: widget.width,),
//                         TwoTextInRow(title: 'Weight', pair: widget.weight,),
//
//                         Text("Warranty", style: TextStyle(fontSize: Dimensions.fifteen,fontWeight: FontWeight.bold),),
//                         SizedBox(height: Dimensions.fifteen,),
//                         TwoTextInRow(title: 'Warranty Summary', pair: widget.warrantySummary,),
//                         TwoTextInRow(title: 'Service Type', pair: widget.serviceType,),
//                         TwoTextInRow(title: 'Covered in Warranty', pair: widget.coveredInWarranty,),
//                         TwoTextInRow(title: 'Not Covered in Warranty', pair: widget.notCoveredInWarranty,),
//
//
//                         // SizedBox(height: Dimensions.ten,),
//                         // Row(
//                         //   children: [
//                         //     SizedBox(
//                         //       width: Dimensions.oneFifty,
//                         //       child: Text("Model Name",style: TextStyle(fontSize: Dimensions.fifteen,color: Colors.grey.shade600),),
//                         //     ),
//                         //     Expanded(
//                         //         child: Align(
//                         //           alignment: Alignment.centerLeft,
//                         //           child: Text("Some Name",style: TextStyle(fontSize: Dimensions.fifteen,color: Colors.grey.shade600),),
//                         //         )
//                         //     )
//                         //   ],
//                         // ),
//                         // SizedBox(height: Dimensions.ten,),
//                         // Row(
//                         //   children: [
//                         //     SizedBox(
//                         //       width: Dimensions.oneFifty,
//                         //       child: Text("Color",style: TextStyle(fontSize: Dimensions.fifteen,color: Colors.grey.shade600),),
//                         //     ),
//                         //     Expanded(
//                         //         child: Align(
//                         //           alignment: Alignment.centerLeft,
//                         //           child: Text("Black",style: TextStyle(fontSize: Dimensions.fifteen,color: Colors.grey.shade600),),
//                         //         )
//                         //     )
//                         //   ],
//                         // ),
//                         // SizedBox(height: Dimensions.ten,),
//                         // Row(
//                         //   children: [
//                         //     SizedBox(
//                         //       width: Dimensions.oneFifty,
//                         //       child: Text("Material",style: TextStyle(fontSize: Dimensions.fifteen,color: Colors.grey.shade600),),
//                         //     ),
//                         //     Expanded(
//                         //         child: Align(
//                         //           alignment: Alignment.centerLeft,
//                         //           child: Text("Aluminium",style: TextStyle(fontSize: Dimensions.fifteen,color: Colors.grey.shade600),),
//                         //         )
//                         //     )
//                         //   ],
//                         // ),
//                         // SizedBox(height: Dimensions.ten,),
//                         // Row(
//                         //   children: [
//                         //     SizedBox(
//                         //       width: Dimensions.oneFifty,
//                         //       child: Text("Item Weight",style: TextStyle(fontSize: Dimensions.fifteen,color: Colors.grey.shade600),),
//                         //     ),
//                         //     Expanded(
//                         //         child: Align(
//                         //           alignment: Alignment.centerLeft,
//                         //           child: Text("3.7 kg",style: TextStyle(fontSize: Dimensions.fifteen,color: Colors.grey.shade600),),
//                         //         )
//                         //     )
//                         //   ],
//                         // ),
//                         // SizedBox(height: Dimensions.ten,),
//                         // Row(
//                         //   children: [
//                         //     SizedBox(
//                         //       width: Dimensions.oneFifty,
//                         //       child: Text("Item Dimensions",style: TextStyle(fontSize: Dimensions.fifteen,color: Colors.grey.shade600),),
//                         //     ),
//                         //     Expanded(
//                         //         child: Align(
//                         //           alignment: Alignment.centerLeft,
//                         //           child: Text("44D x 44W x 46.5H cm",style: TextStyle(fontSize: Dimensions.fifteen,color: Colors.grey.shade600),),
//                         //         )
//                         //     )
//                         //   ],
//                         // ),
//                         // SizedBox(height: Dimensions.ten,),
//                         // Row(
//                         //   children: [
//                         //     SizedBox(
//                         //       width: Dimensions.oneFifty,
//                         //       child: Text("Supported File Formatted",style: TextStyle(fontSize: Dimensions.fifteen,color: Colors.grey.shade600),),
//                         //     ),
//                         //     Expanded(
//                         //         child: Align(
//                         //           alignment: Alignment.centerLeft,
//                         //           child: Text("STEP",style: TextStyle(fontSize: Dimensions.fifteen,color: Colors.grey.shade600),),
//                         //         )
//                         //     )
//                         //   ],
//                         // ),
//                         // SizedBox(height: Dimensions.ten,),
//
//                         // for(var i = 0; i < 10; i++)
//                         //   Row(
//                         //     children: [
//                         //       SizedBox(
//                         //         width: Dimensions.hundred,
//                         //         child: Text("Brand",style: TextStyle(fontSize: Dimensions.fifteen,color: Colors.grey.shade600),),
//                         //       ),
//                         //       Expanded(
//                         //           child: Align(
//                         //             alignment: Alignment.centerLeft,
//                         //             child: Text("Brand Name",style: TextStyle(fontSize: Dimensions.fifteen,color: Colors.grey.shade600),),
//                         //           )
//                         //       )
//                         //     ],
//                         //   ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             if (isLoading)
//               const Opacity(
//                 opacity: 0.4,
//                 child: ModalBarrier(dismissible: false, color: Colors.black),
//               ),
//             if (isLoading)
//               const Center(
//                 child: CircularProgressIndicator(
//                   color: Colors.white,
//                 ),
//               ),
//           ]
//       ),
//     );
//   }
// }
//
// class TwoTextInRow extends StatelessWidget {
//   const TwoTextInRow({
//     super.key, required this.title, required this.pair,
//   });
//
//   final String title;
//   final String pair;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             SizedBox(
//               width: Dimensions.oneFifty,
//               child: Align(
//                   alignment: Alignment.topLeft,
//                   child: Text(title,style: TextStyle(fontSize: Dimensions.fifteen,color: Colors.grey.shade600),)
//               ),
//             ),
//             Align(
//                 alignment: Alignment.topLeft,
//                 child: Text(":",style: TextStyle(fontSize: Dimensions.fifteen,color: Colors.grey.shade600),)
//             ),
//             SizedBox(width: Dimensions.fifteen,),
//             Expanded(
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(pair,style: TextStyle(fontSize: Dimensions.fifteen,color: Colors.grey.shade600),),
//                 )
//             )
//           ],
//         ),
//         SizedBox(height: Dimensions.ten,),
//       ],
//     );
//   }
// }
