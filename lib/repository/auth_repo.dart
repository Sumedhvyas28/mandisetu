import 'dart:convert';
import 'dart:io';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mandisetu/constants/api_constants/routes/api_routes.dart';
import 'package:mandisetu/data/network/BaseApiService.dart';
import 'package:mandisetu/data/network/NetworkApiService.dart';
import 'package:http/http.dart' as http;
import 'package:mandisetu/model/user_data.dart';
import 'package:mandisetu/model/user_model.dart';
import 'package:mandisetu/viewmodel/user_session.dart';
import 'package:provider/provider.dart';

class AuthRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> registerRepo({
    required String name,
    required String email,
    required String phone,
    required String aadhar,
    required String pan,
    required String role,
    required String accountNo,
    required String ifscCode,
    required String businessName,
    required String officeAddress,
    required String officePhone,
    required String password,
    required String agreement,
    required String mandiLicenseNo,
    String? mandiLicense,
    String? aadharCard,
    String? panCard,
    String? statement,
    String? image,
  }) async {
    final url = Uri.parse('https://mandisetu.in/api/register');

    var requestMultipart = http.MultipartRequest('POST', url)
      ..fields['name'] = name
      ..fields['email'] = email
      ..fields['phone'] = phone
      ..fields['aadhar'] = aadhar
      ..fields['pan'] = pan
      ..fields['role'] = role
      ..fields['account_no'] = accountNo
      ..fields['ifsc_code'] = ifscCode
      ..fields['business_name'] = businessName
      ..fields['office_address'] = officeAddress
      ..fields['office_phn'] = officePhone
      ..fields['password'] = password
      ..fields['agreement'] = agreement
      ..fields['mandi_license_no'] = mandiLicenseNo;

    if (mandiLicense != null) {
      requestMultipart.files.add(
          await http.MultipartFile.fromPath('mandi_license', mandiLicense));
    }

    if (aadharCard != null) {
      requestMultipart.files
          .add(await http.MultipartFile.fromPath('aadhar_card', aadharCard));
    }

    if (panCard != null) {
      requestMultipart.files
          .add(await http.MultipartFile.fromPath('pan_card', panCard));
    }

    if (statement != null) {
      requestMultipart.files
          .add(await http.MultipartFile.fromPath('statement', statement));
    }

    if (image != null) {
      requestMultipart.files
          .add(await http.MultipartFile.fromPath('image', image));
    }

    final response = await requestMultipart.send();
    final responseString = await response.stream.bytesToString();

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Register successfully");
      return json.decode(responseString);
    } else {
      print('Error Response Status Code: ${response.statusCode}');
      print('Error Response Body: $responseString');
      throw Exception(
          'Failed to send request: ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  Future<UserModel> loginRepo(dynamic data, BuildContext context) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.loginUrl, data);

      if (response != null) {
        dynamic userData = response['user'];
        String token = response['token'];

        // Save the user data and token in UserSession
        await Provider.of<UserSession>(context, listen: false).storeUserData({
          'user': {
            'id': userData['id'],
            'name': userData['name'],
            'email': userData['email'],
            'phone': userData['phone'],
            'role': userData['role'],
          },
          'token': token,
        });

        // You can now return the UserModel or handle the response accordingly
        return UserModel.fromJson(response);
      } else {
        throw Exception("Failed to load login data.");
      }
    } catch (e) {
      print('❌❌ Error in Login: $e');
      throw e;
    }
  }

  Future<UserData> getUserDataRepo(dynamic header) async {
    try {
      dynamic response = await _apiServices.getGetApiWithHeaderResponse(
          AppUrl.userDataUrl, header);
      return response = UserData.fromJson(response);
    } catch (e) {
      print('❌❌ Error in getUserDataRepo Repo ${e}');
      throw e;
    }
  }
}
