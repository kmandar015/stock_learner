import 'package:dio/dio.dart';
import 'package:stock_learner/core/constants/api_keys.dart';
import 'package:stock_learner/core/models/news/news.dart';
import 'package:stock_learner/core/models/news/single_new_model.dart';
import 'package:stock_learner/core/utils/http_helper.dart';

class NewsClient extends FetchClient {
  Future<NewsDataModel> fetchNews({required String title}) async {
    final Uri newsUri = Uri.https('newsapi.org', '/v2/everything', {
      'q': '"$title"',
      'language': 'en',
      'sortBy': 'popularity',
      'pageSize': '10',
      'apikey': kNewsKey
    });

    final Response<dynamic> newsResponse = await super.fetchData(uri: newsUri);
    final List<SingleNewModel> newsOverviews =
        SingleNewModel.toList(newsResponse.data['articles']);

    return NewsDataModel(
      keyWord: title,
      news: newsOverviews,
    );
  }
}
