//serviço de conexão com api de clima

import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class ClimaService {
  static const String baseUrl = "https://api.openweathermap.org/data/2.5/weather";
  static const String apiKey = "90290436d34bb91b4d852afe49197129";

  // método para consultar clima pela latitude e longitude
  static Future<Map<String,dynamic>> getCityWeatherbyPosition(Position position) async{
    //solicitação http request -> para a api
    final response =  await http.get(
      Uri.parse(
        "$baseUrl?appid=$apiKey&lat=${position.latitude}&lon=${position.longitude}")
    );
    //verificar a resposta
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      throw Exception("Localização não Encontrada");
    }

  }

}