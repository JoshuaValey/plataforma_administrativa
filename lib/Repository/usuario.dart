class Usuario {
  final String? id;
  final String nombreUsuario;
  final String contrasenia;
  final String rol;
 

  Usuario(
      { this.id,
      required this.nombreUsuario,
      required this.contrasenia,
      required this.rol,
      });

// vuelve ha crear el meetodo fromjson
  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'] as String,
      nombreUsuario: json['nombre_Usuario'] as String,
      contrasenia: json['contrasenia'] as String,
      rol: json['rol'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre_Usuario': nombreUsuario,
      'contrasenia': contrasenia,
      'rol': rol,
    };
  }
}