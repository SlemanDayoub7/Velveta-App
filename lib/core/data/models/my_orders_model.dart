class MyOrdersModel {
  List<Orders>? orders;

  MyOrdersModel({this.orders});

  MyOrdersModel.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(new Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orders != null) {
      data['orders'] = this.orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orders {
  int? id;
  int? userId;
  int? priceTotal;
  int? shippingPrice;
  double? priceTotalShipping;
  String? paymentMethod;
  String? status;
  CreatedAt? createdAt;

  Orders(
      {this.id,
      this.userId,
      this.priceTotal,
      this.shippingPrice,
      this.priceTotalShipping,
      this.paymentMethod,
      this.status,
      this.createdAt});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    priceTotal = json['price_total'];
    shippingPrice = json['shipping_price'];
    priceTotalShipping = json['price_total_shipping'];
    paymentMethod = json['payment_method'];
    status = json['status'];
    createdAt = json['created_at'] != null
        ? new CreatedAt.fromJson(json['created_at'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['price_total'] = this.priceTotal;
    data['shipping_price'] = this.shippingPrice;
    data['price_total_shipping'] = this.priceTotalShipping;
    data['payment_method'] = this.paymentMethod;
    data['status'] = this.status;
    if (this.createdAt != null) {
      data['created_at'] = this.createdAt!.toJson();
    }
    return data;
  }
}

class CreatedAt {
  String? day;
  String? month;
  String? year;
  String? hour;
  String? minute;
  String? second;

  CreatedAt(
      {this.day, this.month, this.year, this.hour, this.minute, this.second});

  CreatedAt.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    month = json['month'];
    year = json['year'];
    hour = json['hour'];
    minute = json['minute'];
    second = json['second'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['month'] = this.month;
    data['year'] = this.year;
    data['hour'] = this.hour;
    data['minute'] = this.minute;
    data['second'] = this.second;
    return data;
  }
}
