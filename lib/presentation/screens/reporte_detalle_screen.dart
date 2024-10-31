import 'package:flutter/material.dart';
import 'package:plataforma_administrativa/Repository/reporte.dart';
import 'package:intl/intl.dart';

class ReporteDetalleScreen extends StatefulWidget {
  const ReporteDetalleScreen({super.key});

  @override
  State<ReporteDetalleScreen> createState() => _ReporteDetalleScreenState();
}

class _ReporteDetalleScreenState extends State<ReporteDetalleScreen> {
  @override
  Widget build(BuildContext context) {
    final reporte = ModalRoute.of(context)!.settings.arguments as Reporte;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Reporte'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (reporte.urlImg != null)
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      16.0), 
                  child: Image.network(reporte.urlImg!),
                ),
              ),
            const SizedBox(height: 16.0),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fecha del Reporte: ${DateFormat('dd-MM-yyyy').format(reporte.fechaReporte.toLocal())  }',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Inspector ID: ${reporte.inspectorId}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Proyecto ID: ${reporte.proyectoId}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8.0),
                    if (reporte.empresa != null)
                      Text(
                        'Empresa: ${reporte.empresa}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    const SizedBox(height: 8.0),
                    if (reporte.ubicacion != null)
                      Text(
                        'Ubicación: ${reporte.ubicacion}',
                        style: const TextStyle(fontSize: 16),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            if (reporte.operarios != null && reporte.operarios!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Operarios:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ...reporte.operarios!.map(
                    (operario) => Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      elevation: 4.0,
                      child: ListTile(
                        title:
                            Text('${operario.nombres} ${operario.apellidos}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('DPI: ${operario.dpi}'),
                            Text('Rol: ${operario.rol}'),
                            Text('Checked: ${operario.checked.toString()}'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            if (reporte.insumosFijos != null &&
                reporte.insumosFijos!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Insumos Fijos:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ...reporte.insumosFijos!.map(
                    (insumo) => Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      elevation: 4.0,
                      child: ListTile(
                        title: Text(insumo.insumo),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Marca: ${insumo.marca.toString()}'),
                            Text('Placa: ${insumo.placa.toString()}'),
                            Text('Chequeo: ${insumo.checked.toString()}'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            if (reporte.insumosVariables != null &&
                reporte.insumosVariables!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Insumos Variables:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ...reporte.insumosVariables!.map(
                    (insumo) => Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      elevation: 4.0,
                      child: ListTile(
                        title: Text(insumo.insumo),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Cantidad: ${insumo.cantidad.toString()}'),
                            Text('Chequeo: ${insumo.checked.toString()}'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
