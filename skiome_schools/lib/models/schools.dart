// ignore_for_file: public_member_api_docs, sort_constructors_first
class Schools {
  String? uid;
  String? name;
  String? email;
  String? photoUrl;
  String? status;
  String? centreUID;
  String? schoolAddress;
  String? cityCode;
  Schools({
    this.uid,
    this.name,
    this.email,
    this.photoUrl,
    this.status,
    this.centreUID,
    this.schoolAddress,
    this.cityCode,
  });
  Schools.fromJson(Map<String, dynamic> json) {
    uid = json["uid"];
    name = json["name"];
    email = json["email"];
    photoUrl = json["photoUrl"];
    status = json["status"];
    centreUID = json["centreUID"];
    schoolAddress = json["schoolAddress"];
    cityCode = json["cityCode"];
  }
}
