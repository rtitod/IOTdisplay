import 'dart:convert';

class SensorRegister {
  final int registroId;
  final String fechayHora;
  final int medida;
  final String comentario;

  SensorRegister({
    required this.registroId,
    required this.fechayHora,
    required this.medida,
    required this.comentario,
  });

  factory SensorRegister.fromJson(Map<String, dynamic> json) {
    return SensorRegister(
      registroId: json['RegistroId'],
      fechayHora: json['FechayHora'],
      medida: json['medida'],
      comentario: json['comentario'],
    );
  }
}