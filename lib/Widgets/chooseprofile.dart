

import 'package:carpooling/Res/index.dart';
import 'package:carpooling/Res/strings.dart';
//import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
class Chooseprofilephoto extends StatefulWidget {

  @override
  _ChooseprofilephotoState createState() => _ChooseprofilephotoState();
}

class _ChooseprofilephotoState extends State<Chooseprofilephoto> {
  //Dio dio =new Dio();
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Container(
        height:100.0,
        width:MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(
          horizontal:20,vertical: 20,
        ),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:<Widget>[
            SizedBox(
              height:40,
            ),
                  Container(
                      decoration: BoxDecoration(
                        color: whitelight,
                        border: Border.all(
                          color: greylight,
                          width:2,),
                         borderRadius: BorderRadius.all(
                            Radius.circular(20.0)),
                      ),
               child: FlatButton(
                  onPressed: (){
                  takePhoto(ImageSource.camera);
                  Navigator.pop(context);
                    },
                  child: Column(
                      children: <Widget>[
                        SizedBox(height: 20,),
                        new IconButton(icon:new Image(image:cameraicon),),
                        SizedBox(height: 10,),
                   Text(camera),]),
                )),//),
            Container(
                decoration: BoxDecoration(
                  color: whitelight,
                  border: Border.all(
                    color: greylight,
                    width:2,),
                  borderRadius: BorderRadius.all(
                      Radius.circular(20.0)),
                ),
                child: FlatButton(
                  onPressed:  () {
                    takePhoto(ImageSource.gallery);
                    Navigator.pop(context);

                  },
                  child: Column(
                      children: <Widget>[
                        SizedBox(height: 20,),
                      new IconButton(icon:new Image(image:galleryicon),),
                       //,size: 35,color: grey,),
                        //SizedBox(height: 10,),
                        Text(gallery),]),
                )),
            Container(
                decoration: BoxDecoration(
                  color: whitelight,
                  border: Border.all(
                    color: greylight,
                    width:2,),
                  borderRadius: BorderRadius.all(
                      Radius.circular(20.0)),
                ),
                child: FlatButton(
                  onPressed: (){
                    setState(() {
                      _imageFile=="";
                    });
                    Navigator.pop(context);
                    // takePhoto(ImageSource.gallery);
                  },
                  child: Column(
                      children: <Widget>[
                        SizedBox(height: 20,),
                        Icon(Icons.do_disturb_on_rounded,size: 35,color: grey,),
                        SizedBox(height: 10,),
                        Text(remove,),]))),
          ],
        )
    );
  }

  void takePhoto(ImageSource source) async{
    final pickedFile =await _picker.getImage(source: source,);
    setState(() {
      _imageFile = pickedFile;
    });
  /* try{
      String filename=_imageFile.path.split('/').last;
      FormData formData =new FormData.fromMap({
        "_imagefile":
            await MultipartFile.fromFile(_imageFile.path,filename: filename,
            contentType: MediaType('_imagefile','png')),
           "type":"_imagefile/png"
      });
      Response response=
          await dio.post("",data: formData,options: Options(
            headers: {

              "Authorization":"jwt accesstoken",
              "Content-Type":"multipart/form-data"
            }
          ));
    }catch(e){
      print(e);
    }*/
  }}

//takePhoto(ImageSource.camera);
//takePhoto(ImageSource.gallery);