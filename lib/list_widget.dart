



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hacker_news_clone/style.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'data_helpers/news_api_provider.dart';
import 'data_helpers/news_item_model.dart';
import 'load_container.dart';

class ListWidget extends StatelessWidget {
  final int id;
  final newsApiProvider = NewsApiProvider();
  NewsItemModel newsItems;

  ListWidget({
    this.id,
  });


  Future <NewsItemModel>fetchNewsItems(int id) async {
    newsItems = await newsApiProvider.fetchItems(id);
    return newsItems;
  }


  String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
      time = diff.inHours.toString() + " Hours Ago";
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' Day Ago';
      } else {
        time = diff.inDays.toString() + ' Days Ago';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' Week Ago';
      } else {
        time = (diff.inDays / 7).floor().toString() + ' Weeks Ago';
      }
    }

    return time;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder (
        future: fetchNewsItems(id),
        builder:(BuildContext context, itemShapShot) {
          if (!itemShapShot.hasData) {
            return LoadingContainer();
          }
            return buildList(context, itemShapShot.data);
        }
    );
  }

  Widget buildList(BuildContext context, NewsItemModel item) {
    var time = readTimestamp(item.time);

    return InkWell(
      child: Card(
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
                "The Author : " + item.by + "\n\n" +
                    "The description of the news is not available through the api",
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
                    time,
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
      ),
      onTap: (){
        _launchURL(item.url);
      },
    );

  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}