import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSession with ChangeNotifier {
  // Save user data and token to SharedPreferences
  Future<void> storeUserData(dynamic responseData) async {
    final prefs = await SharedPreferences.getInstance();

    // Extract user data and token from the response
    final userData = responseData['user'];
    final token = responseData['token'];
    print('ffjfjfjfa');

    // Store the data locally
    await prefs.setString(
        'userData',
        jsonEncode({
          'id': userData['id'],
          'name': userData['name'],
          'email': userData['email'],
          'phone': userData['phone'],
          'mandi_license': userData['mandi_license'],
          'gumasta': userData['gumasta'],
          'gst_registration': userData['gst_registration'],
          'mandi_license_no': userData['mandi_license_no'],
          'gumasta_no': userData['gumasta_no'],
          'gst_no': userData['gst_no'],
          'aadhar': userData['aadhar'],
          'pan': userData['pan'],
          'aadhar_card': userData['aadhar_card'],
          'pan_card': userData['pan_card'],
          'account_no': userData['account_no'],
          'ifsc_code': userData['ifsc_code'],
          'statement': userData['statement'],
          'business_name': userData['business_name'],
          'office_address': userData['office_address'],
          'office_phn': userData['office_phn'],
          'image': userData['image'],
          'role': userData['role'],
          'agreement': userData['agreement'],
          'token': token,
        }));

    // Update GlobalData with user info
    GlobalData().updateUserData(
      newId: userData['id'].toString(),
      newName: userData['name'] ?? '',
      newEmail: userData['email'] ?? '',
      newPhnNo: userData['phone'] ?? '',
      newCountry: userData['office_address'] ?? '',
      newRole: userData['role'] ?? '',
      newApiToken: token,
    );
  }

  // Get stored user data from SharedPreferences
  Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('userData');
    if (userData != null) {
      print('lololllffffffffffff//');

      return jsonDecode(userData);
    }
    return null;
  }

  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userData');
    GlobalData().clearUserData();
  }

  // Check if the user is logged in
  Future<bool> isLoggedIn() async {
    final userData = await getUserData();
    return userData != null;
  }

  // Load user data into global data
  Future<void> loadUserDataIntoGlobal() async {
    final userData = await getUserData();
    if (userData != null) {
      GlobalData().updateUserData(
        newId: userData['id'] ?? '',
        newName: userData['name'] ?? '',
        newEmail: userData['email'] ?? '',
        newPhnNo: userData['phone'] ?? '',
        newCountry: userData['office_address'] ?? '',
        newRole: userData['role'] ?? '',
        newApiToken: userData['token'] ?? '',
      );
    }
  }
}

class GlobalData {
  static final GlobalData _instance = GlobalData._internal();
  factory GlobalData() => _instance;
  GlobalData._internal();

  static final UserSession userSession = UserSession();

  String id = '';
  String name = '';
  String email = '';
  String phnNo = '';
  String country = '';
  String role = '';
  String token = '';

  // Update global user data
  void updateUserData({
    required String newId,
    required String newName,
    required String newEmail,
    required String newPhnNo,
    required String newCountry,
    required String newRole,
    required String newApiToken,
  }) {
    id = newId;
    name = newName;
    email = newEmail;
    phnNo = newPhnNo;
    country = newCountry;
    role = newRole;
    token = newApiToken;
  }

  // Clear global user data
  void clearUserData() {
    id = '';
    name = '';
    email = '';
    phnNo = '';
    country = '';
    role = '';
    token = '';
  }
}
