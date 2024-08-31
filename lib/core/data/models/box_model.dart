class BoxModel {
  Boxes? boxes;

  BoxModel({this.boxes});

  BoxModel.fromJson(Map<String, dynamic> json) {
    boxes = json['boxes'] != null ? new Boxes.fromJson(json['boxes']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.boxes != null) {
      data['boxes'] = this.boxes!.toJson();
    }
    return data;
  }
}

class Boxes {
  int? id;
  List<String>? image;
  String? name;

  Boxes({this.id, this.image, this.name});

  Boxes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'].cast<String>();
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['name'] = this.name;
    return data;
  }
}
