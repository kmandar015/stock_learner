import 'package:dio/dio.dart';
import 'package:stock_learner/core/constants/api_keys.dart';


class FetchClient {
  Future<Response> fetchData({required Uri uri}) async {
    return await Dio().getUri(uri);
  }

  Future<Response> post({required Uri uri, required Map<String, dynamic> data}) async {
    return await Dio().postUri(uri, data: data);
  }

  // Makes an HTTP request to any endpoint from Financial Modeling Prep API.
  Future<Response> financialModelRequest(String endpoint ) async {
    final Uri uri = Uri.https('financialmodelingprep.com', endpoint, {
      'apikey': kFinancialModelingPrepApi
    });
    
    return await Dio().getUri(uri);
  }
}
