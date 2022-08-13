class UserModel{
  String email;
  String? phone;
  String? companyName;
  String? password;
  String? uuid;
  UserModel({required  this.email,  this.companyName,  this.password,  this.phone,  this.uuid});

  factory UserModel.fromJson(Map<String, dynamic> json,String id) => UserModel(
    email: id,
    companyName: json["companyName"],
    password: json["password"],
    phone: json["phone"],
    uuid: json["uuid"],
  );
  Map<String, dynamic> toJson() => {
    "companyName": companyName,
    "password": password,
    "phone": phone,
    "uuid": uuid,
  };
}