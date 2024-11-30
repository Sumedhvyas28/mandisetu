import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:mandisetu/data/response/api_response.dart';
import 'package:mandisetu/model/news.dart';
import 'package:mandisetu/model/purchase_request.dart';
import 'package:mandisetu/model/banner.dart' as b;
import 'package:mandisetu/repository/admin_request_repo.dart';
import 'package:mandisetu/utils/Utils.dart';

class AdminProductRequest with ChangeNotifier {
  final _myRepo = AdminRequestRepo();

  dynamic _isLoading = false;

  get isLoading => _isLoading;

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  dynamic header = {
    HttpHeaders.authorizationHeader:
        'Bearer 15|Tg7Mxgp3p0Q248yeDdiegCV2mHpJFnJcdFBcsbAle06f98ba'
  };

  dynamic header1 = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader:
        'Bearer 15|Tg7Mxgp3p0Q248yeDdiegCV2mHpJFnJcdFBcsbAle06f98ba'
  };

  //   ======================================================================

  ApiResponse<PurchaseRequest> allPurchaseRequestList = ApiResponse.Loading();

  setPurchaseRequestList(ApiResponse<PurchaseRequest> response) {
    allPurchaseRequestList = response;
    notifyListeners();
  }

  Future<void> getAllPurchaseRequest() async {
    setPurchaseRequestList(ApiResponse.Loading());
    _myRepo.getPurchaseRequestRepo(header).then((value) {
      setPurchaseRequestList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setPurchaseRequestList(ApiResponse.error(error.toString()));
    });
    notifyListeners();
  }

  // ====================================================================================

  Future<void> uploadPromotion({
    required BuildContext ctx,
    required List<String> images,
  }) async {
    setLoading(true);

    try {
      await _myRepo.uploadBanner(
        images: images,
        headers: header,
      );
      Utils.correctSnackBar("Uploaded", ctx);
    } catch (e) {
      print('Error in ViewModel: $e');

      Utils.errorSnackBar("Error $e", ctx);
    } finally {
      setLoading(false);
    }
  }

  // ==========================================================================================

  ApiResponse<b.Banner> allBannerList = ApiResponse.Loading();

  setBannerList(ApiResponse<b.Banner> response) {
    allBannerList = response;
    notifyListeners();
  }

  Future<void> getBanners() async {
    setBannerList(ApiResponse.Loading());
    _myRepo.getBannerRepo(header).then((value) {
      setBannerList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setBannerList(ApiResponse.error(error.toString()));
    });
    notifyListeners();
  }

  // ========================================================================

  Future<void> deleteBanner(BuildContext context, id) async {
    setLoading(true);
    _myRepo.deleteBannerRepo(jsonEncode({}), header1, id).then((value) async {
      Utils.correctSnackBar(
          "Deleted successfully, please refresh once", context);
      setLoading(false);
      Navigator.of(context).pop();
    }).onError((error, stackTrace) {
      Utils.errorSnackBar('Error $error', context);
      setLoading(false);
    });
    notifyListeners();
  }

  // ==========================================================================

  Future<void> uploadNews({
    context,
    image,
    title,
    desc,
  }) async {
    setLoading(true);
    try {
      await _myRepo
          .uploadNewsRepo(
        image: image,
        title: title,
        desc: desc,
      )
          .then((value) {
        setLoading(false);
        Utils.correctSnackBar("News Uploaded", context);
      }).onError((error, stackTrace) {
        Utils.errorSnackBar("Error: $error", context);
        setLoading(false);
      });
    } catch (e) {
      Utils.errorSnackBar("Error: $e", context);
      setLoading(false);
    } finally {
      setLoading(false);
    }
  }


  // ==========================================================================

  ApiResponse<NewsList> allNewsList = ApiResponse.Loading();

  setNewsList(ApiResponse<NewsList> response) {
    allNewsList = response;
    notifyListeners();
  }

  Future<void> getNews() async {
    setNewsList(ApiResponse.Loading());
    _myRepo.getNewsRepo(header).then((value) {
      setNewsList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setNewsList(ApiResponse.error(error.toString()));
    });
    notifyListeners();
  }

  // ========================================================================

  Future<void> deleteNews(BuildContext context, id) async {
    setLoading(true);
    _myRepo.deleteNewsRepo(jsonEncode({}), header1, id).then((value) async {
      Utils.correctSnackBar(
          "Deleted successfully, please refresh once", context);
      setLoading(false);
      Navigator.of(context).pop();
    }).onError((error, stackTrace) {
      Utils.errorSnackBar('Error $error', context);
      setLoading(false);
    });
    notifyListeners();
  }

  // ==========================================================================
  // ==========================================================================
  // ==========================================================================

  Future<void> approveRequest(BuildContext context, id) async {
    setLoading(true);
    _myRepo.requestApprovedRepo(jsonEncode({}), header1, id).then((value) async {
      // Utils.correctSnackBar("Approved successfully, please refresh once", context);
      print('Done ✅');
      getAllPurchaseRequest();
      setLoading(false);
    }).onError((error, stackTrace) {
      // Utils.errorSnackBar('Error $error', context);
      print('Error ✅');
      setLoading(false);
    });
    notifyListeners();
  }

  // ==========================================================================

  Future<void> cancelRequest(BuildContext context, id) async {
    setLoading(true);
    _myRepo.requestCancelRepo(jsonEncode({}), header1, id).then((value) async {
      print('Done ✅');
      getAllPurchaseRequest();
      setLoading(false);
    }).onError((error, stackTrace) {
      setLoading(false);
      print('Error ✅');
    });
    notifyListeners();
  }

  // ==========================================================================

  Future<void> deliveredRequest(BuildContext context, id) async {
    setLoading(true);
    _myRepo.requestApprovedRepo(jsonEncode({}), header1, id).then((value) async {
      // Utils.correctSnackBar("Approved successfully, please refresh once", context);
      print('Done ✅');
      getAllPurchaseRequest();
      setLoading(false);
    }).onError((error, stackTrace) {
      // Utils.errorSnackBar('Error $error', context);
      print('Error ✅');
      setLoading(false);
    });
    notifyListeners();
  }


}
