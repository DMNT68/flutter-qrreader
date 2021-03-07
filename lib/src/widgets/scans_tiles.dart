import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrreaderapp/src/providers/scan_list_provider.dart';
import 'package:qrreaderapp/src/utils/utils.dart';

class ScansTiles extends StatelessWidget {

  final String tipo;

  const ScansTiles({@required this.tipo});


  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScansListProvider>(context);
    final scans = scanListProvider.scans;

    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_, i) => Dismissible(
        key: UniqueKey(),
        background: Container(color: Colors.red),
        onDismissed: (DismissDirection direccion) =>
            Provider.of<ScansListProvider>(context, listen: false)
                .borrarPorId(scans[i].id),
        child: ListTile(
          onTap: () {
            launchURL(context, scans[i]);
          },
          leading: Icon(
            this.tipo == 'http' 
              ? Icons.home_outlined
              : Icons.map_outlined, 
            color: Theme.of(context).primaryColor
          ),
          title: Text(scans[i].valor),
          subtitle: Text('ID:${scans[i].id}'),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}