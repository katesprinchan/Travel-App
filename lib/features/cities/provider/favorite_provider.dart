import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  Future<void> toggleFavorite(String documentId) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userDocRef =
          FirebaseFirestore.instance.collection('Users').doc(user.uid);
      final userData = await userDocRef.get();
      if (userData.exists) {
        final List<dynamic> favorites = userData.data()!['favorites'];
        print(favorites);
        if (favorites.contains(documentId)) {
          favorites.remove(documentId);
          await userDocRef.update({'favorites': favorites});
          print('Removed $documentId from favorites');
        } else {
          await userDocRef.update({
            'favorites': FieldValue.arrayUnion([documentId])
          });
          print('Added $documentId to favorites');
        }
      }
    }
    notifyListeners();
  }

  Future<bool> isFavorite(String documentId) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userDocRef =
          FirebaseFirestore.instance.collection('Users').doc(user.uid);
      final userData = await userDocRef.get();
      if (userData.exists) {
        final List<dynamic> favorites = userData.data()!['favorites'];
        return favorites.contains(documentId);
      }
    }
    return false;
  }

  void clearFavorite() {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('Users').doc(user.uid);
      userDocRef.update({'favorites': []});
    } else {
      print('User not logged in');
    }
    notifyListeners();
  }

  Stream<List<String>> getFavoritesStream() {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final userDocRef =
          FirebaseFirestore.instance.collection('Users').doc(user.uid);

      return userDocRef.snapshots().map((snapshot) {
        final List<dynamic> favoritesDynamic =
            snapshot.data()?['favorites'] ?? [];
        return favoritesDynamic.map((e) => e.toString()).toList();
      });
    } else {
      return Stream.value([]);
    }
  }

  Future<bool> isFavoritesEmpty() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final userDocRef =
          FirebaseFirestore.instance.collection('Users').doc(user.uid);
      final userData = await userDocRef.get();
      if (userData.exists) {
        final List<dynamic> favorites = userData.data()?['favorites'] ?? [];
        return favorites.isEmpty;
      }
    }

    return true;
  }
}
