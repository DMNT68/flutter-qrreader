import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrreaderapp/src/providers/scan_list_provider.dart';
import 'package:qrreaderapp/src/utils/utils.dart' as utils;

import 'package:qrreaderapp/src/bloc/scans_bloc.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';
import 'package:qrreaderapp/src/widgets/scans_tiles.dart';

class DireccionesPage extends StatelessWidget {

  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {

    return ScansTiles(tipo: 'http',);
  }
}


// scansBloc.obtenerScans();
// return StreamBuilder<List<ScanModel>> (
//       stream: scansBloc.scansStreamHttp, 
//       builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot){
//         if (!snapshot.hasData) {
//           return Center(child: CircularProgressIndicator());
//         }

//         final scans = snapshot.data;

//         if(scans.length == 0) {
//           return Center(
//             child: Text('No hay información'),
//           );
//         } 

//         return ListView.builder(
//           itemCount: scans.length,
//           itemBuilder: (context, i) => Dismissible(
//             key: UniqueKey(),
//             background: Container(color: Colors.red),
//             onDismissed: (direccion) => scansBloc.borrarScans(scans[i].id),
//             child: ListTile(
//               onTap: (){utils.abrirScan(context, scans[i]);},
//               leading: Icon(Icons.cloud_queue, color:Theme.of(context).primaryColor),
//               title: Text(scans[i].valor),
//               subtitle: Text('ID:${scans[i].id}'),
//               trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey,),
//             ),
//           ),
//         );
//       },
//     );