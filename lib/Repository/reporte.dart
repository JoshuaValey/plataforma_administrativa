
import 'package:plataforma_administrativa/Repository/insumo_fijo.dart';
import 'package:plataforma_administrativa/Repository/insumo_variable.dart';
import 'package:plataforma_administrativa/Repository/operario.dart';

class Reporte {
  String? id;
  DateTime fechaReporte;
  String inspectorId;
  String proyectoId;
  String? empresa;
  String? urlImg;
  String? ubicacion;
  List<OperarioReporte>? operarios;
  List<InsumoFijoReporte>? insumosFijos;
  List<InsumoVariableReporte>? insumosVariables;

  Reporte({
    this.id,
    required this.fechaReporte,
    required this.inspectorId,
    required this.proyectoId,
    this.empresa,
    this.urlImg,
    this.ubicacion,
    this.operarios,
    this.insumosFijos,
    this.insumosVariables,
  });

  factory Reporte.fromJson(Map<String, dynamic> json) {
    return Reporte(
      id: json['id'],
      fechaReporte: DateTime.parse(json['fecha_reporte']),
      inspectorId: json['inspectorId'],
      proyectoId: json['proyectoId'],
      empresa: json['empresa'],
      urlImg: json['url_img'],
      ubicacion: json['ubicacion'],
      operarios: (json['operarios'] as List)
          .map((i) => OperarioReporte.fromJson(i))
          .toList(),
      insumosFijos: (json['insumos_fijos'] as List)
          .map((i) => InsumoFijoReporte.fromJson(i))
          .toList(),
      insumosVariables: (json['insumos_variables'] as List)
          .map((i) => InsumoVariableReporte.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fecha_reporte': fechaReporte.toIso8601String(),
      'inspectorId': inspectorId,
      'proyectoId': proyectoId,
      'empresa': empresa,
      'url_img': urlImg,
      'ubicacion': ubicacion,
      'operarios': operarios?.map((i) => i.toJson()).toList() ?? [],
      'insumos_fijos': insumosFijos?.map((i) => i.toJson()).toList() ?? [],
      'insumos_variables': insumosVariables?.map((i) => i.toJson()).toList() ?? [],
    };
  }
}

class OperarioReporte {
  String dpi;
  String nombres;
  String apellidos;
  String rol;
  bool? checked;

  OperarioReporte({
    required this.dpi,
    required this.nombres,
    required this.apellidos,
    required this.rol,
     this.checked,
  });

OperarioReporte.fromOperario(Operario operario)
      : dpi = operario.documentoIdentificacion,
        nombres = operario.nombres,
        apellidos = operario.apellidos,
        rol = operario.rol,
        checked = operario.isChecked;


  factory OperarioReporte.fromJson(Map<String, dynamic> json) {
    return OperarioReporte(
      dpi: json['dpi'],
      nombres: json['nombres'],
      apellidos: json['apellidos'],
      rol: json['rol'],
      checked: json['checked'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dpi': dpi,
      'nombres': nombres,
      'apellidos': apellidos,
      'rol': rol,
      'checked': checked,
    };
  }
}

class InsumoFijoReporte {
  String insumo;
  String? marca;
  String? placa;
  bool? checked;

  InsumoFijoReporte({
    required this.insumo,
    required this.marca,
    required this.placa,
    required this.checked,
  });


  InsumoFijoReporte.fromInsumoFijo(InsumoFijo insumo)
      : insumo = insumo.nombre,
        marca = insumo.modelo,
        placa = insumo.numero,
        checked = insumo.checked;

  factory InsumoFijoReporte.fromJson(Map<String, dynamic> json) {
    return InsumoFijoReporte(
      insumo: json['insumo'],
      marca: json['marca'],
      placa: json['placa'],
      checked: json['checked'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'insumo': insumo,
      'marca': marca,
      'placa': placa,
      'checked': checked,
    };
  }
}

class InsumoVariableReporte {
  String insumo;
  String cantidad;
  bool? checked;

  InsumoVariableReporte({
    required this.insumo,
    required this.cantidad,
    required this.checked,
  });

  InsumoVariableReporte.fromInsumoVariable(InsumoVariable insumo)
      : insumo = insumo.nombre,
        cantidad = insumo.cantidad.toString(),
        checked = insumo.checked;

  factory InsumoVariableReporte.fromJson(Map<String, dynamic> json) {
    return InsumoVariableReporte(
      insumo: json['insumo'],
      cantidad: json['cantidad'],
      checked: json['checked'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'insumo': insumo,
      'cantidad': cantidad,
      'checked': checked,
    };
  }
}

class ReporteFiltro {
  DateTime? fechaReporte;
  String? proyectoId;
  String? inspectorId;

  ReporteFiltro({
    this.fechaReporte,
    this.proyectoId,
    this.inspectorId,
  });

  

  factory ReporteFiltro.fromJson(Map<String, dynamic> json) {
    return ReporteFiltro(
      fechaReporte: DateTime.parse(json['fecha_reporte']),
      proyectoId: json['proyectoId'],
      inspectorId: json['inspectorId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fecha_reporte': fechaReporte?.toIso8601String(),
      'proyectoId': proyectoId,
      'inspectorId': inspectorId,
    };
  }
}