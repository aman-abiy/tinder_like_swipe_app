import 'dart:convert';

class User {

  String name;
  int age;
  String image;
  String location;
  double distance;
  
  User({
    required this.name,
    required this.age,
    required this.image,
    required this.location,
    required this.distance,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'image': image,
      'location': location,
      'distance': distance,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] ?? '',
      age: map['age'] ?? '',
      image: map['image'] ?? '',
      location: map['location'] ?? '',
      distance: map['distance']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(name: $name, age: $age, image: $image, location: $location, distance: $distance)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is User &&
      other.name == name &&
      other.age == age &&
      other.image == image &&
      other.location == location &&
      other.distance == distance;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      age.hashCode ^
      image.hashCode ^
      location.hashCode ^
      distance.hashCode;
  }
}
