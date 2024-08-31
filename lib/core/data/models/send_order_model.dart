class SendOrderModel {
  String? paymentMethod;
  ShippingAddress? shippingAddress;
  List<OrderDetails>? orderDetails;
  int? shippingId;

  SendOrderModel(
      {this.paymentMethod,
      this.shippingAddress,
      this.orderDetails,
      this.shippingId});

  SendOrderModel.fromJson(Map<String, dynamic> json) {
    paymentMethod = json['payment_method'];
    shippingAddress = json['shipping_address'] != null
        ? new ShippingAddress.fromJson(json['shipping_address'])
        : null;
    if (json['order_details'] != null) {
      orderDetails = <OrderDetails>[];
      json['order_details'].forEach((v) {
        orderDetails!.add(new OrderDetails.fromJson(v));
      });
    }
    shippingId = json['shipping_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_method'] = this.paymentMethod;
    if (this.shippingAddress != null) {
      data['shipping_address'] = this.shippingAddress!.toJson();
    }
    if (this.orderDetails != null) {
      data['order_details'] =
          this.orderDetails!.map((v) => v.toJson()).toList();
    }
    data['shipping_id'] = this.shippingId;
    return data;
  }
}

class ShippingAddress {
  String? addressLine;
  String? city;
  String? state;

  ShippingAddress({this.addressLine, this.city, this.state});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    addressLine = json['address_line'];
    city = json['city'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_line'] = this.addressLine;
    data['city'] = this.city;
    data['state'] = this.state;
    return data;
  }
}

class OrderDetails {
  int? productId;
  int? boxId;
  int? colorId;
  int? quantity;
  bool? isCandle;

  OrderDetails(
      {this.productId, this.boxId, this.colorId, this.quantity, this.isCandle});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    boxId = json['box_id'];
    colorId = json['color_id'];
    quantity = json['quantity'];
    isCandle = json['is_candle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['box_id'] = this.boxId;
    data['color_id'] = this.colorId;
    data['quantity'] = this.quantity;
    data['is_candle'] = this.isCandle;
    return data;
  }
}
