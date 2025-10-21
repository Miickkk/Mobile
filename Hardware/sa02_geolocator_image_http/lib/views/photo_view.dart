import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sa02_geolocator_image_http/models/photo_model.dart';

class PhotoView extends StatefulWidget {
  const PhotoView({super.key});

  @override
  State<PhotoView> createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView> {
  List<PhotoModel> photos = [];

  //método para tirar photo
  void takePicture() async{
    //vou por o método para tirar photo do controller
    setState(() {
      // adicionar a photo na lista
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), 
        itemBuilder: (context,index){
          return GestureDetector(
            onTap: () {
              //abre a foto quando clicada com as informaç~eos 
            },
            child: Image.file(photos[index].photoPath),
          );
        }),
      floatingActionButton: FloatingActionButton(onPressed: takePicture),
    );
  }
}