
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/filaments_model.dart';
import '../models/machine_model.dart';
import '../models/threeDmodels_model.dart';
import '../models/videos_model.dart';

class DataService{


  final CollectionReference machineRef = FirebaseFirestore.instance.collection('machines');
  final CollectionReference modelRef = FirebaseFirestore.instance.collection('models');
  final CollectionReference filamentRef = FirebaseFirestore.instance.collection('filaments');
  final CollectionReference videoRef = FirebaseFirestore.instance.collection('videos');


  // Future<List<Machine>> getMachinesData() async {
  //   List<Machine> machines = [];
  //
  //   final snapshot = await machineRef.get();
  //   for (QueryDocumentSnapshot documentSnapshot in snapshot.docs) {
  //     String id = documentSnapshot.id;
  //     // print("\n\nthis is the id $id");
  //     final data = documentSnapshot.data() as Map<String, dynamic>;
  //     // print("\n\nthis is the data $data");
  //     Machine machine = Machine(
  //         id: id,
  //         category: data["category"].toString(),
  //         description: data["description"].toString(),
  //         displayImage: data["displayImage"].toString(),
  //         name: data["name"].toString(),
  //         brand: data["brand"].toString(),
  //         model: data["model"].toString(),
  //         color: data["color"].toString(),
  //         material: data["material"].toString(),
  //         weight: data["weight"].toString(),
  //         dimensions: data["dimensions"].toString(),
  //         supportedFormat: data["supportedFormat"].toString(),
  //     );
  //     machines.add(machine);
  //   }
  //   return machines;
  // }
  Future<List<MachineModel>> getMachinesData() async {
    List<MachineModel> machines = [];

    final snapshot = await machineRef.get();
    for (QueryDocumentSnapshot documentSnapshot in snapshot.docs) {
      String id = documentSnapshot.id;
      // print("\n\nthis is the id $id");
      final data = documentSnapshot.data() as Map<String, dynamic>;
      // print("\n\nthis is the data $data");
      MachineModel machine = MachineModel(
        id: id,
        name: data['name'],
        actualPrice: double.parse(data['actualPrice'].toString()),
        salePrice: double.parse(data['salePrice'].toString()),
        // actualPrice: data['actualPrice'],
        // salePrice: data['salePrice'],
        description: data['description'],
        displayImage: data['imageGallery'][0],
        imageGallery:  data['imageGallery'],
        color: data['color'],
        printingSpeed: data['printingSpeed'],
        autoCalibration: data['autoCalibration'],
        printingTechnology: data['printingTechnology'],
        bedType: data['bedType'],
        sdCardSupported: data['sdCardSupported'],
        buildVolume: data['buildVolume'],
        powerConsumption: data['powerConsumption'],
        nozzleDiameter: data['nozzleDiameter'],
        filamentDiameter: data['filamentDiameter'],
        height: data['height'],
        width: data['width'],
        weight: data['weight'],
        warrantySummary: data['warrantySummary'],
        serviceType: data['serviceType'],
        coveredInWarranty: data['coveredInWarranty'],
        notCoveredInWarranty: data['notCoveredInWarranty'],
        tags: data['tags'],
      );
      machines.add(machine);
    }
    return machines;
  }

  // Future<List<ThreeDModel>> getModelsData() async {
  //   List<ThreeDModel> threeDModels = [];
  //
  //   final snapshot = await modelRef.get();
  //   for (QueryDocumentSnapshot documentSnapshot in snapshot.docs) {
  //     String id = documentSnapshot.id;
  //     final data = documentSnapshot.data() as Map<String, dynamic>;
  //     ThreeDModel threeDModel = ThreeDModel(
  //       id: id,
  //       category: data["category"],
  //       name: data["name"],
  //       color: data['color'],
  //       displayImage: data['displayImage'],
  //       modelUrl: data["modelurl"],
  //     );
  //     threeDModels.add(threeDModel);
  //   }
  //   return threeDModels;
  // }
  Future<List<ThreeDObjectsModel>> getModelsData() async {
    List<ThreeDObjectsModel> threeDModels = [];

    final snapshot = await modelRef.get();
    for (QueryDocumentSnapshot documentSnapshot in snapshot.docs) {
      String id = documentSnapshot.id;
      final data = documentSnapshot.data() as Map<String, dynamic>;
      ThreeDObjectsModel threeDObjectsModel = ThreeDObjectsModel(
          id: id,
          name: data['name'],
          description: data['description'],
          modelFileUrl: data['modelFileUrl'],
          displayImage: data['displayImage'],
          imageGallery: data['imageGallery'],
          tags: data['tags'],
          author: data['author'],
          dateUploaded: data['dateUploaded'],
          category: data['category']
      );
      threeDModels.add(threeDObjectsModel);
    }
    return threeDModels;
  }

  // Future<List<Filament>> getFilamentsData() async {
  //   List<Filament> filaments = [];
  //
  //   final snapshot = await filamentRef.get();
  //   for (QueryDocumentSnapshot documentSnapshot in snapshot.docs) {
  //     String id = documentSnapshot.id;
  //     final data = documentSnapshot.data() as Map<String, dynamic>;
  //     Filament filament = Filament(
  //       id: id,
  //       name: data["name"],
  //       color: data["color"],
  //       type: data["type"],
  //       displayImage: data["displayImage"],
  //     );
  //     filaments.add(filament);
  //   }
  //   return filaments;
  // }
  Future<List<FilamentModel>> getFilamentsData() async {
    List<FilamentModel> filaments = [];

    final snapshot = await filamentRef.get();
    for (QueryDocumentSnapshot documentSnapshot in snapshot.docs) {
      String id = documentSnapshot.id;
      final data = documentSnapshot.data() as Map<String, dynamic>;
      FilamentModel filament = FilamentModel(
          id: id,
          name: data['name'],
          description: data['description'],
          displayImage: data['displayImage'],
          imageGallery: data['imageGallery'],
          brand: data['brand'],
          modelNumber: data['modelNumber'],
          color: data['color'],
          material: data['material'],
          printTempRange: data['printTempRange'],
          compatibleWith: data['compatibleWith'],
          length: data['length'],
          filamentDiameter: data['filamentDiameter'],
          filamentWeight: data['filamentWeight'],
          tags: data['tags']
      );
      filaments.add(filament);
    }
    return filaments;
  }


  Future<List<Video>> getVideosData() async {
    List<Video> videos = [];

    final snapshot = await videoRef.get();
    for (QueryDocumentSnapshot documentSnapshot in snapshot.docs) {
      String id = documentSnapshot.id;
      final data = documentSnapshot.data() as Map<String, dynamic>;
      print("\n\nthis is the data $data");
      Video video = Video(
        id: id,
        name: data["name"],
        description: data["description"],
        videoUrl: data["videoUrl"],
        imageUrl: data["imageUrl"],
      );
      videos.add(video);
    }
    return videos;
  }

  Future<List> getSearchResult(query) async {
    List result = [];



    // final snapshot = await modelRef.get();
    // for (QueryDocumentSnapshot documentSnapshot in snapshot.docs) {
    //   String id = documentSnapshot.id;
    //   final data = documentSnapshot.data() as Map<String, dynamic>;
    //   ThreeDObjectsModel threeDObjectsModel = ThreeDObjectsModel(
    //       id: id,
    //       name: data['name'],
    //       description: data['description'],
    //       modelFileUrl: data['modelFileUrl'],
    //       displayImage: data['displayImage'],
    //       imageGallery: data['imageGallery'],
    //       tags: data['tags'],
    //       author: data['author'],
    //       dateUploaded: data['dateUploaded'],
    //       category: data['category']
    //   );
    //   result.add(threeDObjectsModel);
    // }
    // return result;
    final snapshot1 = await modelRef.where('tags', arrayContains: query,).get();
    // final snapshot1 = await modelRef.where('name', isEqualTo: query,).get();
    // final snapshot1a = await modelRef.where('category', isEqualTo: query,).get();

    for(var doc in snapshot1.docs){
      var id = doc.id;
      result.add(doc.data() as Map<String, dynamic>);
    }
    // for(var doc in snapshot1a.docs){
    //   result.add(doc.data());
    // }


    // final snapshot2 = await machineRef.get();
    // for (QueryDocumentSnapshot documentSnapshot in snapshot2.docs) {
    //   String id = documentSnapshot.id;
    //   // print("\n\nthis is the id $id");
    //   final data = documentSnapshot.data() as Map<String, dynamic>;
    //   // print("\n\nthis is the data $data");
    //   MachineModel machine = MachineModel(
    //     id: id,
    //     name: data['name'],
    //     actualPrice: double.parse(data['actualPrice'].toString()),
    //     salePrice: double.parse(data['salePrice'].toString()),
    //     // actualPrice: data['actualPrice'],
    //     // salePrice: data['salePrice'],
    //     description: data['description'],
    //     displayImage: data['imageGallery'][0],
    //     imageGallery:  data['imageGallery'],
    //     color: data['color'],
    //     printingSpeed: data['printingSpeed'],
    //     autoCalibration: data['autoCalibration'],
    //     printingTechnology: data['printingTechnology'],
    //     bedType: data['bedType'],
    //     sdCardSupported: data['sdCardSupported'],
    //     buildVolume: data['buildVolume'],
    //     powerConsumption: data['powerConsumption'],
    //     nozzleDiameter: data['nozzleDiameter'],
    //     filamentDiameter: data['filamentDiameter'],
    //     height: data['height'],
    //     width: data['width'],
    //     weight: data['weight'],
    //     warrantySummary: data['warrantySummary'],
    //     serviceType: data['serviceType'],
    //     coveredInWarranty: data['coveredInWarranty'],
    //     notCoveredInWarranty: data['notCoveredInWarranty'],
    //     tags: data['tags'],
    //   );
    //   result.add(machine);
    // }
    final snapshot2 = await machineRef.where('tags', arrayContains: query,).get();
    // final snapshot2 = await machineRef.where('name', isEqualTo: query,).get();
    // final snapshot2a = await machineRef.where('category', isEqualTo: query,).get();

    for(var doc in snapshot2.docs){
      result.add(doc.data() as Map<String, dynamic>);
      // result.add(doc.data());
    }
    // for(var doc in snapshot2a.docs){
    //   result.add(doc.data());
    // }



    // final snapshot3 = await filamentRef.get();
    // for (QueryDocumentSnapshot documentSnapshot in snapshot3.docs) {
    //   String id = documentSnapshot.id;
    //   final data = documentSnapshot.data() as Map<String, dynamic>;
    //   FilamentModel filament = FilamentModel(
    //       id: id,
    //       name: data['name'],
    //       description: data['description'],
    //       displayImage: data['displayImage'],
    //       imageGallery: data['imageGallery'],
    //       brand: data['brand'],
    //       modelNumber: data['modelNumber'],
    //       color: data['color'],
    //       material: data['material'],
    //       printTempRange: data['printTempRange'],
    //       compatibleWith: data['compatibleWith'],
    //       length: data['length'],
    //       filamentDiameter: data['filamentDiameter'],
    //       filamentWeight: data['filamentWeight'],
    //       tags: data['tags']
    //   );
    //   result.add(filament);
    // }
    final snapshot3 = await filamentRef.where('tags', arrayContains: query,).get();
    // final snapshot3 = await filamentRef.where('name', isEqualTo: query,).get();
    // final snapshot3a = await filamentRef.where('category', isEqualTo: query,).get();

    for(var doc in snapshot3.docs){
      result.add(doc.data() as Map<String, dynamic>);
      // result.add(doc.data());
    }
    // for(var doc in snapshot3a.docs){
    //   result.add(doc.data());
    // }


    return result;
  }
}