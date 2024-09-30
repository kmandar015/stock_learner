import 'package:stock_learner/core/models/news/news.dart';
import 'package:stock_learner/core/respository/news/news_client.dart';

class NewsRepository extends NewsClient {
  Future<NewsDataModel> fetchNews({required String title}) async {
    return await super.fetchNews(title: title);
  }
}
