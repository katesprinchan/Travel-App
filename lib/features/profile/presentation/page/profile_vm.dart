import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_application/features/settings/domain/service/settings_service.dart';
import 'package:travel_application/features/settings/presentation/settings_modal_bs.dart';

class ProfileViewModel {
  final SettingsService _settingsService;

  ProfileViewModel({
    required SettingsService settingService,
  }) : _settingsService = settingService;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  void onSettingsTap(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) =>
          SettingsModalBottomSheet(settingsService: _settingsService),
      showDragHandle: true,
    );
  }

  Stream<String?> getFullNameStream() {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final userDocRef =
          FirebaseFirestore.instance.collection('Users').doc(user.uid);

      return userDocRef.snapshots().map((snapshot) {
        return snapshot.data()?['FullName'] as String?;
      });
    } else {
      return Stream.value(null);
    }
  }

  Stream<String?> getURL() {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final userDocRef =
          FirebaseFirestore.instance.collection('Users').doc(user.uid);

      return userDocRef.snapshots().map((snapshot) {
        return snapshot.data()?['ProfileImageURL'] as String?;
      });
    } else {
      return Stream.value(null);
    }
  }

  Future<String> getCurrentUserEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.email ?? '';
    } else {
      return '';
    }
  }

  Future<DateTime?> getUserRegistrationDate() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.metadata.creationTime;
  }

  void onSaveProfile(Uint8List? image) async {
    try {
      String newName = nameController.text;
      String newEmail = emailController.text;
      String newPassword = passwordController.text;

      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        if (newName.isNotEmpty) {
          await user.updateDisplayName(newName);
        }

        if (newEmail.isNotEmpty) {
          await user.verifyBeforeUpdateEmail(newEmail);
        }

        if (newPassword.isNotEmpty) {
          await user.updatePassword(newPassword);
        }

        final userDocRef =
            FirebaseFirestore.instance.collection('Users').doc(user.uid);
        Map<String, dynamic> userData = {};
        if (newName.isNotEmpty) {
          userData['FullName'] = newName;
        }
        if (newEmail.isNotEmpty) {
          userData['Email'] = newEmail;
        }

        if (image != null) {
          try {
            Reference storageRef = FirebaseStorage.instance
                .ref()
                .child('Profile')
                .child('${user.uid}.jpg');
            TaskSnapshot taskSnapshot = await storageRef.putData(image);
            String imageUrl = await taskSnapshot.ref.getDownloadURL();
            userData['ProfileImageURL'] = imageUrl;
            print('Image uploaded successfully');
          } catch (e) {
            print('Error uploading image: $e');
          }
        }

        await userDocRef.update(userData);
        print('Profile updated successfully');
      }

      nameController.clear();
      emailController.clear();
      passwordController.clear();
    } catch (e, stackTrace) {
      print('Error saving profile: $e\n$stackTrace');
    }
  }

  pickImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);
    if (file != null) {
      return await file.readAsBytes();
    }
    print('No Images Selected');
  }
}
