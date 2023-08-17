import '../../../constants/extensions.dart';

class CharacterModel {
  String? name;
  String? image;
  String? description;

  CharacterModel({this.name, this.image, this.description});

  CharacterModel.fromJson(Map<String, dynamic> json) {
    name = json['FirstURL'].toString().split("/").last.replaceAll("_", " ");
    image = ImageUrl.baseUrl + json['Icon']['URL'];
    description = json['Text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    return data;
  }
}
