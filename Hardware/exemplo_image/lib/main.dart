import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main(){
  runApp(MaterialApp(home: ImagePickerScreen(),));
}

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  //vamos manipular imagems da galeria e imagens da camera (arquivos)
  File? _image; //manipualr arquivos do Dispositivo
  //cria uma classe de controller para manipular a camera e a galeria
  final _picker = ImagePicker();//obj controller de uso da camera/galeria

  //métodos
  // método para tirar foto
  void _getImageFromCamera() async{
    //abrir a camera e permitir tirar uma foto
    //aramazenar a foto em uma arquivo temporario
    final XFile? fotoTemporaria = await _picker.pickImage(source: ImageSource.camera);
    //verificar se Xfile não esta vazio
    if (fotoTemporaria !=null){
      setState(() {
        //pega a imagem temporaria e tranfere para file:io
        _image = File(fotoTemporaria.path);
      });
    }
  }
  //método para pegar imagem da galeria
  void _getImageFromGallery() async{
    //abrir a camera e permitir tirar uma foto
    //aramazenar a foto em uma arquivo temporario
    final XFile? fotoTemporaria = await _picker.pickImage(source: ImageSource.gallery);
    //verificar se Xfile não esta vazio
    if (fotoTemporaria !=null){
      setState(() {
        //pega a imagem temporaria e tranfere para file:io
        _image = File(fotoTemporaria.path);
      });
    }
  }

  //build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Exemplo Image Picker"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //mostrar a imagem selecionada pelo ImagePicker
            _image != null
            ? Image.file(_image!, height: 300,)
            : Text("Nehuma Iamgem Selecionada"),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: _getImageFromCamera, 
              child: Text("Tirar Foto")),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: _getImageFromGallery, 
              child: Text("Escolher da Galeria"))
          ],
        ),
      ),
    );
  }
}