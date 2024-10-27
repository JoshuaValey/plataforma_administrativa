import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plataforma_administrativa/Repository/insumo_variable.dart';
import 'package:plataforma_administrativa/Repository/proyecto.dart';
import 'package:plataforma_administrativa/api_service.dart';
import 'package:plataforma_administrativa/singleton.dart';

class EditarInsumoVariableScreen extends StatefulWidget {
  const EditarInsumoVariableScreen({super.key});

  @override
  State<EditarInsumoVariableScreen> createState() => _EditarInsumoVariableScreen();
}

class _EditarInsumoVariableScreen extends State<EditarInsumoVariableScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controladores para los campos del formulario
  final _nombreController = TextEditingController();
  final _cantidadController = TextEditingController();

  final bool _checked = false; // Campo booleano para "checked"

  // Instancia de api service
  ApiService apiService = ApiService(url: Singleton.linkApiService);

  @override
  Widget build(BuildContext context) {
    InsumoVariable  insumoVariable =  ModalRoute.of(context)!.settings.arguments as InsumoVariable;
    _nombreController.text = insumoVariable.nombre;
    _cantidadController.text = insumoVariable.cantidad.toString();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Insumo Variable'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              // Campo de Nombre
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre del Insumo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre del insumo';
                  }
                  return null;
                },
              ),
              // Campo de Cantidad
              TextFormField(
                controller: _cantidadController,
                decoration: const InputDecoration(labelText: 'Cantidad'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la cantidad';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor ingrese un número válido';
                  }
                  return null;
                },
              ),
              // Checkbox para "checked"
             
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Crear un nuevo insumo variable con los datos del formulario
                    InsumoVariable insumoEditado = InsumoVariable(
                      id: insumoVariable.id,
                      idProyecto: insumoVariable.idProyecto,
                      nombre: _nombreController.text,
                      cantidad: int.parse(_cantidadController.text),
                      checked: insumoVariable.checked,
                    );
                    // API 
                    var response = apiService.updateDocument(jsonEncode(insumoEditado.toJson()), '/insumovariable/editar');
                    print('Insumo editado: ${insumoEditado.nombre}');
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
    // Limpiar los controladores cuando el widget se destruye
    _nombreController.dispose();
    _cantidadController.dispose();
    super.dispose();
  }
}