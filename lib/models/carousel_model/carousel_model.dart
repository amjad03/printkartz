

class CarouselModel {
  CarouselModel({ required this.imageUrl,
    // required this.description,required this.title
  });

  // final String id;
  final String imageUrl;
  // final String description;
  // final String title;

  CarouselModel.fromJson(Map<String, Object?> json)
      : this(
        imageUrl: json['imageUrl']! as String,
        // description: json['description']! as String,
        // title: json['title']! as String
      );

  Map<String, Object?> toJson() {
    return {
      // 'title': id,
      'imageUrl': imageUrl,
      // 'description': description,
      // 'title': title,
    };
  }
}