import 'dart:convert';

import 'all_product_model.dart';

class CartModel {
  Products? productModel;
  int? qty;
  int? colorId;
  int? boxId;
  bool? isCandel;
  double? totals;
  String? colorName;
  String? boxName;
  CartModel(
      {this.productModel,
      this.qty,
      this.totals,
      this.boxId,
      this.colorId,
      this.colorName,
      this.boxName,
      this.isCandel});

  CartModel.fromJson(Map<String, dynamic> json) {
    productModel = json['product_model'] != null
        ? new Products.fromJson(json['product_model'])
        : null;
    qty = json['qty'];
    isCandel = json['is_candel'];
    colorId = json['color_id'];
    boxId = json['box_id'];
    colorName = json['color_name'];
    boxName = json['box_name'];
    totals = json['totals'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.productModel != null) {
      data['product_model'] = this.productModel!.toJson();
    }
    data['qty'] = this.qty;
    data['box_name'] = this.boxName;
    data['color_name'] = this.colorName;
    data['is_candel'] = this.isCandel;
    data['color_id'] = this.colorId;
    data['box_id'] = this.boxId;
    data['totals'] = this.totals;
    return data;
  }

  static Map<String, dynamic> toMap(CartModel model) => {
        "product_model": model.productModel,
        "qty": model.qty,
        "is_candel": model.isCandel,
        "totals": model.totals,
        "color_id": model.colorId,
        "box_id": model.boxId,
        "color_name": model.colorName,
        "box_name": model.boxName
      };

  static String encode(List<CartModel> lists) => json.encode(
        lists
            .map<Map<String, dynamic>>((model) => CartModel.toMap(model))
            .toList(),
      );

  static List<CartModel> decode(String list) =>
      (json.decode(list) as List<dynamic>)
          .map<CartModel>((item) => CartModel.fromJson(item))
          .toList();
}
