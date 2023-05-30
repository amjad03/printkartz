import 'package:Printzkart/constants/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../theme/model_theme.dart';


class CarouselLoading extends StatelessWidget {
  const CarouselLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // final themeProvider = Provider.of<ModelTheme>(context);
    // final color = themeProvider.themeMode == ThemeMode.dark ? Colors.white : Colors.grey ;
    var color = Theme.of(context).brightness == Brightness.dark ? const Color(0xFF333333) : Colors.white;

    return Shimmer.fromColors(
      highlightColor: Colors.white,
      baseColor: Colors.grey.shade300,
      child: Column(
        children: [
          FractionallySizedBox(
            widthFactor: 0.9,
            child: Container(
              // height: Dimensions.oneTwenty,
              // margin: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child:ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                child: AspectRatio(
                  aspectRatio: 16 / 8,
                  child: Container(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color),
              ),
              const SizedBox(width: 3,),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color),
              ),
              const SizedBox(width: 3,),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color),
              ),
              const SizedBox(width: 3,),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color),
              ),
              const SizedBox(width: 3,),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color),
              )
            ],
          )
        ],
      ),
    );
  }
}