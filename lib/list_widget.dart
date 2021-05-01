



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hacker_news_clone/style.dart';

class ListWidget extends StatelessWidget {
  final String title;
  final String metaData;
  final String time;
  final String comment;

  ListWidget({
    this.title,
    this.metaData,
    this.time,
    this.comment,
  });

  @override
  Widget build(BuildContext context) {
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
              '$title',
              style: newsTitle,
            ),
            SizedBox(height: 5.0),

            Text(
              '$metaData',
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
                  '$time',
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
                  '$comment comments',
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