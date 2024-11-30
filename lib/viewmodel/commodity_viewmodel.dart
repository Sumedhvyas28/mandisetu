import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mandisetu/data/response/api_response.dart';
import 'package:mandisetu/model/commodities.dart';
import 'package:mandisetu/model/commodity_variety.dart';
import 'package:mandisetu/model/stats.dart';
import 'package:mandisetu/model/varieties.dart';
import 'package:mandisetu/repository/commodities_repo.dart';
import 'package:mandisetu/utils/Utils.dart';

class CommodityViewModel with ChangeNotifier {
  final _myRepo = CommodityRepo();

  dynamic _isLoading = false;
  get isLoading => _isLoading;

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }


  String _selectedCommodity = "";
  String get selectedCommodity => _selectedCommodity;

  setSelectedCommodity(String value) {
    _selectedCommodity = value;
    print(_selectedCommodity);
    notifyListeners();
  }

  dynamic header = {
    HttpHeaders
        .authorizationHeader: 'Bearer 15|Tg7Mxgp3p0Q248yeDdiegCV2mHpJFnJcdFBcsbAle06f98ba'
  };

  dynamic header1 = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer 15|Tg7Mxgp3p0Q248yeDdiegCV2mHpJFnJcdFBcsbAle06f98ba'
  };


  ApiResponse<Commodities> allCommoditiesList = ApiResponse.Loading();

  setCommodityList(ApiResponse<Commodities> response) {
    allCommoditiesList = response;
    notifyListeners();
  }

  Future<void> getCommodities() async {
    setCommodityList(ApiResponse.Loading());
    _myRepo.getCommodityRepo(header).then((value) {
      setCommodityList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setCommodityList(ApiResponse.error(error.toString()));
    });
    notifyListeners();
  }

//   ======================================================================

  ApiResponse<Varieties> allVarietyList = ApiResponse.Loading();

  setVarietyList(ApiResponse<Varieties> response) {
    allVarietyList = response;
    notifyListeners();
  }

  Future<void> getVariety() async {
    setVarietyList(ApiResponse.Loading());
    _myRepo.getVarietyRepo(1, header).then((value) {
      setVarietyList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setVarietyList(ApiResponse.error(error.toString()));
    });
    notifyListeners();
  }

  // ======================================================================

  String? _selectedUnit;
  String get selectedUnit => _selectedCommodity;
  setSelectedUnit(String value){
    _selectedUnit = value;
    print(_selectedUnit);
    notifyListeners();
  }

  final TextEditingController commodityIdController = TextEditingController(
      text: '3');
  final TextEditingController varietyIdController = TextEditingController(
      text: '2');
  final TextEditingController qualityController = TextEditingController(
      text: 'Best');
  final TextEditingController rateController = TextEditingController(
      text: '28');
  final TextEditingController quantityController = TextEditingController(
      text: '280');
  final TextEditingController descriptionController = TextEditingController(
      text: 'Sample description Sample description Sample description');
  final TextEditingController stateController = TextEditingController(
      text: 'Madhya Pradesh');
  final TextEditingController districtController = TextEditingController(
      text: 'Bhopal');


  Future<void> saveCommodity(List<String> imagesList) async {
    setLoading(true);

    try{
      await _myRepo.addProductRepo(commodityId: commodityIdController.text,
          varietyId: varietyIdController.text,
          quality: qualityController.text,
          rate: rateController.text,
          quantity: quantityController.text,
          description: descriptionController.text,
          unit: _selectedUnit!,
          state: stateController.text,
          district: districtController.text,
          headers: header,
          images: imagesList
      ).then((value) {
        print(value);
        setLoading(false);
      }).onError((error, stackTrace) {
        print(error);
        setLoading(false);
      });
    }
    finally{
      setLoading(false);
    }

  }

  // ========================================================================

  Future<void> addNewCommodity(BuildContext context, dynamic data) async{
    setLoading(true);
    _myRepo.addNewCommodityRepo(data, header1).then((value){
      Utils.correctSnackBar("Successfully added, please refresh once", context);
      setLoading(false);
      Navigator.of(context).pop();
    }).onError((error, stackTrace) {
      Utils.errorSnackBar('Error $error', context);
      setLoading(false);
    });
  }

  // ========================================================================

  Future<void> addNewVariety(BuildContext context, dynamic data) async{
    setLoading(true);
    _myRepo.addNewVarietyRepo(data, header1).then((value){
      Utils.correctSnackBar("Successfully added, please refresh once", context);
      setLoading(false);
      Navigator.of(context).pop();
    }).onError((error, stackTrace) {
      Utils.errorSnackBar('Error $error', context);
      setLoading(false);
    });
  }

  // ========================================================================

  Future<void> deleteVariety(BuildContext context, id) async{
    setLoading(true);
    _myRepo.deleteVarietyRepo(jsonEncode({}), header1, id).then((value) async {
      Utils.correctSnackBar("Deleted successfully, please refresh once", context);
      setLoading(false);
    }).onError((error, stackTrace) {
      Utils.errorSnackBar('Error $error', context);
      setLoading(false);
    });
  }

  // ========================================================================

  Future<void> deleteCommodity(BuildContext context, id) async{
    setLoading(true);
    _myRepo.deleteCommodityRepo(jsonEncode({}), header1, id).then((value) async {
      Utils.correctSnackBar("Deleted successfully, please refresh once", context);
      setLoading(false);
      Navigator.of(context).pop();
    }).onError((error, stackTrace) {
      Utils.errorSnackBar('Error $error', context);
      setLoading(false);
    });
  }


  // ========================================================================

  Future<void> editCommodity(BuildContext context, data, id) async{
    setLoading(true);
    _myRepo.editCommodityRepo(data, header1, id).then((value){
      Utils.correctSnackBar("Commodity updated successfully, please refresh once!", context);
      setLoading(false);
      Navigator.of(context).pop();
    }).onError((error, stackTrace) {
      Utils.errorSnackBar('Error $error', context);
      setLoading(false);
    });
  }


//   ======================================================================

  ApiResponse<Stats> allStatsList = ApiResponse.Loading();

  setStatsList(ApiResponse<Stats> response) {
    allStatsList = response;
    notifyListeners();
  }

  Future<void> getStats(query) async {
    setStatsList(ApiResponse.Loading());
    _myRepo.getStatsRepo(header, query).then((value) {
      setStatsList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setStatsList(ApiResponse.error(error.toString()));
    });
    notifyListeners();
  }

  // ==========================================================================

  ApiResponse<CommodityVariety> allVarietyByCommodityList = ApiResponse.Loading();

  setCommodityVarietyList(ApiResponse<CommodityVariety> response) {
    allVarietyByCommodityList = response;
    notifyListeners();
  }

  Future<void> getCommodityVariety(id) async {
    setCommodityVarietyList(ApiResponse.Loading());
    _myRepo.getVarietyByCommodityRepo(id, header).then((value) {
      setCommodityVarietyList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setCommodityVarietyList(ApiResponse.error(error.toString()));
    });
    notifyListeners();
  }

}
