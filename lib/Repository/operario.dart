
class Operario {
  final String? id;
  final String documentoIdentificacion;
  final String nombres;
  final String apellidos;
  final String nacionalidad;
  final String rol;
  final String sexo;
  final DateTime fechaNacimiento;
  final DateTime fechaInicioLabores;
  final String jornada;
  final String empresa;
  final String? idProyectoActual;
  bool isChecked;

  @override
  String toString() =>
      /*'''   
      Proyecto Actual:
      ${Singleton.instance.proyectos[idProyectoActual].name}   
      DPI: $dpi
      Nombre: $nombres
      Rol: $rol
      Empresa: $empresa
      Status:  ${isChecked ? 'Asistencia' : 'Inasistencia'} '
      
      '''*/
      '';

  Operario(
      { this.id,
      required this.jornada,
      required this.nacionalidad,
      required this.sexo,
      required this.documentoIdentificacion,
      required this.nombres,
      required this.apellidos,
      required this.rol,
      required this.empresa,
      required this.fechaNacimiento,
      required this.fechaInicioLabores,
      required this.idProyectoActual,
      required this.isChecked});

// vuelve ha crear el meetodo fromjson
  factory Operario.fromJson(Map<String, dynamic> json) {
    return Operario(
      id: json['id'] as String,
      documentoIdentificacion: json['documentoIdentificacion'] as String,
      nombres: json['nombres'] as String,
      apellidos: json['apellidos'] as String,
      nacionalidad: json['nacionalidad'] as String,
      rol: json['rol'] as String,
      sexo: json['sexo'] as String,
      fechaNacimiento: DateTime.parse(json['fechaNacimiento'] as String),
      fechaInicioLabores:
          DateTime.parse(json['fechaInicioLabores'] as String), jornada: json['jornada'] as String,
      empresa: json['empresa'] as String,
      idProyectoActual: json['idProyectoActual'] as String,
      isChecked: json['isChecked'] as bool
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'documentoIdentificacion': documentoIdentificacion,
      'nombres': nombres,
      'apellidos': apellidos,
      'nacionalidad': nacionalidad,
      'rol': rol,
      'sexo': sexo,
      'jornada': jornada,
      'empresa': empresa,
      'fechaNacimiento': fechaNacimiento.toIso8601String(),
      'fechaInicioLabores': fechaInicioLabores.toIso8601String(),
      'idProyectoActual': idProyectoActual,
      'isChecked' : isChecked,
    };
  }
}
