import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


import 'package:qrreaderapp/src/models/scan_model.dart';

class MapaPage extends StatefulWidget {

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {

  // final MapController map = new MapController();
  String tipoMapa = 'streets-v11';
  Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context).settings.arguments;
    final CameraPosition puntoInicial = CameraPosition(
      target: scan.getLatLng(),
      zoom: 17.5,
      tilt: 50
    );

    // Marcadores
    Set<Marker> markers = new Set<Marker>();
    markers.add(new Marker(
      markerId: MarkerId('geo-location'),
      position: scan.getLatLng()
    ));

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: [
          IconButton(icon: Icon(
            Icons.my_location), 
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: scan.getLatLng(),
                  zoom: 17.5,
                  tilt: 50
                )
              ));
              // map.move(scan.getLatLng(), 15);
            }
          )
        ],
      ),
      body:GoogleMap(
        mapType: mapType,
        markers: markers,
        initialCameraPosition: puntoInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ), 
      // _crearFlutterMap(scan),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.layers),
        onPressed: () {
          setState(() {
            if (mapType == MapType.normal) {
              mapType = MapType.satellite;
            } else {
              mapType = MapType.normal;
            }            
          });
        },
      ) 
      // _crearBotonFlotante(context, scan),
    );
  }

  Widget _crearBotonFlotante(BuildContext context, ScanModel scan) {

    return FloatingActionButton(
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: (){
        //  streets-v11 outdoors-v11 light-v10 dark-v10 satellite-v9 satellite-streets-v11
        print(tipoMapa);
        if (tipoMapa == 'streets-v11') {
          tipoMapa = 'outdoors-v11';
        } else if (tipoMapa == 'outdoors-v11') {
          tipoMapa = 'light-v10';
        } else if (tipoMapa == 'light-v10') {
          tipoMapa = 'dark-v10';
        } else if (tipoMapa == 'dark-v10') {
          tipoMapa = 'satellite-v9';
        } else if (tipoMapa == 'satellite-v9') {
          tipoMapa = 'satellite-streets-v11';
        } else {
          tipoMapa = 'streets-v11';
        }

        setState(() {});
        //movimiento #1 al maximo de zoom
        // map.move(scan.getLatLng(), 30);
 
        //Regreso al Zoom Deseado después de unos Milisegundos
        Future.delayed(Duration(milliseconds: 50),(){
          // map.move(scan.getLatLng(), 15);
        });

      }   
    );

  }

  Widget _crearFlutterMap(ScanModel scan) {

    // return FlutterMap(
    //   mapController: map,
    //   options: MapOptions(
    //     // center: scan.getLatLng(),
    //     zoom: 15
    //   ),
    //   layers: [
    //     _crearMapa(),
    //     // _crearMarcadores(scan)
    //   ],
    // );

  }

  _crearMapa() {

    // return TileLayerOptions(
    //   urlTemplate:'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
    //   additionalOptions: {
    //     'accessToken':'pk.eyJ1IjoiYW5kcmVzc2FsZ2Fkb2MxIiwiYSI6ImNrZTNvZTFicDBreGQycW54ZTk2cmhmemcifQ.IL231VsEIDskxoPOn3SmhQ',
    //     'id': 'mapbox/$tipoMapa'
    //   }
    // );

  }

  // _crearMarcadores(ScanModel scan) {

  //   return MarkerLayerOptions(
  //     markers: <Marker> [
  //       Marker(
  //         width: 100.0,
  //         height: 100.0,
  //         point: scan.getLatLng(),
  //         builder: (BuildContext context) => Container(
  //           child: Icon(
  //             Icons.location_on, 
  //             size: 45.0,
  //             color: Theme.of(context).primaryColor
  //           ),
  //         )
  //       )
  //     ]
  //   );

  // }
}