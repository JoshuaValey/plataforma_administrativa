
class InsumoVariable {
  final String ? id;
  final String ? idProyecto;
  final String nombre;
  final int cantidad;
  bool? checked;

  InsumoVariable({
    this.id,
    required this.idProyecto,
    required this.nombre,
    required this.cantidad,
    this.checked = false,
  });

  // Método para crear una instancia de la clase a partir de un JSON
  factory InsumoVariable.fromJson(Map<String, dynamic> json) {
    return InsumoVariable(
      id: json['Id'] as String,
      idProyecto: json['IdProyecto'] as String,
      nombre: json['Nombre'] as String,
      cantidad: json['Cantidad'] as int,
      checked: json['Checked'] as bool,

    );
  }

  // Método para convertir la instancia de la clase a JSON
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'IdProyecto': idProyecto,
      'Nombre': nombre,
      'Cantidad': cantidad,
    };
  }
}