
class InsumoFijo {
  final String? id ;
  final String? idProyecto;
  final String codigo;
  final String nombre;
  final String? numero;
  final String? modelo;
  final String? capacidad;
  final String empresa;
  final bool estado;
  bool? checked;

  InsumoFijo({
     this.id,
    required this.idProyecto,
    required this.codigo,
    required this.nombre,
    this.numero,
    this.checked = false,
    required this.modelo,
    required this.capacidad,
    required this.empresa,
    required this.estado,
  });

  

  // Método para crear una instancia de la clase a partir de un JSON
  factory InsumoFijo.fromJson(Map<String, dynamic> json) {
    return InsumoFijo(
      id: json['id'] as String,
      idProyecto: json['idProyecto'] as String,
      codigo: json['codigo'] as String,
      nombre: json['nombre'] as String,
      numero: json['numero'] as String,
      modelo: json['modelo'] as String,
      capacidad: json['capacidad'] as String,
      empresa: json['empresa'] as String,
      estado: json['estado'] as bool,
    );
  }

  // Método para convertir la instancia de la clase a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'IdProyecto': idProyecto,
      'codigo': codigo,
      'nombre': nombre,
      'numero': numero,
      'modelo': modelo,
      'capacidad': capacidad,
      'empresa': empresa,
      'estado': estado,
      'checked': checked,

    };
  }
}
