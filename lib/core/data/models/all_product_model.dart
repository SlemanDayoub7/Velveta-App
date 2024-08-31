class AllProductModel {
  List<Products>? products;

  AllProductModel({this.products});

  factory AllProductModel.fromJson(Map<String, dynamic> json) {
    return AllProductModel(
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => Products.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? id;
  String? title;
  String? descriptionMain;
  String? imageMain;
  String? material;
  List<String>? gallery;
  double? price;
  String? type;
  String? createdAt;
  String? updatedAt;

  Products({
    this.id,
    this.title,
    this.descriptionMain,
    this.imageMain,
    this.material,
    this.gallery,
    this.price,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      id: json['id'] as int?,
      title: json['title'] as String?,
      descriptionMain: json['description_main'] as String?,
      imageMain: json['image_main'] as String?,
      material: json['material'] as String?,
      gallery: (json['gallery'] as List<dynamic>?)?.cast<String>(),
      price: (json['price'] as num?)?.toDouble(),
      type: json['type'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description_main'] = descriptionMain;
    data['image_main'] = imageMain;
    data['material'] = material;
    data['gallery'] = gallery;
    data['price'] = price;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
