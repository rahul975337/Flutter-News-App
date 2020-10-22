import 'package:flutter/material.dart';

import 'package:newsApp/helper/news.dart';
import 'package:newsApp/helper/widgets.dart';

class CategoryNews extends StatefulWidget {
  final String newsCategory;

  CategoryNews({this.newsCategory});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  var newslist;
  bool _loading;

  @override
  void initState() {
    getNews();
    super.initState();
  }

  Future<void> getNews() async {
    setState(() {
      _loading = true;
    });
    NewsForCategorie news = NewsForCategorie();
    await news.getNewsForCategory(widget.newsCategory);
    newslist = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              '${widget.newsCategory}'[0].toUpperCase(),
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            ),
            Text(
              '${widget.newsCategory}'.substring(1),
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        actions: <Widget>[
          Opacity(
            opacity: 0.8,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(
                  Icons.share,
                )),
          )
        ],
        elevation: 1.0,
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              child: SingleChildScrollView(
                child: Container(
                  child: Container(
                    margin: EdgeInsets.only(top: 16),
                    child: ListView.builder(
                        itemCount: newslist.length,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return NewsTile(
                            imgUrl: newslist[index].urlToImage ?? "",
                            title: newslist[index].title ?? "",
                            desc: newslist[index].description ?? "",
                            content: newslist[index].content ?? "",
                            posturl: newslist[index].articleUrl ?? "",
                          );
                        }),
                  ),
                ),
              ),
              onRefresh: getNews,
            ),
    );
  }
}
