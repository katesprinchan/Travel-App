import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:travel_application/features/settings/domain/service/settings_service.dart';
import 'package:travel_application/features/settings/presentation/settings_modal_bs.dart';

class AddCommentViewModel {
  final SettingsService _settingsService;

  AddCommentViewModel({
    required SettingsService settingService,
  }) : _settingsService = settingService;
  final TextEditingController commentController = TextEditingController();
  void onSettingsTap(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) =>
          SettingsModalBottomSheet(settingsService: _settingsService),
      showDragHandle: true,
    );
  }

  pickImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);
    if (file != null) {
      return await file.readAsBytes();
    }
    print('No Images Selected');
  }

  Future<void> addCommentToDocument(
      String collectionName, String documentId, Uint8List? image) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('Пользователь не аутентифицирован');
        return;
      }

      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .get();
      if (!userSnapshot.exists) {
        print('Данные пользователя не найдены');
        return;
      }

      String? imageUrl;

      if (image != null) {
        try {
          Reference storageRef = FirebaseStorage.instance
              .ref()
              .child('Profile')
              .child('${user.uid}.jpg');
          TaskSnapshot taskSnapshot = await storageRef.putData(image);
          imageUrl = await taskSnapshot.ref.getDownloadURL();
          print('Image uploaded successfully');
        } catch (e) {
          print('Error uploading image: $e');
        }
      }
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('dd/MM/yyyy').format(now);

      Map<String, dynamic> newComment = {
        'FullName': userSnapshot['FullName'],
        'ProfileImageURL': userSnapshot['ProfileImageURL'],
        'comment': commentController.text,
        'image': imageUrl,
        'date': formattedDate,
      };

      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(documentId)
          .update({
        'Comments': FieldValue.arrayUnion([newComment]),
      });

      print('Комментарий успешно добавлен');
    } catch (e) {
      print('Ошибка при добавлении комментария: $e');
    }
  }
}
