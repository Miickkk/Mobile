import 'package:exemplo_geolocator/clima_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main(){
  runApp(MaterialApp(
    home: LocationScreen(),
  ));
}


class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

String locationMessage = "";

//pegar aLocalização do Dispositivo
void _getLocation() async{
  //verificar se o serviço de GPS está habilitado
  bool serviceEnable = await Geolocator.isLocationServiceEnabled();
  if(!serviceEnable){
    locationMessage = "Serviço de Localização está Desativado";
    return;
  }

  //verificar a permissão do GPS
  LocationPermission permission = await Geolocator.checkPermission();
  if(permission == LocationPermission.denied){
    //solicito a liberação do uso do GPS
    permission = await Geolocator.requestPermission();
    if(permission == LocationPermission.denied){
      locationMessage = "Permissão de Localização Negada";
      return;
    }
  }
  //se a permissão foi liberada
  Position position = await Geolocator.getCurrentPosition();
  locationMessage = "Localização Atual: Latitude - ${position.latitude}"
                    + ", Longitude - ${position.longitude}";
}

void _getClima() async{
  //verificar se o serviço de GPS está habilitado
  bool serviceEnable = await Geolocator.isLocationServiceEnabled();
  if(!serviceEnable){
    locationMessage = "Serviço de Localização está Desativado";
    return;
  }

  //verificar a permissão do GPS
  LocationPermission permission = await Geolocator.checkPermission();
  if(permission == LocationPermission.denied){
    //solicito a liberação do uso do GPS
    permission = await Geolocator.requestPermission();
    if(permission == LocationPermission.denied){
      locationMessage = "Permissão de Localização Negada";
      return;
    }
  }
  //se a permissão foi liberada
  Position position = await Geolocator.getCurrentPosition();

  //mostrar o clima
  try {
    final city = await ClimaService.getCityWeatherbyPosition(position);
    locationMessage = "${city["name"]} -- ${city["main"]["temp"] - 273}°C";
  } catch (e) {
    locationMessage = e.toString();
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GPS- Location"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(locationMessage),
            ElevatedButton(
              onPressed: () async{
                  _getLocation();
                setState(() {
                });
              }, 
              child: Text("Pegar Localização")),
            ElevatedButton(
              onPressed: () async{
                _getClima();
                setState(() {
                  
                });
              }, child: Text("Pegar o Clima"))
          ],
        ),
      ),
    );
  }
}