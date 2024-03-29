import 'dart:typed_data';
import 'dart:io';
import 'package:Printzkart/widgets/custom_button.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:share/share.dart';
import 'package:path_provider/path_provider.dart';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:Printzkart/constants/dimensions.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/constants.dart';
import '../../services/helper_class.dart';
import '../../widgets/show_message.dart';

class DetailScreenFor3dModel extends StatefulWidget {

  final String name;
  final String description;
  final String modelFileUrl;
  final String thumbnailUrl;
  final List imageGallery;
  final List tags;
  final String author;
  final String dateUploaded;
  final String category;

  const DetailScreenFor3dModel({
    super.key,
    required this.name,
    required this.description,
    required this.modelFileUrl,
    required this.thumbnailUrl,
    required this.imageGallery,
    required this.tags,
    required this.author,
    required this.dateUploaded,
    required this.category,

  });

  @override
  State<DetailScreenFor3dModel> createState() => _DetailScreenFor3dModelState();
}

class _DetailScreenFor3dModelState extends State<DetailScreenFor3dModel> {

  bool readMore = false;
  int currentPage = 0;
  bool _showProgressIndicator = false;

  // void downloadModel(String url) async {
  //
  //   // final directory = await getApplicationDocumentsDirectory(); // or getExternalStorageDirectory()
  //   // final savedDir = directory.path;
  //   //
  //   // final fileName = path.basename(url);
  //
  //   // final response = await http.get(Uri.parse(url));
  //   //
  //   // if (response.statusCode == 200) {
  //   //   final bytes = response.bodyBytes;
  //   //   final dir = await getTemporaryDirectory(); // or getExternalStorageDirectory()
  //   //   final file = File('${dir.path}/$fileName');
  //   //   await file.writeAsBytes(bytes);
  //   //   // File downloaded successfully
  //   //   print("Successful");
  //   //   showToast("Successfully downloaded");
  //   // } else {
  //   //   // Failed to download file
  //   //   showToast("downloaded failed");
  //   // }
  //
  //   // final taskId = await FlutterDownloader.enqueue(
  //   //   url: "https://images.pexels.com/photos/16796362/pexels-photo-16796362/free-photo-of-pic-du-midi-de-bigorre-in-pyrenees-with-observatory-at-the-top.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
  //   //   savedDir: savedDir,
  //   //   fileName: fileName,
  //   //   showNotification: true,
  //   //   openFileFromNotification: true,
  //   // );
  // }


  // Future<void> downloadModel(String modelFileUrl) async {
  //   try {
  //     final Directory appDir = await getApplicationDocumentsDirectory();
  //     final String downloadPath = '${appDir.path}/model.obj'; // Change the file extension as per your model format
  //
  //     final http.Client client = http.Client();
  //     final http.Request request =
  //     http.Request('GET', Uri.parse(modelFileUrl));
  //     final http.StreamedResponse response = await client.send(request);
  //     final http.ByteStream stream = http.ByteStream(response.stream);
  //     final File file = File(downloadPath);
  //     // final http.StreamedResponse downloadResponse = await http.Response.fromStream(await stream.cast());
  //     final http.StreamedResponse downloadResponse = await http.Response.fromStream(await stream.cast());
  //     await downloadResponse.bodyBytes.forEach(file.writeAsBytes);
  //   } catch (e) {
  //     print('Error downloading model: $e');
  //   }
  // }


  // Future<void> downloadModel(String modelFileUrl) async {
  //   try {
  //     final Directory appDir = await getApplicationDocumentsDirectory();
  //     final String downloadPath = '${appDir.path}/model.obj'; // Change the file extension as per your model format
  //
  //     final http.Client client = http.Client();
  //     final http.Response response = await client.get(Uri.parse(modelFileUrl));
  //     final File file = File(downloadPath);
  //     await file.writeAsBytes(response.bodyBytes);
  //     print("Successfully downloaded");
  //   } catch (e) {
  //     print('Error downloading model: $e');
  //   }
  // }

  Future<String?> getModelDownloadUrl(String modelFilePath) async {
    try {
      final firebase_storage.Reference ref =
      firebase_storage.FirebaseStorage.instance.ref().child(modelFilePath);
      final String downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error retrieving download URL: $e');
      return null;
    }
  }

  Future<void> downloadModel(downloadUrl) async {
    try {
      String filename = path.basename(downloadUrl);
      final Directory appDir = await getApplicationDocumentsDirectory();
      final String filePath = '${appDir.path}/$filename';
      final http.Client client = http.Client();
      final http.Response response = await client.get(Uri.parse(downloadUrl));
      final File file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      print('Model downloaded successfully.');
    } catch (e) {
      print('Error downloading model: $e');
    }
  }

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
                              // You can customize other options like auto-play, slide duration, etc.
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
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     var msg = 'Hey,Check out this amazing 3D Model I found on ${Strings.appTitle}! You can download the app and discover more like this from the Google Play Store: ${Strings.playStoreLink}';
                      //     _shareFile(widget.thumbnailUrl, msg);
                      //   },
                      //   child: Padding(
                      //     padding: EdgeInsets.only(top: Dimensions.ten, right: Dimensions.ten),
                      //     child: Align(
                      //       alignment: Alignment.centerRight,
                      //       child: Container(
                      //         // padding: EdgeInsets.all(Dimensions.ten),
                      //           decoration: BoxDecoration(
                      //               borderRadius: BorderRadius.circular(Dimensions.five),
                      //               color: Colors.white,
                      //               boxShadow: [
                      //                 BoxShadow(
                      //                     color: Colors.black38,
                      //                     blurRadius: Dimensions.five
                      //                 )
                      //               ]
                      //           ),
                      //           child: Padding(
                      //             padding: EdgeInsets.all(Dimensions.five),
                      //             child: Icon(Icons.share, size: Dimensions.thirty,),
                      //           )
                      //       ),
                      //     ),
                      //   ),
                      // ),
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
                      const Divider(),
                      Text(widget.name,style: TextStyle(fontSize: Dimensions.twenty, fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left,),
                      SizedBox(height: Dimensions.ten,),
                      Text("by, ${widget.author}",style: TextStyle(fontSize: Dimensions.fifteen, fontWeight: FontWeight.w400), maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left,),
                      SizedBox(height: Dimensions.fifteen,),
                      Text( widget.description,style: TextStyle(fontSize: Dimensions.fifteen, fontWeight: FontWeight.w300), maxLines: readMore ? 30 : 4, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left,),
                      widget.description.length > 200 ? Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {
                              setState(() {
                                readMore = !readMore;
                              });
                            },
                            child: Text(readMore ? "Read Less" : "Read More",style: const TextStyle(color: Colors.blue,decoration: TextDecoration.underline),)),
                      ) : Container(),
                      const Divider(),
                      SizedBox(height: Dimensions.ten,),
                      Text("General", style: TextStyle(fontSize: Dimensions.fifteen,fontWeight: FontWeight.bold),),
                      SizedBox(height: Dimensions.fifteen,),
                      TwoTextInRow(title: 'Author', pair: widget.author,),
                      TwoTextInRow(title: 'Date Uploaded', pair: widget.dateUploaded,),
                      TwoTextInRow(title: 'Category', pair: widget.category,),
                      SizedBox(height: Dimensions.twenty,),
                      SizedBox(
                        width: double.infinity,
                        height: Dimensions.fifty,
                        child: CustomButton(
                            onPressed: (){
                              // launchURL("https://www.printzkart.in/shop");
                              var url = Uri.parse(widget.modelFileUrl.toString());
                              launchUrl(url);
                              // downloadModel(widget.modelFileUrl);
                              // final downloadUrl = getModelDownloadUrl(widget.modelFileUrl);
                              // downloadUrl.then((url) {
                              //   downloadModel(url);
                              //   // print(url);
                              // });
                            },
                            title: "Get Model"
                        ),
                      )
                      // widget.category == "free"
                      //     ? SizedBox(
                      //   width: double.infinity,
                      //   height: Dimensions.fifty,
                      //   child: ElevatedButton(
                      //       onPressed: (){
                      //         // launchURL("https://www.printzkart.in/shop");
                      //         // var url = Uri.parse("https://www.printzkart.in/shop");
                      //         // launchUrl(url);
                      //       },
                      //       child: Text("Get Model")
                      //   ),
                      // )
                      //     : SizedBox(
                      //   width: double.infinity,
                      //   height: Dimensions.fifty,
                      //   child: ElevatedButton(
                      //       style: ElevatedButton.styleFrom(
                      //         backgroundColor: Colors.orange, // Set the desired background color here
                      //       ),
                      //       onPressed: (){
                      //         // launchURL("https://www.printzkart.in/shop");
                      //         // var url = Uri.parse("https://www.printzkart.in/shop");
                      //         // launchUrl(url);
                      //       },
                      //       child: Text("Get Model")
                      //   ),
                      // )

                      // Text("Specifications", style: TextStyle(fontSize: Dimensions.twenty,fontWeight: FontWeight.bold),),
                      // SizedBox(height: Dimensions.fifteen,),
                      // Text("General", style: TextStyle(fontSize: Dimensions.fifteen,fontWeight: FontWeight.bold),),
                      // SizedBox(height: Dimensions.fifteen,),
                      // TwoTextInRow(title: 'Color', pair: widget.color,),
                      // TwoTextInRow(title: 'Print Speed', pair: widget.printingSpeed,),
                      // TwoTextInRow(title: 'Auto Calibration Present', pair: widget.autoCalibration,),
                      // TwoTextInRow(title: 'Printing Technology', pair: widget.printingTechnology,),
                      // TwoTextInRow(title: 'Print Bed Type', pair: widget.bedType,),
                      // TwoTextInRow(title: 'SD Card Support', pair: widget.sdCardSupported,),
                      // TwoTextInRow(title: 'Build Volume', pair: widget.buildVolume,),
                      // TwoTextInRow(title: 'Power Consumption', pair: widget.powerConsumption,),
                      // TwoTextInRow(title: 'Nozzle Diameter', pair: widget.nozzleDiameter,),
                      // TwoTextInRow(title: 'Filament Diameter', pair: widget.filamentDiameter,),
                      //
                      // Text("Dimensions", style: TextStyle(fontSize: Dimensions.fifteen,fontWeight: FontWeight.bold),),
                      // SizedBox(height: Dimensions.fifteen,),
                      // TwoTextInRow(title: 'Height', pair: widget.height,),
                      // TwoTextInRow(title: 'Width', pair: widget.width,),
                      // TwoTextInRow(title: 'Weight', pair: widget.weight,),
                      //
                      // Text("Warranty", style: TextStyle(fontSize: Dimensions.fifteen,fontWeight: FontWeight.bold),),
                      // SizedBox(height: Dimensions.fifteen,),
                      // TwoTextInRow(title: 'Warranty Summary', pair: widget.warrantySummary,),
                      // TwoTextInRow(title: 'Service Type', pair: widget.serviceType,),
                      // TwoTextInRow(title: 'Covered in Warranty', pair: widget.coveredInWarranty,),
                      // TwoTextInRow(title: 'Not Covered in Warranty', pair: widget.notCoveredInWarranty,),

                    ],
                  ),
                ),
              ],
            ),
          ),
          Visibility(
              visible: _showProgressIndicator,
              child: const Opacity(
                opacity: 0.4,
                child: ModalBarrier(dismissible: false, color: Colors.black),
              )),
          Visibility(
            visible: _showProgressIndicator,
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          ),
        ]
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.tealAccent: Colors.teal,
        onPressed: (){
          var msg = 'Hey,Check out this amazing 3D Model I found on ${Strings.appTitle}! You can download the app and discover more like this from the Google Play Store: ${Strings.playStoreLink}';
          _shareFile(widget.thumbnailUrl, msg);
        },
        child: const Icon(Icons.share),
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
