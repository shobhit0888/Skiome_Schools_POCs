// ignore_for_file: public_member_api_docs, sort_constructors_first
class Orders {
  String? addressId;
  String? isSuccess;
  String? orderBy;
  String? orderTime;
  String? paymentDetail;
  List<String>? productIds;
  String? status;
  int? totalAmount;
  Orders({
    this.addressId,
    this.isSuccess,
    this.orderBy,
    this.orderTime,
    this.paymentDetail,
    this.productIds,
    this.status,
    this.totalAmount,
  });
  Orders.fromJson(Map<String, dynamic> json) {
    addressId = json["addressId"];
    isSuccess = json["isSuccess"];
    orderBy = json["orderBy"];
    orderTime = json["orderTime"];
    paymentDetail = json["paymentDetail"];
    productIds = json["productIds"];
    status = json["status"];
    totalAmount = json["totalAmount"];
  }
}
