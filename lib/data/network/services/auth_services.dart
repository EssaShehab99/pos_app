import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../../shared/component.dart';
import '../../models/user_model.dart';

class AuthServices extends ChangeNotifier {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('users');
  String? verificationId;
  late UserModel user;
  late OTPType otpType;
  EmailAuth emailAuth = EmailAuth(
    sessionName: "sessionName",
  );

  Future<bool> sendVerificationEmail(String email) async {
    final status = await emailAuth.sendOtp(recipientMail: email);
    return status;
  }

  Future<Status> sendVerificationToResetPassword(String email) async {
    try {
      user = UserModel(email: email,uuid: "");
      bool isExist = await checkIfExistEmail(email);
      if (isExist) {
        final status = await sendVerificationEmail(email);
        if (status) {
          return Status.SUCCESS;
        } else {
          return Status.FAILED;
        }
      } else {
        return Status.EXIST;
      }
    } catch (e) {
      return Status.FAILED;
    }
  }

  Future<Status> sendVerificationToCreateUser(String email) async {
    try {
      bool isExist = await checkIfExistEmail(email);
      if (!isExist) {
        bool status = await sendVerificationEmail(email);
        if (status) {
          return Status.SUCCESS;
        } else {
          return Status.FAILED;
        }
      } else {
        return Status.EXIST;
      }
    } catch (_) {
      return Status.FAILED;
    }
  }

  Future<bool> verifyCode(String code) async {
    try {
      bool status =
          emailAuth.validateOtp(recipientMail: user.email, userOtp: code);
      if (otpType == OTPType.SIGN_UP) {
        return status;
      }
      if (status) {
        user = await collection
            .where("email", isEqualTo: user.email)
            .get()
            .then((value) => value.docs
                .map((e) => e.reference)
                .toList()
                .first
                .get()
                .then((value) => UserModel.fromJson(
                    value.data() as Map<String, dynamic>, value.id)));
        return true;
      } else {
        return false;
      }
    } catch (_) {
      return false;
    }
  }

  Future<bool> checkIfExistEmail(String email) async {
    try {
      return collection.where("email", isEqualTo: email).get().then((value) {
        if (value.docs.isNotEmpty) {
          return true;
        } else {
          return false;
        }
      });
    } catch (error) {
      return true;
    }
  }

  Future<Status> signUp(String code) async {
    Status status = Status.LOADING;
    try {
      if (await verifyCode(code)) {
        await collection.add(user.toJson()).then((value) {
          status = Status.SUCCESS;
        });
      } else {
        status = Status.FAILED;
      }
    } catch (error) {
      status = Status.FAILED;
    }
    return status;
  }

  Future<Status> changePassword(String password) async {
    Status status = Status.LOADING;
    try {
     QuerySnapshot<Object?> u= await collection
          .where("email", isEqualTo: user.email).get();
     await collection.doc(u.docs.first.id).update({'password': password}).then((value) {
        status = Status.SUCCESS;
      });
    } catch (error) {
      status = Status.FAILED;
    }
    return status;
  }

  Future<UserModel?> signIn(String email, String password) async {
    try {
      return await collection
          .where("email", isEqualTo: email)
          .where("password", isEqualTo: password)
          .get()
          .then((value) => value.docs
              .map((e) => e.reference)
              .toList()
              .first
              .get()
              .then((value) => UserModel.fromJson(
                  value.data() as Map<String, dynamic>, value.id)));
    } catch (error) {
      return null;
    }
  }
}
