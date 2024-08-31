class MyOrderDetailModel {
  List<OrderDetails>? orderDetails;

  MyOrderDetailModel({this.orderDetails});

  MyOrderDetailModel.fromJson(Map<String, dynamic> json) {
    if (json['order_details'] != null) {
      orderDetails = <OrderDetails>[];
      json['order_details'].forEach((v) {
        orderDetails!.add(new OrderDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderDetails != null) {
      data['order_details'] =
          this.orderDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderDetails {
  int? id;
  int? productId;
  int? boxId;
  int? colorId;
  int? price;
  int? orderId;
  int? quantity;
  int? isCandle;

  OrderDetails(
      {this.id,
      this.productId,
      this.boxId,
      this.colorId,
      this.price,
      this.orderId,
      this.quantity,
      this.isCandle});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    boxId = json['box_id'];
    colorId = json['color_id'];
    price = json['price'];
    orderId = json['order_id'];
    quantity = json['quantity'];
    isCandle = json['is_candle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['box_id'] = this.boxId;
    data['color_id'] = this.colorId;
    data['price'] = this.price;
    data['order_id'] = this.orderId;
    data['quantity'] = this.quantity;
    data['is_candle'] = this.isCandle;
    return data;
  }
}
