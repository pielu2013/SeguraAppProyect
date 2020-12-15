import 'dart:convert';

import 'package:proyectoseguraap/src/models/coordenadas_model.dart';

import 'package:http/http.dart' as http;


class MarcadoresProvider{

  final String _url = 'https://proyectos-c8d56-default-rtdb.firebaseio.com';

  Future<bool> crearMarcador( CoordenadasModel marcador  ) async{
    
    final url = '$_url/marcadores.json';

    final resp = await http.post(url, body: coordenadasModelToJson(marcador));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<bool> editarMarcador( CoordenadasModel marcador  ) async{
    
    final url = '$_url/marcadores/${ marcador.id }.json';

    final resp = await http.put(url, body: coordenadasModelToJson(marcador));

    final decodedData = json.decode(resp.body);

    print( decodedData );

    return true;
  }

  Future<List<CoordenadasModel>> cargarMarcadores() async{

    final url = '$_url/marcadores.json';
    final resp = await http.get(url);


    final  Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<CoordenadasModel> marcador = new List();

    if( decodedData == null ) return[];

    decodedData.forEach(( id, marc ) {
    
      final marcTemp = CoordenadasModel.fromJson(marc);
      marcTemp.id = id;

      marcador.add(marcTemp);

    });
    
    print(marcador);
    return marcador;
  } 

  Future<int> borrarLugar ( String id ) async{
    final url = '$_url/marcadores/$id.json';
    final resp = await http.delete(url);

    print( resp.body );

    return 1;

  }

}