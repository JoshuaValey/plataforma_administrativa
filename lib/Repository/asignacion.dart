class Asignacion {
  final String? id;
  final String? idUsuario;
  final String? idProyecto;
 

  Asignacion(
      { this.id,
      required this.idUsuario,
      required this.idProyecto,
      });

// vuelve ha crear el meetodo fromjson
  factory Asignacion.fromJson(Map<String, dynamic> json) {
    return Asignacion(
      id: json['id'] as String,
      idUsuario: json['idUsuario'] as String,
      idProyecto: json['idProyecto'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idUsuario': idUsuario,
      'idProyecto': idProyecto,
    };
  }
}