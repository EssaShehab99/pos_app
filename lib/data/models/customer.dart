class Customer{
  String id;
  String name;
  String phone;
  Customer({required this.id, required this.name, required this.phone});
  factory Customer.fromJson(Map<String, dynamic> json, String id){
    return Customer(
      id: id,
      name: json['name'],
      phone: json['phone']
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phone': phone,
  };
}