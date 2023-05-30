class Filament{
  final String id;
  final String name;
  final String color;
  final String type;
  final String displayImage;
  // final String brand;
  // final String itemWeight;
  // final String itemDiameter;

  Filament({
    required this.id,
    required this.name,
    required this.color,
    required this.type,
    required this.displayImage,
  });

  factory Filament.fromJson(Map<String, dynamic> json){
    return Filament(
        id: json['id'],
        name: json['name'],
        color: json['color'],
        type: json['type'],
        displayImage: json['displayImage']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'name': name,
      'color': color,
      'type': type,
      'displayImage': displayImage,
    };
  }
}

class FilamentModel{
  final String id;
  final String name;
  final String description;
  final String displayImage;
  final List imageGallery;
  final String brand;
  final String modelNumber;
  final String color;
  final String material;
  final String printTempRange;
  final String compatibleWith;
  final String length;
  final String filamentDiameter;
  final String filamentWeight;
  final List tags;

  FilamentModel({
    required this.id,
    required this.name,
    required this.description,
    required this.displayImage,
    required this.imageGallery,
    required this.brand,
    required this.modelNumber,
    required this.color,
    required this.material,
    required this.printTempRange,
    required this.compatibleWith,
    required this.length,
    required this.filamentDiameter,
    required this.filamentWeight,
    required this.tags
  });

  factory FilamentModel.fromJson(Map<String, dynamic> json){
    return FilamentModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        displayImage: json['displayImage'],
        imageGallery: List<String>.from(json['imageGallery']),
        brand: json['brand'],
        modelNumber: json['modelNumber'],
        color: json['color'],
        material: json['material'],
        printTempRange: json['printTempRange'],
        compatibleWith: json['compatibleWith'],
        length: json['length'],
        filamentDiameter: json['filamentDiameter'],
        filamentWeight: json['filamentWeight'],
        tags: List<String>.from(json['tags']),
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'name': name,
      'description': description,
      'displayImage': displayImage,
      'imageGallery': imageGallery,
      'brand': brand,
      'modelNumber': modelNumber,
      'color': color,
      'material': material,
      'printTempRange': printTempRange,
      'compatibleWith': compatibleWith,
      'length': length,
      'filamentDiameter': filamentDiameter,
      'filamentWeight': filamentWeight,
      'tags': tags,
    };
  }
}