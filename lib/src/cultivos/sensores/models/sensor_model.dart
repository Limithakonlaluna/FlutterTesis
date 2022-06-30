import 'dart:convert';

SensorModel sensorModelFromJson(String str) =>
    SensorModel.fromJson(json.decode(str));

String sensorModelToJson(SensorModel data) => json.encode(data.toJson());

class SensorModel {  
  int humedad_minima;
  int temp_maxima;
  int temp_minima;

  SensorModel({    
    this.humedad_minima = 0,
    this.temp_maxima = 0,
    this.temp_minima = 0,
  });

  factory SensorModel.fromJson(Map<String, dynamic> json) => SensorModel(
        humedad_minima: json["humedad_minima"],
        temp_maxima: json["temp_maxima"],
        temp_minima: json["temp_minima"],
      );

  Map<String, dynamic> toJson() => { 
        "humedad_minima": humedad_minima,
        "temp_maxima": temp_maxima,
        "temp_minima": temp_minima,
      };
}
