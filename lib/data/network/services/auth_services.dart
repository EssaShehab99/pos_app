import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../../shared/component.dart';
import '../../models/user.dart';

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
      this.user = UserModel(email: email);
      bool isExist = await checkIfExistEmail(email);
      if (isExist) {
        final status = await sendVerificationEmail(email);
        if (status) {
          return Status.SUCCESS;
        } else {
          return Status.FAILED;
        }
      }
      else{
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

  bool verifyCode(String code) {
    try {
      return emailAuth.validateOtp(recipientMail: user.email, userOtp: code);
    } catch (_) {
      return false;
    }
  }

  Future<bool> checkIfExistEmail(String email) async {
    try {
      return collection.doc(email).get().then((value) {
        if (value.exists) {
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
      if (verifyCode(code)) {
        await collection.doc(user.email).set(user.toJson()).then((value) {
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
      await collection.doc(user.email).update({'password': password}).then((value) {
        status = Status.SUCCESS;
      });
    } catch (error) {
      status = Status.FAILED;
    }
    return status;
  }
  Future<UserModel?> signIn(String email, String password) async {
    try {
      final user = await collection.doc(email).get();
      if (user.exists) {
        if ((user.data()as Map<String, dynamic>)['password'] == password) {
          return UserModel.fromJson(user.data()as Map<String, dynamic>,email);
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }
}