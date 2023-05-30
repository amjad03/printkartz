class Video{
  final String id;
  final String name;
  final String description;
  final String videoUrl;
  final String imageUrl;

  Video({
    required this.id,
    required this.name,
    required this.description,
    required this.videoUrl,
    required this.imageUrl
  });

  factory Video.fromJson(Map<String, dynamic> json){
    return Video(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        videoUrl: json['videoUrl'],
        imageUrl: json['imageUrl']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'name': name,
      'description': description,
      'videoUrl': videoUrl,
      'imageUrl': imageUrl
    };
  }
}