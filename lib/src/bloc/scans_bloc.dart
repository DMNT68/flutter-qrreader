import 'dart:async';

import 'package:qrreaderapp/src/bloc/validator.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';
import 'package:qrreaderapp/src/providers/db_provider.dart';

class ScansBloc with Validator {

  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc() {
    return _singleton;
  }

  ScansBloc._internal() {
    obtenerScans();
  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream <List<ScanModel>> get scansStream => _scansController.stream.transform(validarGeo);
  Stream <List<ScanModel>> get scansStreamHttp => _scansController.stream.transform(validarHttp);

  dispose() {
    _scansController?.close();
  }

  obtenerScans() async {
    _scansController.sink.add(await DBProvider.db.getTodosScans());
  }
  
  agregarScan(ScanModel scan) async {
    await DBProvider.db.nuevoScan(scan);
    obtenerScans();
  }


  borrarScans(int id) async {
    await DBProvider.db.deleteScan(id);
    obtenerScans();
  }

  borrarScansTODO() async {
    await DBProvider.db.deleteAll();
    obtenerScans();
  }

}