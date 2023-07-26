import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter/foundation.dart';

class User {
  String email;

  String firstName;

  String lastName;

  String userID;

  String phoneNumber;

  String profilePictureURL;

  String appIdentifier;

  bool isAdmin;

  User(
      {this.email = '',
      this.firstName = '',
      this.lastName = '',
      this.userID = '',
      this.phoneNumber = '',
      this.profilePictureURL = '',
      this.isAdmin = false})
      : appIdentifier =
            'Flutter Login Screen ${kIsWeb ? 'Web' : Platform.operatingSystem}';

  String fullName() => '$firstName $lastName';

  bool setAdmin(bool val) => isAdmin = val;

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
        email: parsedJson['email'] ?? '',
        firstName: parsedJson['firstName'] ?? '',
        lastName: parsedJson['lastName'] ?? '',
        userID: parsedJson['id'] ?? parsedJson['userID'] ?? '',
        profilePictureURL: parsedJson['profilePictureURL'] ?? '',
        isAdmin: parsedJson['isAdmin'] ?? '');
  }
  factory User.fromUserCredential(firebase.User? obj) {
    return User(
        email: obj?.email ?? '',
        firstName: obj?.displayName ?? '',
        // lastName: parsedJson['lastName'] ?? '',
        userID: obj?.uid ?? '',
        phoneNumber: obj?.phoneNumber ?? '',
        profilePictureURL: obj?.photoURL ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'id': userID,
      'profilePictureURL': profilePictureURL,
      'appIdentifier': appIdentifier,
      'isAdmin': isAdmin
    };
  }
}
