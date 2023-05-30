class Machine {
  final String id;
  final String name;
  final String category;
  final String description;
  final String displayImage;
  final String brand;
  final String model;
  final String color;
  final String material;
  final String weight;
  final String dimensions;
  final String supportedFormat;

  Machine({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.displayImage,
    required this.brand,
    required this.model,
    required this.color,
    required this.material,
    required this.weight,
    required this.dimensions,
    required this.supportedFormat,
  });

  factory Machine.fromJson(Map<String, dynamic> json) {
    return Machine(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      description: json['description'],
      displayImage: json['displayImage'],
      brand: json['brand'],
      model: json['model'],
      color: json['color'],
      material: json['material'],
      weight: json['weight'],
      dimensions: json['dimensions'],
      supportedFormat: json['supportedFormat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'description': description,
      'displayImage': displayImage,
      'brand': brand,
      'model': model,
      'color': color,
      'material': material,
      'weight': weight,
      'dimensions': dimensions,
      'supportedFormat': supportedFormat,
    };
  }
}

class MachineModel{

  final String id;
  final String name;
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

  MachineModel({
    required this.id,
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

  factory MachineModel.fromJson(Map<String, dynamic> json){
    return MachineModel(
        id: json['id'],
        name: json['name'],
        actualPrice: json['actualPrice'],
        salePrice: json['salePrice'],
        description: json['description'],
        displayImage: json['displayImage'],
        imageGallery:  List<String>.from(json['imageGallery']),
        color: json['color'],
        printingSpeed: json['printingSpeed'],
        autoCalibration: json['autoCalibration'],
        printingTechnology: json['printingTechnology'],
        bedType: json['bedType'],
        sdCardSupported: json['sdCardSupported'],
        buildVolume: json['buildVolume'],
        powerConsumption: json['powerConsumption'],
        nozzleDiameter: json['nozzleDiameter'],
        filamentDiameter: json['filamentDiameter'],
        height: json['height'],
        width: json['width'],
        weight: json['weight'],
        warrantySummary: json['warrantySummary'],
        serviceType: json['serviceType'],
        coveredInWarranty: json['coveredInWarranty'],
        notCoveredInWarranty: json['notCoveredInWarranty'],
        tags: List<String>.from(json['tags']),
    );
  }

  Map<String, dynamic> toJson() {
    return{
      'id': id,
      'name': name,
      'actualPrice': actualPrice,
      'salePrice': salePrice,
      'description': description,
      'displayImage': displayImage,
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
      'tags': tags

    };
  }
}
