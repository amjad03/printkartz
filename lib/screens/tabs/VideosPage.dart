import 'package:flutter/material.dart';
import 'package:Printzkart/models/videos_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../constants/constants.dart';
import '../../constants/dimensions.dart';
import '../../services/data_service.dart';

class VideosPage extends StatefulWidget {
  const VideosPage({Key? key}) : super(key: key);

  @override
  State<VideosPage> createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {

  bool isLoading = false;

  List<Video> _videos = [];

  void loadVideoData() async {
    DataService dataService = DataService();
    List<Video> videos = await dataService.getVideosData();
    setState(() {
      _videos = videos;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    loadVideoData();
  }

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black;
    // print(_videos.length);
    return Scaffold(
        body: Stack(
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
                  Text("Videos", style: TextStyle(fontSize: Dimensions.thirty),textAlign: TextAlign.center,),
                  const Divider(),
                  Padding(
                      padding: const EdgeInsets.all(10),
                      // child: GridView.builder(
                      //   scrollDirection: Axis.vertical,
                      //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      //       crossAxisCount: 2,
                      //       crossAxisSpacing: 10,
                      //       mainAxisSpacing: 10
                      //   ),
                      //   itemCount: 10,
                      //   itemBuilder: (context, index) => Container(
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(10),
                      //       color: Colors.indigo,
                      //     ),
                      //   ),
                      // ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: _videos.length,
                        itemBuilder: (context, index) {
                          // FlutterYoutube.playYoutubeVideoByUrl(
                          //   videoUrl: _videos[index].videoUrl,
                          //   autoPlay: false,
                          //   fullScreen: false,
                          //   appBarVisible: true,
                          //   apiKey: Strings.apiKey,
                          // );
                          String videoId;
                          videoId = YoutubePlayer.convertUrlToId(_videos[index].videoUrl)!;
                          // print("\n\n$videoId"); // BBAyRBTfsOU
                          YoutubePlayerController controller = YoutubePlayerController(
                            // initialVideoId: 'iLnmTe5Q2Qw',
                            initialVideoId: videoId,
                            flags: const YoutubePlayerFlags(
                              autoPlay: false,

                            ),

                            // flags: YoutubePlayerFlags(
                            //
                            // )
                          );
                          return Padding(
                            padding: EdgeInsets.only(bottom: Dimensions.ten),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_videos[index].name, style: TextStyle(fontSize: Dimensions.twenty), maxLines: 2,),
                                SizedBox(height: Dimensions.fifteen,),
                                Container(
                                  width: double.maxFinite,
                                  height: Dimensions.twoHundred,
                                  color: Colors.black38,
                                  child: YoutubePlayer(
                                    // context: context,
                                    // initialVideoId: "iLnmTe5Q2Qw",
                                    // flags: YoutubePlayerFlags(
                                    //   autoPlay: true,
                                    //   showVideoProgressIndicator: true,
                                    // ),
                                    // videoProgressIndicatorColor: Colors.amber,
                                    // progressColors: ProgressColors(
                                    //   playedColor: Colors.amber,
                                    //   handleColor: Colors.amberAccent,
                                    // ),
                                    // onPlayerInitialized: (controller) {
                                    //   _controller = controller..addListener(listener);
                                    // },
                                    controller: controller,
                                    aspectRatio: 16/9,
                                    showVideoProgressIndicator: true,
                                  ),
                                ),
                                SizedBox(height: Dimensions.twenty,),
                                const Divider()
                              ],
                            ),
                          );

                        },
                      )
                  ),
                  // Expanded(
                  //   child: Padding(
                  //       padding: const EdgeInsets.all(10),
                  //       // child: GridView.builder(
                  //       //   scrollDirection: Axis.vertical,
                  //       //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //       //       crossAxisCount: 2,
                  //       //       crossAxisSpacing: 10,
                  //       //       mainAxisSpacing: 10
                  //       //   ),
                  //       //   itemCount: 10,
                  //       //   itemBuilder: (context, index) => Container(
                  //       //     decoration: BoxDecoration(
                  //       //       borderRadius: BorderRadius.circular(10),
                  //       //       color: Colors.indigo,
                  //       //     ),
                  //       //   ),
                  //       // ),
                  //       child: ListView.builder(
                  //         itemCount: _videos.length,
                  //         itemBuilder: (context, index) {
                  //           // FlutterYoutube.playYoutubeVideoByUrl(
                  //           //   videoUrl: _videos[index].videoUrl,
                  //           //   autoPlay: false,
                  //           //   fullScreen: false,
                  //           //   appBarVisible: true,
                  //           //   apiKey: Strings.apiKey,
                  //           // );
                  //           String videoId;
                  //           videoId = YoutubePlayer.convertUrlToId(_videos[index].videoUrl)!;
                  //           print("\n\n$videoId"); // BBAyRBTfsOU
                  //           YoutubePlayerController controller = YoutubePlayerController(
                  //             // initialVideoId: 'iLnmTe5Q2Qw',
                  //             initialVideoId: videoId,
                  //             flags: const YoutubePlayerFlags(
                  //               autoPlay: false,
                  //
                  //             ),
                  //
                  //             // flags: YoutubePlayerFlags(
                  //             //
                  //             // )
                  //           );
                  //           return Padding(
                  //             padding: EdgeInsets.only(bottom: Dimensions.ten),
                  //             child: Column(
                  //               mainAxisAlignment: MainAxisAlignment.start,
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 Text(_videos[index].name, style: TextStyle(fontSize: Dimensions.twenty), maxLines: 2,),
                  //                 SizedBox(height: Dimensions.fifteen,),
                  //                 Container(
                  //                   width: double.maxFinite,
                  //                   height: Dimensions.twoHundred,
                  //                   color: Colors.black38,
                  //                   child: YoutubePlayer(
                  //                     // context: context,
                  //                     // initialVideoId: "iLnmTe5Q2Qw",
                  //                     // flags: YoutubePlayerFlags(
                  //                     //   autoPlay: true,
                  //                     //   showVideoProgressIndicator: true,
                  //                     // ),
                  //                     // videoProgressIndicatorColor: Colors.amber,
                  //                     // progressColors: ProgressColors(
                  //                     //   playedColor: Colors.amber,
                  //                     //   handleColor: Colors.amberAccent,
                  //                     // ),
                  //                     // onPlayerInitialized: (controller) {
                  //                     //   _controller = controller..addListener(listener);
                  //                     // },
                  //                     controller: controller,
                  //                     aspectRatio: 16/9,
                  //                     showVideoProgressIndicator: true,
                  //                   ),
                  //                 ),
                  //                 SizedBox(height: Dimensions.twenty,),
                  //                 const Divider()
                  //               ],
                  //             ),
                  //           );
                  //
                  //         },
                  //       )
                  //   ),
                  // ),
                ],
              ),
            ),
          ]
        )
    );
  }
}
