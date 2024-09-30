import 'package:dio/dio.dart';
import 'package:stock_learner/core/models/data_overview.dart';
import 'package:stock_learner/core/models/profile/market_index.dart';
import 'package:stock_learner/core/utils/http_helper.dart';

class PortfolioClient extends FetchClient {
  Future<List<MarketIndexModel>> fetchIndexes() async {
    final Response<dynamic> response = await super
        .financialModelRequest('/api/v3/quote/^DJI,^GSPC,^IXIC,^RUT,^VIX');
    return MarketIndexModel.toList(response.data);
  }

  Future<StockOverviewModel> fetchStocks({required String symbol}) async {
    final Response<dynamic> response =
        await super.financialModelRequest('/api/v3/quote/$symbol');
    return StockOverviewModel.fromJson(response.data[0]);
  }
}
