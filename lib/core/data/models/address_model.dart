class AllAddressModel {
  List<UserShippingAddress>? userShippingAddress;

  AllAddressModel({this.userShippingAddress});

  AllAddressModel.fromJson(Map<String, dynamic> json) {
    if (json['user_shipping_address'] != null) {
      userShippingAddress = <UserShippingAddress>[];
      (json['user_shipping_address'] as List).forEach((address) {
        userShippingAddress!.add(UserShippingAddress.fromJson(address));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userShippingAddress != null) {
      data['user_shipping_address'] =
          this.userShippingAddress!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserShippingAddress {
  int? userId;
  String? addressLine;
  String? city;
  String? state;
  String? zipCode;
  UserShippingAddress({
    this.userId,
    this.addressLine,
    this.city,
    this.state,
    this.zipCode,
  });

  UserShippingAddress.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    addressLine = json['address_line'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zipCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['user_id'] = this.userId;
    data['address_line'] = this.addressLine;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zipCode'] = this.zipCode;

    return data;
  }
}
