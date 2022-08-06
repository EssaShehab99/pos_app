class UserModel{
  String email;
  String? phone;
  String? companyName;
  String? password;

  UserModel({required  this.email,  this.companyName,  this.password,  this.phone});

  factory UserModel.fromJson(Map<String, dynamic> json,String id) => UserModel(
    email: id,
    companyName: json["companyName"],
    password: json["password"],
    phone: json["phone"],
  );
  Map<String, dynamic> toJson() => {
    "companyName": companyName,
    "password": password,
    "phone": phone,
  };
}