class ProductDetailModel {
  Product? product;

  ProductDetailModel({this.product});

  ProductDetailModel.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  String? title;
  String? descriptionMain;
  String? imageMain;
  String? material;
  List<String>? gallery;
  double? price;
  List<Colors>? colors;
  List<String>? boxes;
  String? benefits;
  Product({
    this.id,
    this.benefits,
    this.title,
    this.descriptionMain,
    this.imageMain,
    this.material,
    this.gallery,
    this.price,
    this.colors,
    this.boxes,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    benefits = json['benefits'];
    title = json['title'];
    descriptionMain = json['description_main'];
    imageMain = json['image_main'];
    material = json['material'];
    benefits = json['benefits'];
    gallery = List<String>.from(json['gallery'] ?? []);
    price =
        json['price'] != null ? double.parse(json['price'].toString()) : null;
    if (json['colors'] != null) {
      colors = (json['colors'] as List)
          .map((color) => Colors.fromJson(color))
          .toList();
    }
    boxes = List<String>.from(json['boxes'] ?? []);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['benefits'] = benefits;
    data['title'] = title;
    data['description_main'] = descriptionMain;
    data['image_main'] = imageMain;
    data['material'] = material;
    data['gallery'] = gallery;
    data['price'] = price;
    if (colors != null) {
      data['colors'] = colors!.map((color) => color.toJson()).toList();
    }
    data['boxes'] = boxes;
    return data;
  }
}

class Colors {
  int? id;
  List<String>? image;
  String? name;
  String? color;

  Colors({this.id, this.image, this.name, this.color});

  Colors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = List<String>.from(json['image'] ?? []);
    name = json['name'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['image'] = image;
    data['name'] = name;
    data['color'] = color;
    return data;
  }
}
