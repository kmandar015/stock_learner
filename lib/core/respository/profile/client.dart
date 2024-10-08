import 'package:dio/dio.dart';
import 'package:stock_learner/core/constants/api_keys.dart';
import 'package:stock_learner/core/models/profile/profile.dart';
import 'package:stock_learner/core/models/profile/stock_chart.dart';
import 'package:stock_learner/core/models/profile/stock_profile.dart';
import 'package:stock_learner/core/models/profile/stock_quote.dart';
import 'package:stock_learner/core/utils/http_helper.dart';
import 'package:stock_learner/core/utils/variables.dart';

class ProfileClient extends FetchClient {
  Future<StockQuote> fetchProfileChanges({required String symbol}) async {
    final Uri uri = Uri.https(authority, '/api/v3/quote/$symbol');
    final Response<dynamic> response = await FetchClient().fetchData(uri: uri);

    return StockQuote.fromJson(response.data[0]);
  }

  Future<ProfileModel> fetchStockData({required String symbol}) async {
    final Response<dynamic> stockProfile =
        await super.financialModelRequest('/api/v3/company/profile/$symbol');
    final Response<dynamic> stockQuote =
        await super.financialModelRequest('/api/v3/quote/$symbol');
    final Response<dynamic> stockChart = await _fetchChart(symbol: symbol);

    return ProfileModel(
      stockQuote: StockQuote.fromJson(stockQuote.data[0]),
      stockProfile: StockProfile.fromJson(stockProfile.data['profile']),
      stockChart: StockChart.toList(stockChart.data['historical']),
    );
  }

  static Future<Response> _fetchChart({required String symbol}) async {
    final DateTime date = DateTime.now();
    final Uri uri =
        Uri.https(authority, '/api/v3/historical-price-full/$symbol', {
      'from': '${date.year - 1}-${date.month}-${date.day}',
      'to': '${date.year}-${date.month}-${date.day - 1}',
      'apikey': kFinancialModelingPrepApi
    });

    return await FetchClient().fetchData(uri: uri);
  }
}
