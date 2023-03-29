class Teachers {
  String? teacherUID;
  String? teacherName;
  String? teacherEmail;
  String? phoneNumber;
  String? classes;
  String? subject;
  String? password;
  String? schoolUID;
  Teachers({
    this.teacherUID,
    this.teacherName,
    this.teacherEmail,
    this.phoneNumber,
    this.classes,
    this.subject,
    this.password,
    this.schoolUID,
  });

  Teachers.fromJson(Map<String, dynamic> json) {
    teacherUID = json["teacherUID"];
    teacherName = json["teacherName"];
    teacherEmail = json["teacherEmail"];
    phoneNumber = json["phoneNumber"];
    classes = json["classes"];
    subject = json["subject"];
    password = json["password"];
    schoolUID = json["schoolUID"];
  }
}
