import 'package:flutter/material.dart';
import 'package:stock_learner/core/models/news/single_new_model.dart';
import 'package:stock_learner/core/shared/styles.dart';
import 'package:stock_learner/core/utils/url/url.dart';


class NewsCardWidget extends StatelessWidget {

  final String title;
  final List<SingleNewModel> news;

  const NewsCardWidget({super.key,
    required this.title,
    required this.news
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Divider(),
        Text(this.title, style: kCompanyNameHeading),
        SizedBox(
          height: 225,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,

            itemCount: news.length,
            itemBuilder: (BuildContext context, int i) => Padding(
              padding: const EdgeInsets.only(top: 8, right: 24),
              child: _renderNewsArticle(news[i])
            )
          ),
        )
      ],
    );
  }

  Widget _renderNewsArticle(SingleNewModel singleNew) {

    print(singleNew.title);
    return GestureDetector(
      onTap: () => launchUrl(singleNew.url),
      child: SizedBox(
        width: 200,
        child: Column(
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                singleNew.title, 
                style: const TextStyle(
                  height: 1.6,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color:  Color(0XFFc2c2c2)
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            Container(
              height: 125,
              decoration: BoxDecoration(
                image: DecorationImage( image: _imageIsValid(singleNew.urlToImage))
              ),
            ),
          ],
        ),
      ),
    );
  }

  ImageProvider _imageIsValid(String url) {
    if(url == null){
      return AssetImage('assets/images/default.jpg');
    }else {
      return NetworkImage(url);
    }
  }
}

