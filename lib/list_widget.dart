



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hacker_news_clone/style.dart';

import 'data_helpers/news_api_provider.dart';
import 'data_helpers/news_item_model.dart';
import 'load_container.dart';

class ListWidget extends StatelessWidget {
  /*final String title;
  final String metaData;
  final String time;
  final String comment;*/
  final int id;
  final newsApiProvider = NewsApiProvider();
  NewsItemModel newsItems;

  ListWidget({
   /* this.title,
    this.metaData,
    this.time,
    this.comment,*/
    this.id,
  });


  fetchNewsItems(int id) async {
    newsItems = await newsApiProvider.fetchItems(id);
    return newsItems;
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder (
        future: fetchNewsItems(id),
        builder:(BuildContext context, AsyncSnapshot<NewsItemModel> itemShapShot) {
          if (!itemShapShot.hasData) {
            return LoadingContainer();
          }
            return buildList(context, itemShapShot.data);
        }
    );
  }

  Widget buildList(BuildContext context, NewsItemModel item) {
    return Card(
      elevation: 3,
      shadowColor: Color(0x14000000),
      margin: const EdgeInsets.fromLTRB(15.0,5.0,15.0,5.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.title,
              style: newsTitle,
            ),
            SizedBox(height: 5.0),

            Text(
              item.text,
              style: newsMetadata,
            ),
            SizedBox(height: 15.0),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.lock_clock,
                  size: 15.0,
                  color: Color(0x80000000),
                ),
                Text(
                  item.time.toString() + " min ago",
                  style: newsTime,
                ),
                SizedBox(width: 5.0),

                const SizedBox(
                  width: 1.0,
                  height: 16.0,
                  child: const DecoratedBox(
                    decoration: const BoxDecoration(
                      color: Color(0x80000000),
                    ),
                  ),
                ),

                SizedBox(width: 5.0),

                Text(
                  item.descendants.toString() + " comments",
                  style: newsComments,
                ),
              ],
            ),
            SizedBox(height: 5.0),

          ],
        ),
      ),
    );
  }
}