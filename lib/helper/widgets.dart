import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import '../views/article_view.dart';

Widget myAppBar(IconButton iconButton) {
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          "Flutter",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        Text(
          "News",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
        )
      ],
    ),
    elevation: 1.0,
    actions: <Widget>[iconButton],
  );
}

class NewsTile extends StatelessWidget {
  final String imgUrl, title, desc, content, posturl;
  final DateTime publishedAt;

  NewsTile(
      {this.imgUrl,
      this.desc,
      this.title,
      this.content,
      @required this.posturl,
      this.publishedAt});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                      postUrl: posturl,
                    )));
      },
      child: Card(
        elevation: 5,
        child: Container(
            margin: EdgeInsets.only(bottom: 24),
            width: MediaQuery.of(context).size.width,
            child: Container(
              child: Container(
                // padding: EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(6),
                        bottomLeft: Radius.circular(6))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.network(
                          imgUrl,
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        )),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        title,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        desc,
                        maxLines: 2,
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      color: Colors.black,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Text(
                        "Published at: " +
                            formatDate(publishedAt,
                                [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn]),
                        maxLines: 2,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
