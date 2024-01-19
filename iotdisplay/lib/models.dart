import 'dart:convert';

class SensorRegister {
  final int registroId;
  final String fecha;
  final String hora;
  final int medida;
  final String comentario;

  SensorRegister({
    required this.registroId,
    required this.fecha,
    required this.hora,
    required this.medida,
    required this.comentario,
  });

  factory SensorRegister.fromJson(Map<String, dynamic> json) {
    return SensorRegister(
      registroId: json['RegistroId'],
      fecha: json['Fecha'],
      hora: json['Hora'],
      medida: json['medida'],
      comentario: json['comentario'],
    );
  }
}