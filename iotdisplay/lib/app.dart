import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models.dart';
import 'view_model.dart';

class HydroIOT extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyViewModel(),
      child: MaterialApp(
        home: ScrollPage(),
      ),
    );
  }
}

class ScrollPage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ScrollPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<MyViewModel>(context, listen: false).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lecturas del Sensor'),
      ),
      body: Consumer<MyViewModel>(
        builder: (context, viewModel, child) {
          return NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                viewModel.fetchData();
              }
              return true;
            },
            child: ListView.builder(
              itemCount: viewModel.sensorRegisters.length + 1,
              itemBuilder: (context, index) {
                if (index < viewModel.sensorRegisters.length) {
                  SensorRegister sensorRegister = viewModel.sensorRegisters[index];
                  return ListTile(
                    title: Text('Registro ID: ${sensorRegister.registroId}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Fecha y Hora: ${sensorRegister.fechayHora}'),
                        Text('Medida: ${sensorRegister.medida}'),
                        Text('Comentario: ${sensorRegister.comentario}'),
                      ],
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}