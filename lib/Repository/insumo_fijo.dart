
class InsumoFijo {
  final String? id ;
  final String idProyecto;
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
      id: json['Id'] as String,
      idProyecto: json['Id_Proyecto'] as String,
      codigo: json['Codigo'] as String,
      nombre: json['Nombre'] as String,
      numero: json['Numero'] as String,
      modelo: json['Modelo'] as String,
      capacidad: json['Capacidad'] as String,
      empresa: json['Empresa'] as String,
      estado: json['Estado'] as bool,
    );
  }

  // Método para convertir la instancia de la clase a JSON
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Id_Proyecto': idProyecto,
      'Codigo': codigo,
      'Nombre': nombre,
      'Numero': numero,
      'Modelo': modelo,
      'Capacidad': capacidad,
      'Empresa': empresa,
      'Estado': estado,
      'Checked': checked,

    };
  }
}
