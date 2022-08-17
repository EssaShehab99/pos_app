import 'package:flutter/foundation.dart';

import 'user_model.dart';

class PendingModel {
  String id;
  String accountSender;
  String accountReceiver;
  PendingModel({
    required this.id,
    required this.accountSender,
    required this.accountReceiver,
  });
  factory PendingModel.fromJson(Map<String, dynamic> json,String id) => PendingModel(
        id: id,
        accountSender: json['accountSender'] as String,
        accountReceiver: json['accountReceiver'] as String,
      );
  Map<String, dynamic> toJson() => {
        'accountSender': accountSender,
        'accountReceiver': accountReceiver,
      };
}