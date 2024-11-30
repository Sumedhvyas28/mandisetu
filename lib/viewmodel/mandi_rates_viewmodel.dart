import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mandisetu/data/response/api_response.dart';
import 'package:mandisetu/model/filter_rate.dart';
import 'package:mandisetu/model/static_rate_product.dart';
import 'package:mandisetu/repository/rates_repo.dart';

class MandiRatesViewModel with ChangeNotifier {
  final _myRepo = RatesRepo();

  dynamic _isLoading = false;

  get isLoading => _isLoading;

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }


  dynamic header = {
    HttpHeaders.authorizationHeader: 'Bearer 15|Tg7Mxgp3p0Q248yeDdiegCV2mHpJFnJcdFBcsbAle06f98ba'
  };



  // ===========================================================================

  ApiResponse<StaticRateProduct> allStaticProducts = ApiResponse.Loading();

  setStaticRateProduct(ApiResponse<StaticRateProduct> response) {
    allStaticProducts = response;
    notifyListeners();
  }

  Future<void> getStaticRateProduct() async {
    setStaticRateProduct(ApiResponse.Loading());
    _myRepo.getStaticRateProductRepo().then((value) {
      setStaticRateProduct(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setStaticRateProduct(ApiResponse.error(error.toString()));
    });
    notifyListeners();
  }


  // ===========================================================================

  ApiResponse<StaticRateProduct> allMandiRates = ApiResponse.Loading();

  setAllMandiRatesList(ApiResponse<StaticRateProduct> response) {
    allMandiRates = response;
    notifyListeners();
  }

  Future<void> getAllMandiRates(query) async {
    setAllMandiRatesList(ApiResponse.Loading());
    _myRepo.getAllMandiRatesRepo({}, query).then((value) {
      setAllMandiRatesList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setAllMandiRatesList(ApiResponse.error(error.toString()));
    });
    notifyListeners();
  }


  // ===========================================================================

  ApiResponse<FilterRates> allFilteredMandiRates = ApiResponse.Loading();

  setFilteredMandiRatesList(ApiResponse<FilterRates> response) {
    allFilteredMandiRates = response;
    notifyListeners();
  }

  Future<void> getFilteredMandiRates(commodities, state) async {
    setFilteredMandiRatesList(ApiResponse.Loading());
    _myRepo.getFilteredMandiRatesRepo(header, commodities, state).then((value) {
      setFilteredMandiRatesList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setFilteredMandiRatesList(ApiResponse.error(error.toString()));
    });
    notifyListeners();
  }




}

