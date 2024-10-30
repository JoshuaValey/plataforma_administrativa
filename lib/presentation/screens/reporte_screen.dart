import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plataforma_administrativa/Repository/proyecto.dart';
import 'package:plataforma_administrativa/Repository/reporte.dart';
import 'package:plataforma_administrativa/api_service.dart';
import 'package:plataforma_administrativa/singleton.dart';

class ReporteScreen extends StatefulWidget {
  const ReporteScreen({super.key});
  @override
  State<ReporteScreen> createState() => _ReporteScreenState();
}

class _ReporteScreenState extends State<ReporteScreen> {
  ApiService service = ApiService(url: Singleton.linkApiService);
  ReporteFiltro reporteFiltro = ReporteFiltro();

  Future<List<Reporte>>? _futureReportesFull;

  Future<void> _ferchReportesFiltrados(ReporteFiltro data) async {
    // Aquí puedes hacer la lógica para filtrar los reportes
    setState((){
      _futureReportesFull = service.getReporteFiltrado(data);
    });
  }

  @override
  void initState() {
    super.initState();
    _futureReportesFull = service.getReportesCompletos();
  }


  Future<String?> _showDateFilterDialog() async {
    DateTime? selectedDate;
    String? formattedDate;

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Seleccionar Fecha'),
          content: TextField(
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null) {
                selectedDate = pickedDate;
                formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                // Actualiza el estado del diálogo para mostrar la fecha seleccionada
                (context as Element).markNeedsBuild();
              }
            },
            decoration: InputDecoration(
              hintText: formattedDate ?? "Seleccione una fecha",
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Aplicar'),
              onPressed: () {
                Navigator.of(context).pop(formattedDate);
              },
            ),
          ],
        );
      },
    );
  }

  Future<String?> _showProyectosFilterDialog() async {
    String? selectedProjectId;
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Seleccionar Proyecto'),
          content: SizedBox(
            width: double.maxFinite,
            child: FutureBuilder<List<Proyecto>>(
              future: service.getDocuments("/proyecto/listadocompleto"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text('No hay proyectos disponibles'));
                } else {
                  final proyectos = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: proyectos.length,
                    itemBuilder: (BuildContext context, int index) {
                      final proyecto = proyectos[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListTile(
                          title: Text(proyecto.name),
                          subtitle: Text(proyecto.descripcion),
                          onTap: () {
                            selectedProjectId = proyecto.id;
                            Navigator.of(context).pop(selectedProjectId);
                          },
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reportes'),
      ),
      body: Center(
        child: FutureBuilder<List<Reporte>>(
          future: _futureReportesFull,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No hay proyectos disponibles.');
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                        title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(snapshot.data?[index].empresa.toString() ?? ''),
                        Text(DateFormat('yyy-MM-dd')
                            .format(snapshot.data![index].fechaReporte)),
                      ],
                    )),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 'Proyecto',
            onPressed: () async {
              String? result = await _showProyectosFilterDialog();
              if (result != null) {
                print('Filtro 1: $result');
                // Aquí puedes manejar el valor retornado
              }
            },
            tooltip: 'Filtro 1',
            child: const Icon(Icons.filter_list),
          ),
          const SizedBox(height: 20),
          FloatingActionButton(
            heroTag: 'Fecha',
            onPressed: () async {
              String? result = await _showDateFilterDialog();
              if (result != null) {
                print('Filtro 2: $result');
                // Aquí puedes manejar el valor retornado
              }
            },
            tooltip: 'Filtro 2',
            child: const Icon(Icons.date_range_rounded),
          ),
        ],
      ),
    );
  }
}
