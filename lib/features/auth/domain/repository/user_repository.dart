import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_application/core/domain/intl/generated/l10n.dart';
import 'package:travel_application/features/auth/data/source/user_model.dart';
import 'package:travel_application/features/auth/presentation/snack_bar.dart';

class UserRepository {
  final _db = FirebaseFirestore.instance;
  final BuildContext context;

  UserRepository(this.context);

  Future<void> createUser(String uid, UserModel user) async {
    await _db.collection("Users").doc(uid).set(user.toJson()).then((_) {
      SnackBarService.showSnackBar(
        context,
        S.of(context).emailAlreadyInUse,
        true,
      );
    }).catchError((error) {
      print("Error adding user: $error");
    });
  }
}
