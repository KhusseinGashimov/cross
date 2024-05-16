class Stuff {
  late String? id;
  late String name;
  late String image;
  late String? description;

  Stuff(this.id, this.name, this.image, this.description);

  

  static Stuff fromJson(Map<String, dynamic> json) {
    return Stuff(
      json['id'],
      json['name'],
      json['image'],
      json['description']
    );
  }

  Object? toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'description': description
    };
  }
}