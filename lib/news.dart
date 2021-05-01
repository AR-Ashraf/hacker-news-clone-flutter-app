import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hacker_news_clone/data_helpers/news_api_provider.dart';
import 'package:hacker_news_clone/style.dart';
import 'list_widget.dart';

class News extends StatefulWidget{
  @override
  _NewsPageState createState() => _NewsPageState();

}
class _NewsPageState extends State<News>{



  final newsApiProvider = NewsApiProvider();
  int tag = 0;
  int pastNews = 0;
  int items = 10;
  List<String> options = [
    'New', 'Past',
  ];
  List<int> ids;


  @override
  void initState() {
    super.initState();
  }
  Future <List<int>> fetchTopIds() async {
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
                    ),
                  ),
                ],
              ),
            ),

            FutureBuilder (
                future: fetchTopIds(),
                builder:(context, snapshot) {
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
                            itemCount: items,
                            itemBuilder: (c, i) {
                              if (tag == 1){
                                i += 30;
                              }
                              return  ListWidget(
                                  id: snapshot.data[i],
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

                        setState(() {
                          if((items + 10) <= ids.length){
                            items += 10;
                            Fluttertoast.showToast(
                              msg: "More News Are Loading...",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              textColor: Colors.black,
                              backgroundColor: Color(0xffFFFFFF),
                            );
                          } else{
                            Fluttertoast.showToast(
                              msg: "No More News Left " + items.toString(),
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              textColor: Colors.black,
                              backgroundColor: Color(0xffFFFFFF),
                            );
                          }
                        });
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

