import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/carousel_model/carousel_model.dart';
import '../../services/banner_service/banner_service.dart';



class CarouselController extends GetxController {
  // static CarouselController instance = Get.find();
  static CarouselController instance = Get.put(CarouselController());
  RxList<CarouselModel> carouselItemList = List<CarouselModel>.empty(growable: true).obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }


  void getData() async {
    try {
      isLoading(true);
      var result = await BannerService().getBanners();
      carouselItemList.assignAll(result);
    }catch(e) {
      debugPrint(e.toString());
    }finally {
      isLoading(false);
    }
  }
}