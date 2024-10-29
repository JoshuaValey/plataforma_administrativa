class Usuario {
  String id;
  String nombreUsuario;
  String contrasenia;
  String rol;

  Usuario({
    required this.id,
    required this.nombreUsuario,
    required this.contrasenia,
    required this.rol,
  });


  // Método para crear una instancia de Usuario a partir de un JSON
  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['_id'],
      nombreUsuario: json['Usuario'],
      contrasenia: json['Contrasenia'],
      rol: json['Rol'],
    );
  }

  // Método para convertir una instancia de Usuario a un JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'Usuario': nombreUsuario,
      'Contrasenia': contrasenia,
      'Rol': rol,
    };
  }
}