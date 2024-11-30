import 'dart:convert';

import 'package:mandisetu/data/network/BaseApiService.dart';
import 'package:mandisetu/data/network/NetworkApiService.dart';
import 'package:mandisetu/model/banner.dart';
import 'package:mandisetu/model/news.dart';
import 'package:mandisetu/model/purchase_request.dart';
import 'package:http/http.dart' as http;

class AdminRequestRepo {
  BaseApiServices _apiServices = NetworkApiService();

  Future<PurchaseRequest> getPurchaseRequestRepo(dynamic header) async {
    try {
      dynamic response = await _apiServices.getGetApiWithHeaderResponse(
          'https://stagging.jookwang.me/api/get-purchase-request', header);
      return response = PurchaseRequest.fromJson(response);
    } catch (e) {
      print('❌❌ Error in Purchase request $e');
      throw e;
    }
  }

  final String baseUrl = "https://stagging.jookwang.me/api";

  Future<Map<String, dynamic>> uploadBanner({
    required List<String> images,
    required Map<String, String> headers,
  }) async {
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse('$baseUrl/upload-banner'));

      request.headers.addAll(headers);

      for (String image in images) {
        print('Adding image: $image');
        request.files.add(await http.MultipartFile.fromPath('image[]', image));
      }

      final response = await request.send();
      final responseString = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        print("Saved successfully");
        return json.decode(responseString);
      } else {
        print('Error Response Status Code: ${response.statusCode}');
        print('Error Response Body: $responseString');
        throw Exception(
            'Failed to save promotion: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error in savePromotion: $e');
      throw Exception('Failed to save promotion: $e');
    }
  }

  Future<dynamic> uploadNewsRepo({
    required String title,
    required String desc,
    required String image,
  }) async {
    final url = Uri.parse('https://stagging.jookwang.me/api/upload-news');

    var requestMultipart = http.MultipartRequest('POST', url)
      ..fields['title'] = title
      ..fields['description'] = desc;

    requestMultipart.files
        .add(await http.MultipartFile.fromPath('image', image));

    final response = await requestMultipart.send();
    final responseString = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      print("Uploaded successfully");
      return json.decode(responseString);
    } else {
      print('Error Response Status Code: ${response.statusCode}');
      print('Error Response Body: $responseString');
      throw Exception(
          'Failed to send request: ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  Future<Banner> getBannerRepo(dynamic header) async {
    try {
      dynamic response = await _apiServices.getGetApiWithHeaderResponse(
          'https://stagging.jookwang.me/api/banner', header);
      return response = Banner.fromJson(response);
    } catch (e) {
      print('❌❌ Error in Purchase request $e');
      throw e;
    }
  }

  Future<void> deleteBannerRepo(
      dynamic data, dynamic header, dynamic id) async {
    try {
      dynamic response = await _apiServices.getPostApiWithHeaderResponse(
          'https://stagging.jookwang.me/api/delete-banner/$id', data, header);
      return response;
    } catch (e) {
      print('❌❌ $e');
      throw e;
    }
  }

  Future<void> deleteNewsRepo(
      dynamic data, dynamic header, dynamic id) async {
    try {
      dynamic response = await _apiServices.getPostApiWithHeaderResponse(
          'https://stagging.jookwang.me/api/delete-news/$id', data, header);
      return response;
    } catch (e) {
      print('❌❌ $e');
      throw e;
    }
  }

  Future<NewsList> getNewsRepo(dynamic header) async {
    try {
      dynamic response = await _apiServices.getGetApiWithHeaderResponse(
          'https://stagging.jookwang.me/api/news', header);
      return response = NewsList.fromJson(response);
    } catch (e) {
      print('❌❌ Error in Purchase request $e');
      throw e;
    }
  }


  Future<void> requestApprovedRepo(dynamic data, dynamic header, dynamic id) async {
    try {
      dynamic response = await _apiServices.getPostApiWithHeaderResponse(
          'https://stagging.jookwang.me/api/approve-purchase-request/$id', data, header);
      return response;
    } catch (e) {
      print('❌❌ $e');
      throw e;
    }
  }


  Future<void> requestCancelRepo(dynamic data, dynamic header, dynamic id) async {
    try {
      dynamic response = await _apiServices.getPostApiWithHeaderResponse(
          'https://stagging.jookwang.me/api/reject-purchase-request/$id', data, header);
      return response;
    } catch (e) {
      print('❌❌ $e');
      throw e;
    }
  }


  Future<void> deliveredApprovedRepo(dynamic data, dynamic header, dynamic id) async {
    try {
      dynamic response = await _apiServices.getPostApiWithHeaderResponse(
          'https://stagging.jookwang.me/api/approve-purchase-request/$id', data, header);
      return response;
    } catch (e) {
      print('❌❌ $e');
      throw e;
    }
  }




}
