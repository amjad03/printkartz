class ThreeDModel{

  final String id;
  final String name;
  final String category;
  final String color;
  final String displayImage;
  final String modelUrl;

  ThreeDModel({
    required this.id,
    required this.name,
    required this.category,
    required this.color,
    required this.displayImage,
    required this.modelUrl
  });

  factory ThreeDModel.fromJson(Map<String, dynamic> json){
    return ThreeDModel(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      color: json['color'],
      displayImage: json['displayImg'],
      modelUrl: json['modelUrl'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'name': name,
      'category': category,
      'color': color,
      'displayImg': displayImage,
      'modelUrl': modelUrl,
    };
  }
}

class ThreeDObjectsModel{
  final String id;
  final String name;
  final String description;
  final String modelFileUrl;
  final String displayImage;
  final List imageGallery;
  final List tags;
  final String author;
  final String dateUploaded;
  final String category;

  ThreeDObjectsModel({
    required this.id,
    required this.name,
    required this.description,
    required this.modelFileUrl,
    required this.displayImage,
    required this.imageGallery,
    required this.tags,
    required this.author,
    required this.dateUploaded,
    required this.category
  });

  factory ThreeDObjectsModel.fromJson(Map<String, dynamic> json){
    return ThreeDObjectsModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        modelFileUrl: json['modelFileUrl'],
        displayImage: json['displayImage'],
        imageGallery: List<String>.from(json['imageGallery']),
        tags: List<String>.from(json['tags']),
        author: json['author'],
        dateUploaded: json['dateUploaded'],
        category: json['category']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'name': name,
      'description': description,
      'modelFileUrl': modelFileUrl,
      'displayImage': displayImage,
      'imageGallery': imageGallery,
      'tags': tags,
      'author': author,
      'dateUploaded': dateUploaded,
      'category': category
    };
  }
}