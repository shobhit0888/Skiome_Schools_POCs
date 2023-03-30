// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class Clubs {
  String? clubName;
  String? category;
  String? photoUrl;
  String? centreUID;
  String? schoolUID;
  String? clubUID;
  String? tagline;
  String? clubInfo;
  String? objective;
  Timestamp? publishDate;
  Clubs({
    this.clubName,
    this.category,
    this.photoUrl,
    this.centreUID,
    this.schoolUID,
    this.clubUID,
    this.tagline,
    this.clubInfo,
    this.objective,
    this.publishDate,
  });

  Clubs.fromJson(Map<String, dynamic> json) {
    clubName = json["clubName"];
    category = json["category"];
    photoUrl = json["photoUrl"];
    centreUID = json["centreUID"];
    schoolUID = json["schoolUID"];
    clubUID = json["clubUID"];
    tagline = json["tagline"];
    clubInfo = json["clubInfo"];
    objective = json["objective"];
    publishDate = json["publishDate"];
  }
}
