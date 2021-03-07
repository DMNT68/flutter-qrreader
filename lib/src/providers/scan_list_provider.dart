import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';
import 'package:qrreaderapp/src/providers/db_provider.dart';

class ScansListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipoSeleccionado = 'http';

   Future<ScanModel> nuevoScan( String valor ) async {

    final nuevoScan = new ScanModel(valor: valor);
    final id = await DBProvider.db.nuevoScan(nuevoScan);
    // Asignar el ID de la base de datos al modelo
    nuevoScan.id = id;

    if ( this.tipoSeleccionado == nuevoScan.tipo ) {
      this.scans.add(nuevoScan);
      notifyListeners();
    }

    return nuevoScan;
  }

  cargarScans() async {
    final scans = await DBProvider.db.getTodosScans();
    this.scans = [...scans];
    notifyListeners();
  }

  cargarScanPorTipo(String tipo) async {
    final scans = await DBProvider.db.getTodosScansPorTipo(tipo);
    this.scans = [...scans];
    notifyListeners();
  }

  borrarTodos() async {
    await DBProvider.db.deleteAll();
    this.scans = [];
    notifyListeners();
  }

  borrarPorId(int id) async {
    await DBProvider.db.deleteAll();
    this.cargarScanPorTipo(tipoSeleccionado);
  }
}
