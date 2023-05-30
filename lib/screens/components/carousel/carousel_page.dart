import '../../../controller/carousel_controller/controller.dart';
import 'carousel_loading.dart';
import './carousel_with_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBannerSlider extends StatelessWidget {
  const CustomBannerSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(
            () {
          if (carouselController.isLoading.value) {
            return const Center(
              child: CarouselLoading(),
            );
          } else {
            if (carouselController.carouselItemList.isNotEmpty) {
              return CarouselWithIndicator(
                  data: carouselController.carouselItemList);
            }
            else {
              return const Center(
                // child: Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: const [
                //     Icon(Icons.hourglass_empty),
                //     Text("Loading ...")
                //   ],
                // ),
              );
            }
          }
        },
      ),
    );
  }
}