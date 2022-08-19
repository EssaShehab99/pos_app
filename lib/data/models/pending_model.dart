import 'package:flutter/foundation.dart';

import 'user_model.dart';

class PendingModel {
  String id;
  String accountSender;
  String accountReceiver;
  String companyUUid;
  String companyName;
  String status;
  PendingModel({
    required this.id,
    required this.accountSender,
    required this.accountReceiver,
    required this.companyUUid,
    required this.companyName,
    required this.status,
  });
  factory PendingModel.fromJson(Map<String, dynamic> json,String id) => PendingModel(
        id: id,
        accountSender: json['accountSender'] as String,
        accountReceiver: json['accountReceiver'] as String,
        companyUUid: json['companyUUid'] as String,
        companyName: json['companyName']??"",
        status: json['status']??"",
      );
  Map<String, dynamic> toJson() => {
        'accountSender': accountSender,
        'accountReceiver': accountReceiver,
        'companyUUid': companyUUid,
        'companyName': companyName,
        'status': status,
      };
}