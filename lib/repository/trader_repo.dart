import 'package:mandisetu/data/network/BaseApiService.dart';
import 'package:mandisetu/data/network/NetworkApiService.dart';
import 'package:mandisetu/model/dukandar.dart';
import 'package:mandisetu/model/product.dart';

class TraderRepo {
  BaseApiServices _apiServices = NetworkApiService();

  Future<Product> getAllProductRepo(dynamic header) async {
    try {
      dynamic response = await _apiServices.getGetApiWithHeaderResponse(
          'https://mandisetu.in/api/get-products', header);
      return response = Product.fromJson(response);
    } catch (e) {
      print('❌❌ $e');
      throw e;
    }
  }

  Future<Dukandar> getDukandarRepo(dynamic header) async {
    try {
      dynamic response = await _apiServices.getGetApiWithHeaderResponse(
          'https://mandisetu.in/api/get-dukandars-by-mandivyapari', header);
      return response = Dukandar.fromJson(response);
    } catch (e) {
      print('❌❌ $e');
      throw e;
    }
  }

  Future<dynamic> addDukandarRepo(dynamic data, dynamic header) async {
    try {
      dynamic response = await _apiServices.getPostApiWithHeaderResponse(
          "https://mandisetu.in/api/add-dukandar", data, header);
      return response = response;
    } catch (e) {
      print('❌❌ Error in Add Dukandar ${e}');
      throw e;
    }
  }

  Future<dynamic> interestedFormRepo(dynamic data, dynamic header) async {
    try {
      dynamic response = await _apiServices.getPostApiWithHeaderResponse(
          "https://mandisetu.in/api/send-purchase-request", data, header);
      return response = response;
    } catch (e) {
      print('❌❌ Error in  Interested Form ${e}');
      throw e;
    }
  }

  Future<dynamic> addSalesRepo(dynamic data, dynamic header) async {
    try {
      dynamic response = await _apiServices.getPostApiWithHeaderResponse(
          "https://mandisetu.in/api/add-sales", data, header);
      return response = response;
    } catch (e) {
      print('❌❌ Error in  Interested Form ${e}');
      throw e;
    }
  }

  Future<dynamic> deleteWholesalerProductRepo(
      dynamic data, dynamic header, id) async {
    try {
      dynamic response = await _apiServices.getPostApiWithHeaderResponse(
          "https://mandisetu.in/api/delete-product/$id", data, header);
      return response = response;
    } catch (e) {
      print('❌❌ Error in  deleteWholesalerProductRepo ${e}');
      throw e;
    }
  }
}
