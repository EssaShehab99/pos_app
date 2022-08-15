class Customer{
  String id;
  String name;
  String phone;
  double? debit;
  double? credit;
  Customer({required this.id, required this.name, required this.phone,required this.debit, required this.credit});
  factory Customer.fromJson(Map<String, dynamic> json, String id){
    return Customer(
      id: id,
      name: json['name'],
      phone: json['phone'],
      debit: json['debit']??0.0,
      credit: json['credit']??0.0,
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phone': phone,
    'debit': debit,
    'credit': credit,
  };
}