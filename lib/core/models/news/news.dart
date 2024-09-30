import 'package:stock_learner/core/models/news/single_new_model.dart';

class NewsDataModel {

  final String keyWord;
  final List<SingleNewModel> news;

  NewsDataModel({
    required this.keyWord,
    required this.news
  });
   
}