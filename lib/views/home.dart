import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../helper/data.dart';
import '../helper/widgets.dart';
import '../models/categoryModel.dart';
import '../views/category_news.dart';

import '../helper/news.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _loading;
  var newslist;

  List<CategorieModel> categories = List<CategorieModel>();

  void getNews() async {
    News news = News();
    await news.getNews();
    newslist = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    _loading = true;
    super.initState();

    categories = getCategories();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyAppBar(),
      drawer: Drawer(
        child: SafeArea(
          child: Center(child: Text('Categories can be added here')),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),

                /// Categories
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 80,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return CategoryCard(
                          imageAssetUrl: categories[index].imageAssetUrl,
                          categoryName: categories[index].categorieName,
                        );
                      }),
                ),
                Divider(),

                /// News Article

                if (_loading)
                  Column(
                    children: [
                      SizedBox(
                        height: deviceSize.height * 0.25,
                      ),
                      CircularProgressIndicator(),
                    ],
                  )
                else
                  Container(
                    margin: EdgeInsets.only(top: 5),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String imageAssetUrl, categoryName;

  CategoryCard({this.imageAssetUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryNews(
                      newsCategory: categoryName.toLowerCase(),
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 14),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                imageUrl: imageAssetUrl,
                height: 80,
                width: 160,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              height: 23,
              width: 160,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black54),
              child: Center(
                child: Text(
                  categoryName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
