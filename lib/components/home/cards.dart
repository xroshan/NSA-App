import 'package:flutter/material.dart';

import './detail.dart';

import '../../data/main_data.dart';               //local database


//News Card that goes into HomePage to display news
class NewsCard extends StatefulWidget {
  final int index;                    //index -> index of news in News list

  NewsCard(this.index);

  @override
  _NewsCardState createState() => _NewsCardState(index);
}

class _NewsCardState extends State<NewsCard> {
  final int i;                                              //i -> index of news in News list
  _NewsCardState(this.i);

  static final headerTextStyle = const TextStyle(                                 //some text fonts
      color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w600);

  static final regularTextStyle = const TextStyle(
      color: Color(0xffb6b2df), fontSize: 14.0, fontWeight: FontWeight.w400);

  static final posterTextstyle = regularTextStyle.copyWith(fontSize: 16.0);

  Widget _buildNewsCardContent() {                          //builds the details that goes inside news card
    return new InkWell(
      onTap: () => Navigator.push(context,                            //navigate to the new detail page
          MaterialPageRoute(builder: (context) => NewsDetailView(i))),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: Colors.white, width: 0.5)),
        padding: EdgeInsets.fromLTRB(75.0, 8.0, 8.0, 8.0),
        constraints: BoxConstraints.expand(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(                      
              publishedNews[i].headline,  
              style: headerTextStyle,
            ),
            Expanded(                       //contains news contents
              child: new Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  publishedNews[i].content,
                  style: regularTextStyle,
                  softWrap: true,
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            Divider(          
              color: Colors.white,
              height: 1.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Icon(
                  Icons.hot_tub,            //TODO.. to be replaced with views icon that indicates number of views
                  color: Colors.white,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 3.0, right: 12.0),
                  child: Text(
                    publishedNews[i].views.toString(),
                    style: posterTextstyle,
                  ),
                ),
                Icon(
                  Icons.comment,
                  color: Colors.white,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 3.0, right: 12.0),
                  child: Text(
                    '12',
                    //publishedNews[i].comments.length.toString(),  //no. of comments
                    style: posterTextstyle,
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Text(
                  '- ' + publishedNews[i].publisherID.toString(),                       //publisher information
                  style: posterTextstyle,
                ),
                Container(
                  height: 25.0,
                  width: 25.0,
                  margin: EdgeInsets.only(left: 3.0),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/login2.webp'),      //TODO.. to be used from cloud firestore database
                          fit: BoxFit.cover),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.0)),
                ),
                new Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    '(' +
                        publishedNews[i].datetime.month.toString() +              //published date
                        '/' +
                        publishedNews[i].datetime.day.toString() +
                        ')',
                    style: posterTextstyle,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildNewsThumbnail() {          //builds the thumbnail that potrays news picture
    return new InkWell(
      onTap: () => Navigator.push(context,                                //on pressing thumbnail, page navigates News detail
          MaterialPageRoute(builder: (context) => NewsDetailView(i))),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 16.0),
        alignment: FractionalOffset.centerLeft,
        child: ClipRRect(                                             //rectangular frame with border radius
          borderRadius: BorderRadius.circular(10.0),
          child: Image(
            image: AssetImage('assets/login2.webp'),    //TODO.. image needs to be loaded from database
            fit: BoxFit.cover,
            height: 110.0,
            width: 110.0,
          ),
        ),
      ),
    );
  }

  Widget _buildNewsCard() {     //builds the news card
    return Container(
      height: 150.0,
      margin: EdgeInsets.only(left: 46.0),
      decoration: BoxDecoration(            //provides shape and border radius and shadow
          color: Color(0xFF333366),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black12,           //black with 12% opacity
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0))
          ]),
      child: _buildNewsCardContent(),
    );
  }

  @override
  Widget build(BuildContext context) {          //main widget builder.. 
    return Container(
      height: 150.0,
      margin: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 10.0,
      ),
      child: Stack(                               //stack the thumbnail over the news card 
        children: <Widget>[_buildNewsCard(), _buildNewsThumbnail()],
      ),
    );
  }
}
