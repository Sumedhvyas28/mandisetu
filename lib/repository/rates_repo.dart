import 'package:mandisetu/data/network/BaseApiService.dart';
import 'package:mandisetu/data/network/NetworkApiService.dart';
import 'package:mandisetu/model/filter_rate.dart';
import 'package:mandisetu/model/static_rate_product.dart';

class RatesRepo {
  BaseApiServices _apiServices = NetworkApiService();

  Future<StaticRateProduct> getStaticRateProductRepo() async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          'https://stagging.jookwang.me/api/static-mandi-rate');
      return response = StaticRateProduct.fromJson(response);
    } catch (e) {
      print('❌❌ $e');
      throw e;
    }
  }



  Future<StaticRateProduct> getAllMandiRatesRepo(dynamic header, dynamic queryParams ) async {
    try {
      dynamic response = await _apiServices.getGetApiWithQueryResponse(
          'https://stagging.jookwang.me/api/mandi-rate-by-commodity', header, queryParams);
      return response = StaticRateProduct.fromJson(response);
    } catch (e) {
      print('❌❌ $e');
      throw e;
    }
  }


  Future<FilterRates> getFilteredMandiRatesRepo(dynamic header, commodities, state) async {
    try {
      dynamic response = await _apiServices.getGetApiWithHeaderResponse('https://stagging.jookwang.me/api/filter-rate?commodities=$commodities&state=$state', header);
      return response = FilterRates.fromJson(response);
    } catch (e) {
      print('❌❌ $e');
      throw e;
    }
  }






}
