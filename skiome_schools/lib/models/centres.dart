class Centres {
  String? name;
  String? uid;
  String? photoUrl;
  String? email;
  String? centreCode;
  String? ratings;
  Centres({
    this.name,
    this.uid,
    this.photoUrl,
    this.email,
    this.centreCode,
    this.ratings,
  });
  Centres.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    uid = json["uid"];
    photoUrl = json["photoUrl"];
    email = json["email"];
    centreCode = json["centreCode"];
    ratings = json["ratings"];
  }
}
