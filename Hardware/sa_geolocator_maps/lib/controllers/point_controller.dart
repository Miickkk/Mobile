//formatador de data hora (intl)
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import '../models/location_points.dart';


class PointController {
  final DateFormat _formatar = DateFormat("dd/MM/yyyy - HH:mm:ss");

  //solicitar a localização do dispositivo
  //método para pegar a localização
  Future<LocationPoints> getcurrentLocation() async{
    //verificar se as permissões estão liberadas
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnable){
      throw Exception("Sem Acesso ao GPS");
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        throw Exception("Permissão Negada de Acesso ao GPS");
      }
    }
    //acesso Liberado
    Position position = await Geolocator.getCurrentPosition();
    String dataHora = _formatar.format(DateTime.now());
    //criar um obj de Model
    LocationPoints posicaoAtual = LocationPoints(
      latitude: position.latitude, 
      longitude: position.longitude, 
      dataHora: dataHora);

    return posicaoAtual;//devolve o OBJ Criado

  }
}