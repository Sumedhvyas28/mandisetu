import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mandisetu/data/response/api_response.dart';
import 'package:mandisetu/model/dukandar.dart';
import 'package:mandisetu/model/product.dart';
import 'package:mandisetu/repository/trader_repo.dart';
import 'package:mandisetu/utils/Utils.dart';

class TraderViewModel with ChangeNotifier {
  final _myRepo = TraderRepo();

  dynamic _isLoading = false;

  get isLoading => _isLoading;

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  dynamic header = {
    HttpHeaders.authorizationHeader: 'Bearer 15|Tg7Mxgp3p0Q248yeDdiegCV2mHpJFnJcdFBcsbAle06f98ba'
  };

  dynamic header1 = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer 15|Tg7Mxgp3p0Q248yeDdiegCV2mHpJFnJcdFBcsbAle06f98ba'
  };

  Future<void> addDukandar(BuildContext context, data) async {
    setLoading(true);
    _myRepo.addDukandarRepo(data, header1).then((value) {
      print("Dukandar Added Successfully");
      Utils.correctSnackBar("Dukandar Added Successfully", context);
      setLoading(false);
    }).onError((error, stackTrace) {
      Utils.errorSnackBar("Error : Something went wrong", context);
      setLoading(false);
    });
  }

  //   ======================================================================

  ApiResponse<Product> allProductList = ApiResponse.Loading();

  setProductList(ApiResponse<Product> response) {
    allProductList = response;
    notifyListeners();
  }

  Future<void> getAllProducts() async {
    setProductList(ApiResponse.Loading());
    _myRepo.getAllProductRepo(header).then((value) {
      setProductList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setProductList(ApiResponse.error(error.toString()));
    });
    notifyListeners();
  }

  //   ======================================================================

  ApiResponse<Dukandar> allDukandarOfTraderList = ApiResponse.Loading();

  setDukandarList(ApiResponse<Dukandar> response) {
    allDukandarOfTraderList = response;
    notifyListeners();
  }

  Future<void> getAllDukandar() async {
    setDukandarList(ApiResponse.Loading());
    _myRepo.getDukandarRepo(header).then((value) {
      setDukandarList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setDukandarList(ApiResponse.error(error.toString()));
    });
    notifyListeners();
  }

//   ======================================================================

  Future<void> postInterested(context, dynamic data) async{
    setLoading(true);
    _myRepo.interestedFormRepo(data, header1).then((value){
      Utils.correctSnackBar("Form submitted", context);
      setLoading(false);
      Navigator.pop(context);
    }).onError((error, stackTrace){
      Utils.errorSnackBar("Error: $error", context);
      setLoading(false);
    });
  }

  //   ======================================================================

  Future<void> addSales(context, dynamic data) async{
    setLoading(true);
    _myRepo.addSalesRepo(data, header1).then((value){
      Utils.correctSnackBar("Sales added", context);
      setLoading(false);
    }).onError((error, stackTrace){
      Utils.errorSnackBar("Error: $error", context);
      setLoading(false);
    });
  }


  //   ======================================================================

  Future<void> deleteWholesalerProduct(context, id) async{
    setLoading(true);
    _myRepo.deleteWholesalerProductRepo({}, header, id).then((value) async{
      Utils.correctSnackBar("Deleted Wholesaler Product ", context);
      setLoading(false);
      await getAllProducts();
    }).onError((error, stackTrace){
      Utils.errorSnackBar("Error: $error", context);
      setLoading(false);
    });
  }



}
