import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plataforma_administrativa/Repository/proyecto.dart';
import 'package:plataforma_administrativa/api_service.dart';
import 'package:plataforma_administrativa/singleton.dart';

class EditarProyectoScreen extends StatefulWidget {
  const EditarProyectoScreen({super.key});

  @override
  State<EditarProyectoScreen> createState() => _EditarProyectoScreenState();
}

class _EditarProyectoScreenState extends State<EditarProyectoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _areaCoberturaController = TextEditingController();
  final _empresaController = TextEditingController();
  final _fechaInicioController = TextEditingController();
  final _fechaFinController = TextEditingController();
  final _jornadaController = TextEditingController();

  DateTime? _fechaInicio;
  DateTime? _fechaFin;

  


  // Nueva variable para almacenar el estado del checkbox
  bool _vigente = false;

  

  @override
  Widget build(BuildContext context) {
  
  ApiService apiService = ApiService(url: Singleton.linkApiService);
  Proyecto proyectoViejo = ModalRoute.of(context)!.settings.arguments as Proyecto;
  _nameController.text = proyectoViejo.name;
  _descripcionController.text = proyectoViejo.descripcion;
  _areaCoberturaController.text = proyectoViejo.areaCobertura;
  _empresaController.text = proyectoViejo.empresa;
  setState(() {
    _fechaInicioController.text = proyectoViejo.fechaInicio.toString().replaceAll('Z', '');
    _fechaInicio = DateTime.parse(proyectoViejo.fechaInicio.toString().replaceAll('Z', ''));
  });
  setState(() {
    _fechaFinController.text = proyectoViejo.fechaFin.toString().replaceAll('Z', '');
    _fechaFin = DateTime.parse(proyectoViejo.fechaFin.toString().replaceAll('Z', ''));
  });
  //_fechaFinController.text = proyectoViejo.fechaFin.toString().replaceAll('Z', '');
  _jornadaController.text = proyectoViejo.areaCobertura;



    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Proyecto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descripcionController,
                decoration: const  InputDecoration(labelText: 'Descripción'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la descripción';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _areaCoberturaController,
                decoration: const InputDecoration(labelText: 'Área de Cobertura'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el área de cobertura';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _empresaController,
                decoration: const InputDecoration(labelText: 'Empresa'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la empresa';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _fechaInicioController,
                decoration: const InputDecoration(labelText: 'Fecha de Inicio'),
                readOnly: true,
                onTap: () async {
                  
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _fechaInicio = pickedDate;
                      _fechaInicioController.text = _fechaInicio.toString();
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor seleccione la fecha de inicio';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _fechaFinController,
                decoration: const InputDecoration(labelText: 'Fecha de Fin'),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _fechaFin = pickedDate;
                      _fechaFinController.text = _fechaFin.toString();
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor seleccione la fecha de fin';
                  }
                  return null;
                },
              ),
              // Checkbox para el estado "Vigente"
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Vigente'),
                  Checkbox(
                    value: _vigente,
                    onChanged: (bool? newValue) {
                      setState(() {
                        _vigente = newValue ?? false;
                      });
                    },
                  ),
                ],
              ),
              TextFormField(
                controller: _jornadaController,
                decoration: const InputDecoration(labelText: 'Jornada'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la jornada';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Proyecto proyectoActualizado = Proyecto(
                      id: proyectoViejo.id,
                      name: _nameController.text,
                      descripcion: _descripcionController.text,
                      areaCobertura: _areaCoberturaController.text,
                      empresa: _empresaController.text,
                      fechaInicio: _fechaInicio!,
                      fechaFin: _fechaFin!,
                      vigente: _vigente,  // Usamos el valor del checkbox
                      jornada: _jornadaController.text,
                    );
                    // Aquí implementar API para guardar el nuevo proyecto   
                  var resultado = apiService.updateDocument(jsonEncode(proyectoActualizado.toJson()), '/proyecto/editar');
                  print(resultado);
                  }
                },
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descripcionController.dispose();
    _areaCoberturaController.dispose();
    _empresaController.dispose();
    _fechaInicioController.dispose();
    _fechaFinController.dispose();
    _jornadaController.dispose();
    super.dispose();
  }
}