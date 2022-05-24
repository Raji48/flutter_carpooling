import 'package:carpooling/Utilis/devicesize.dart';
import 'package:carpooling/Utilis/style.dart';
import 'package:flutter/material.dart';
import'package:carpooling/Model/slide.dart';

class SlideItem extends StatefulWidget {
  final int index;
  SlideItem(this.index);

  @override
  _SlideItemState createState() => _SlideItemState();
}

class _SlideItemState extends State<SlideItem> {
  @override
  Widget build(BuildContext context) {

    return Container(
        child: Padding(
         padding: const EdgeInsets.all(20),
       child:Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[

        Container(
          width: double.infinity,
          height:150, //getDeviceheight(context, 0.1),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(slideList[widget.index].imageUrl),
            ),
          ),
        ),
        SizedBox(
          height: getDeviceheight(context, 0.02),
        ),
        Text(
          slideList[widget.index].title,
          style: onboardtextstyle,//kTitlestyle,
        ),
        SizedBox(
          height: getDeviceheight(context, 0.01)
        ),
        Text(
          slideList[widget.index].description,
          style: kSubtitlestyle,
          textAlign: TextAlign.center,
        ),
      ],
       )));
  }
}