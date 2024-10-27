
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
      id: json['id'] as String,
      idProyecto: json['idProyecto'] as String,
      nombre: json['nombre'] as String,
      cantidad: json['cantidad'] as int,
      checked: json['checked'] as bool,

    );
  }

  // Método para convertir la instancia de la clase a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idProyecto': idProyecto,
      'nombre': nombre,
      'cantidad': cantidad,
      'checked': checked,
    };
  }
}