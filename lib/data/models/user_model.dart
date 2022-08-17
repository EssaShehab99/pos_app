class UserModel{
  String? id;
  String email;
  String? phone;
  String? companyName;
  String? password;
  String? uuid;
  String? type;
  UserModel({this.id,required  this.email,  this.companyName,  this.password,  this.phone, this.uuid,  this.type});

  factory UserModel.fromJson(Map<String, dynamic> json,String id) => UserModel(
    id: id,
    email: json["email"],
    companyName: json["companyName"],
    password: json["password"],
    phone: json["phone"],
    uuid: json["uuid"],
    type: json["type"],
  );
  Map<String, dynamic> toJson() => {
    "companyName": companyName,
    "password": password,
    "phone": phone,
    "email": email,
    "uuid": uuid,
    "type": type??"admin",
  };
}