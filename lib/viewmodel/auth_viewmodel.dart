import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mandisetu/data/response/api_response.dart';
import 'package:mandisetu/model/user_data.dart';
import 'package:mandisetu/repository/auth_repo.dart';
import 'package:mandisetu/routes/route_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mandisetu/viewmodel/user_session.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

  dynamic _isLoading = false;

  get isLoading => _isLoading;

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  dynamic header = {
    HttpHeaders.authorizationHeader: 'token ${GlobalData().token}'
  };

  dynamic header1 = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'token ${GlobalData().token}'
  };

  // ====================================================================================

  String verificationDocumentImage = "";

  String aadhaarCardImage = "";
  String panCardImage = "";
  String shopImageImage = "";
  String statementFile = "";

  String _registerAs = "Wholesaler";

  String get registerAs => _registerAs;

  setRegisterAs(String value) {
    _registerAs = value;
    print(_registerAs);
    notifyListeners();
  }

  final TextEditingController nameController = TextEditingController(text: "");
  final TextEditingController phoneController = TextEditingController(text: "");
  final TextEditingController emailController = TextEditingController(text: "");
  final TextEditingController mandiLicenseNoController =
      TextEditingController(text: "");
  final TextEditingController businessNameController =
      TextEditingController(text: "");
  final TextEditingController officeAddressController =
      TextEditingController(text: "");
  final TextEditingController officePhoneController =
      TextEditingController(text: "");
  final TextEditingController aadharController =
      TextEditingController(text: "");
  final TextEditingController panController = TextEditingController(text: "");
  final TextEditingController accountNoController =
      TextEditingController(text: "");
  final TextEditingController ifscCodeController =
      TextEditingController(text: "");
  final TextEditingController agreementController =
      TextEditingController(text: "");

  Future<void> registerUser(context) async {
    setLoading(true);
    try {
      await _myRepo
          .registerRepo(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        role: _registerAs,
        aadhar: aadharController.text,
        pan: panController.text,
        accountNo: accountNoController.text,
        ifscCode: ifscCodeController.text,
        businessName: businessNameController.text,
        officeAddress: officeAddressController.text,
        officePhone: officePhoneController.text,
        password: "1234567890",
        agreement: "1",
        mandiLicenseNo: mandiLicenseNoController.text,
        mandiLicense: verificationDocumentImage,
        aadharCard: aadhaarCardImage,
        panCard: panCardImage,
        statement: statementFile,
        image: shopImageImage,
      )
          .then((value) {
        if (kDebugMode) {
          print(value.toString());
        }
        setLoading(false);
        Navigator.pushReplacementNamed(context, NamedRoutes.bottomTab);
      }).onError((error, stackTrace) {
        if (kDebugMode) {
          print(error.toString());
        }
        setLoading(false);
      });
    } catch (e) {
      // Handle exceptions
      if (kDebugMode) {
        print('Error: $e');
      }
      setLoading(false);
    }
  }

  // ==============================================================================

  Future<void> login(context, dynamic data) async {
    setLoading(true);
    await _myRepo.loginRepo(data, context).then((value) {
      if (kDebugMode) {
        print(value.toString());
        print(data);
      }
      setLoading(false);
      Navigator.pushReplacementNamed(context, NamedRoutes.bottomTab);
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
      setLoading(false);
    });
  }

  ApiResponse<UserData> userData = ApiResponse.Loading();

  setUserData(ApiResponse<UserData> response) {
    userData = response;
    notifyListeners();
  }

  Future<void> getUserData() async {
    setUserData(ApiResponse.Loading());
    _myRepo.getUserDataRepo(header).then((value) {
      setUserData(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setUserData(ApiResponse.error(error.toString()));
    });
    notifyListeners();
  }
}
