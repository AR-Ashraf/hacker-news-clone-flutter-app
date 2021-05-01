import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hacker_news_clone/data_helpers/news_api_provider.dart';
import 'package:hacker_news_clone/data_helpers/news_item_model.dart';
import 'package:hacker_news_clone/rest_api_handler.dart';
import 'package:hacker_news_clone/style.dart';

import 'api_helpers/apiConstrants.dart';
import 'list_widget.dart';

class News extends StatefulWidget{
  @override
  _NewsPageState createState() => _NewsPageState();

}
class _NewsPageState extends State<News>{



  final newsApiProvider = NewsApiProvider();
  int tag = 0;
  List<String> options = [
    'New', 'Past',
  ];
  List<int> ids;
  Future future;


  @override
  void initState() {
    super.initState();
    future = fetchTopIds();
  }
  fetchTopIds() async {
    ids = await newsApiProvider.fetchTopId();
    return ids;

  }




  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar:  AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.contain,
              ),
            ],

          ),
        ),
      body: new Container(
        child: Column(
          children:<Widget> [
            Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                children: <Widget>[
                  ChipsChoice<int>.single(
                    choiceActiveStyle: chipStyle,
                    value: tag,
                    onChanged: (val) => setState(() => tag = val),
                    choiceItems: C2Choice.listFrom<int, String>(
                      source: options,
                      value: (i, v) => i,
                      label: (i, v) => v,
                      //tooltip: (i, v) => v,
                    ),
                  ),
                ],
              ),
            ),

            FutureBuilder <List<int>>(
                future: future,
                builder:(context, AsyncSnapshot <List<int>> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return Container(
                        child: Expanded(
                          child: ListView.separated(
                            separatorBuilder: (c, i) {
                              return Padding(
                                  padding: EdgeInsets.only(top: 5, bottom: 5));
                            },
                            itemCount: ids.length,
                            itemBuilder: (c, i) {

                              return ListWidget(
                                id: snapshot.data[i],
                                /*title: "This is a blast!",
                                metaData: "Do you know what happened? Do you wanna know> Lets discover these things. These are maddy faltu.",
                                time: "1 min ago",
                                comment: "50",*/

                              );
                            },
                          ),
                        ),
                    );
                  }
                }
            ),




            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15,0.0,15.0,20.0),
                    child: TextButton(
                      style: loadButtonStyle,
                      onPressed: (){
                      },
                      child: Text(
                        "Load More",
                        style: loadText,
                      ),
                    ),
                  ),
                ),

              ],
            ),

            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * (12/100),
              color: Color(0xffFFC700),
              child: Center(
                child: Image.asset('assets/images/logoBlack.png'),
              ),
            ),



          ],
        ),
      ),

    );

  }


}

