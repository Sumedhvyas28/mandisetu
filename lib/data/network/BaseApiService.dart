abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(String url);

  Future<dynamic> getGetApiWithQueryResponse(String url, dynamic header, dynamic queryParams);

  Future<dynamic> getGetApiWithHeaderResponse(String url, dynamic header);

  Future<dynamic> getPostApiResponse(String url, dynamic data);

  Future<dynamic> getPostApiWithHeaderResponse(String url, dynamic data, dynamic header);
}
