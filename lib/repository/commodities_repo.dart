import 'dart:convert';

import 'package:mandisetu/data/network/BaseApiService.dart';
import 'package:mandisetu/data/network/NetworkApiService.dart';
import 'package:mandisetu/model/commodities.dart';
import 'package:mandisetu/model/commodity_variety.dart';
import 'package:mandisetu/model/stats.dart';
import 'package:mandisetu/model/varieties.dart';
import 'package:http/http.dart' as http;

class CommodityRepo {
  BaseApiServices _apiServices = NetworkApiService();

  Future<Commodities> getCommodityRepo(dynamic header) async {
    try {
      dynamic response = await _apiServices.getGetApiWithHeaderResponse(
          'https://stagging.jookwang.me/api/get-commodities', header);
      return response = Commodities.fromJson(response);
    } catch (e) {
      print('❌❌ $e');
      throw e;
    }
  }

  Future<Varieties> getVarietyRepo(dynamic id, dynamic header) async {
    try {
      dynamic response = await _apiServices.getGetApiWithHeaderResponse(
          'https://stagging.jookwang.me/api/get-variety/$id', header);
      return response = Varieties.fromJson(response);
    } catch (e) {
      print('❌❌ $e');
      throw e;
    }
  }


  Future<CommodityVariety> getVarietyByCommodityRepo(dynamic id, dynamic header) async {
    try {
      dynamic response = await _apiServices.getGetApiWithHeaderResponse(
        'https://stagging.jookwang.me/api/get-varieties-by-commodity/$id',
        header,
      );
      return response = CommodityVariety.fromJson(response);
    } catch (e) {
      print('❌❌ Error in Variety $e');
      throw e;
    }
  }


  Future<dynamic> addProductRepo({
    required String commodityId,
    required String varietyId,
    required String quality,
    required String rate,
    required String quantity,
    required String description,
    required String unit,
    required String state,
    required String district,
    required List<String> images,
    required Map<String, String> headers,
  }) async {
    final url = Uri.parse('https://stagging.jookwang.me/api/add-product');

    var requestMultipart = http.MultipartRequest('POST', url)
      ..fields['commodity_id'] = commodityId
      ..fields['variety_id'] = varietyId
      ..fields['quantity'] = quantity
      ..fields['quality'] = quality
      ..fields['rate'] = rate
      ..fields['description'] = description
      ..fields['unit'] = unit
      ..fields['state'] = state
      ..fields['district'] = district
    ;

    requestMultipart.headers.addAll(headers);

    for (String image in images) {
      print('Adding image: $image');
      requestMultipart.files.add(await http.MultipartFile.fromPath('image[]', image));
    }

    final response = await requestMultipart.send();
    final responseString = await response.stream.bytesToString();

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Product Added successfully");
      return json.decode(responseString);
    } else {
      print('Error Response Status Code: ${response.statusCode}');
      print('Error Response Body: $responseString');
      throw Exception(
          'Failed to send request: ${response.statusCode} ${response.reasonPhrase}');
    }
  }


  Future<void> addNewCommodityRepo(dynamic data, dynamic header) async {
    try {
      dynamic response = await _apiServices.getPostApiWithHeaderResponse(
          'https://stagging.jookwang.me/api/add-commodity', data, header);
      return response ;
    } catch (e) {
      print('❌❌ $e');
      throw e;
    }
  }

  Future<void> addNewVarietyRepo(dynamic data, dynamic header) async {
    try {
      dynamic response = await _apiServices.getPostApiWithHeaderResponse(
          'https://stagging.jookwang.me/api/add-variety', data, header);
      return response ;
    } catch (e) {
      print('❌❌ $e');
      throw e;
    }
  }


  Future<void> deleteCommodityRepo(dynamic data, dynamic header, dynamic id) async {
    try {
      dynamic response = await _apiServices.getPostApiWithHeaderResponse(
          'https://stagging.jookwang.me/api/delete-commodity/$id', data, header);
      return response ;
    } catch (e) {
      print('❌❌ $e');
      throw e;
    }
  }

  Future<void> deleteVarietyRepo(dynamic data, dynamic header, dynamic id) async {
    try {
      dynamic response = await _apiServices.getPostApiWithHeaderResponse(
          'https://stagging.jookwang.me/api/delete-variety/$id', data, header);
      return response ;
    } catch (e) {
      print('❌❌ $e');
      throw e;
    }
  }


  Future<void> editCommodityRepo(dynamic data, dynamic header, dynamic id) async {
    try {
      dynamic response = await _apiServices.getPostApiWithHeaderResponse(
          'https://stagging.jookwang.me/api/edit-commodity/$id', data, header);
      return response ;
    } catch (e) {
      print('❌❌ $e');
      throw e;
    }
  }


  Future<Stats> getStatsRepo(dynamic header, dynamic queryParams ) async {
    try {
      dynamic response = await _apiServices.getGetApiWithQueryResponse(
          'https://stagging.jookwang.me/api/get-stats', header, queryParams);
      return response = Stats.fromJson(response);
    } catch (e) {
      print('❌❌ $e');
      throw e;
    }
  }


}
