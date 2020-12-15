// To parse this JSON data, do
//
//     final coordenadasModel = coordenadasModelFromJson(jsonString);

import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

CoordenadasModel coordenadasModelFromJson(String str) => CoordenadasModel.fromJson(json.decode(str));

String coordenadasModelToJson(CoordenadasModel data) => json.encode(data.toJson());

class CoordenadasModel {
    CoordenadasModel({
        this.id,
        this.direccin,
        this.latitud = 0.0,
        this.longitud = 0.0,
    });

    String id;
    String direccin;
    double latitud;
    double longitud;


    LatLng getLatLng(){
      
      final lat  = this.latitud;
      final long = this.longitud;

      return LatLng( lat, long ); 
      
    }

    factory CoordenadasModel.fromJson(Map<String, dynamic> json) => CoordenadasModel(
        id      : json["id"],
        direccin: json["dirección"],
        latitud : json["latitud"].toDouble(),
        longitud: json["longitud"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        // "id"       : id,
        "dirección": direccin,
        "latitud"  : latitud,
        "longitud" : longitud,
    };
}