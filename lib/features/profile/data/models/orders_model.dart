class OrdersModel {
  List<Orders>? orders;

  OrdersModel({this.orders});

  OrdersModel.fromJson(Map<String, dynamic>? json) {
    if (json?['orders'] != null) {
      orders = <Orders>[];
      json?['orders'].forEach((v) {
        orders!.add(Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orders != null) {
      data['orders'] = orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orders {
  String? orderId;
  String? invoiceNumber;
  String? orderStatus;
  String? grandTotal;
  String? createdAt;

  Orders(
      {this.orderId,
      this.invoiceNumber,
      this.orderStatus,
      this.grandTotal,
      this.createdAt});

  Orders.fromJson(Map<String, dynamic>? json) {
    orderId = json?['order_id'];
    invoiceNumber = json?['invoice_number'];
    orderStatus = json?['order_status'];
    grandTotal = json?['grand_total'];
    createdAt = json?['created_at'];
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['invoice_number'] = invoiceNumber;
    data['order_status'] = orderStatus;
    data['grand_total'] = grandTotal;
    data['created_at'] = createdAt;
    return data;
  }
}
