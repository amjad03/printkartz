import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
// import 'package:Printzkartf/constants/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants/dimensions.dart';
import '../../../models/carousel_model/carousel_model.dart';
// import '../../models/carousel_model/carousel_model.dart';
// import '../../src/theme/theme.dart';



class CarouselWithIndicator extends StatefulWidget {
  final List<CarouselModel> data;

  const CarouselWithIndicator({Key? key, required this.data}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;
  late List<Widget> imageSliders;
  @override
  void initState() {
    imageSliders = widget.data.map((item) => Container(
      // height: Dimensions.oneTwenty,
      margin: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          // border: Border.all(color: Colors.black38, width: 1),
          borderRadius: BorderRadius.circular(Dimensions.ten),
          boxShadow: [
            BoxShadow(
                color: Colors.black38,
                blurRadius: Dimensions.five
            )
          ]
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(Dimensions.ten)),
          child: CachedNetworkImage(
              imageUrl: item.imageUrl,
              errorWidget: (context, url, error) => const Icon(Icons.error),
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Shimmer.fromColors(
                    highlightColor: Colors.white,
                    baseColor: Colors.grey.shade300,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child:ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                        child: AspectRatio(
                          aspectRatio: 16 / 8,
                          child: Container(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ),
                  ),
              fit: BoxFit.cover,
              // width: double.infinity,
            ),
        ),
      ),
    )).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // final themeProvider = Provider.of<ThemeProvider>(context);
    // final colorSelected = themeProvider.themeMode == ThemeMode.dark ? const Color.fromRGBO(255, 255, 255, 0.9) : const Color.fromRGBO(0, 0, 0, 0.9) ;
    // final colorUnselected = themeProvider.themeMode == ThemeMode.dark ? const Color.fromRGBO(255, 255, 255, 0.4) : const Color.fromRGBO(0, 0, 0, 0.4) ;
    var colorSelected = Theme.of(context).brightness == Brightness.dark ? const Color.fromRGBO(255, 255, 255, 0.9) : const Color.fromRGBO(0, 0, 0, 0.9) ;
    var colorUnselected = Theme.of(context).brightness == Brightness.dark ? const Color.fromRGBO(255, 255, 255, 0.4) : const Color.fromRGBO(0, 0, 0, 0.4) ;

    return Column(
        children: [
          CarouselSlider(
            items: imageSliders,
            options: CarouselOptions(
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                aspectRatio: 16/8,
                viewportFraction: 0.8,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.data.map((url) {
              int index = widget.data.indexOf(url);
              return Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? colorSelected
                      : colorUnselected,
                ),
              );
            }).toList(),
          ),
        ]
    );
  }
}