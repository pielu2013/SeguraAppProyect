import 'dart:async';

import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:proyectoseguraap/src/preferencias_usuario/preferencias_usuario.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}
class _MapaPageState extends State<MapaPage> {

  final Completer<GoogleMapController> _controller = Completer();

  MapType mapType = MapType.normal;
 
  Location _location = Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  // ignore: unused_field
  LocationData _locationData;
  var sitios=[];
  bool sitiosToogle = false;

  @override
  void initState() {
    super.initState();

    sitiosToogle = true;

    _initLocation();

  }

  _initLocation() async{
        _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    
    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
      _locationData = await _location.getLocation();
    }

    _location.onLocationChanged.listen((LocationData event) async{
      GoogleMapController controller = await _controller.future;
      if(_controller != null){
        // GoogleMapController controller;
        controller.animateCamera(
          CameraUpdate.newLatLng(LatLng(event.latitude, event.longitude))
        );         
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    final CameraPosition puntoInicial = CameraPosition(
    target: LatLng(-13.1606, -74.2258),
    zoom: 16,
    tilt: 50
  );
  
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
      ),
      drawer: _crearMenu(),
      body: GoogleMap(
        zoomControlsEnabled: false,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        mapType: mapType,
        markers: crearMarkers(),
        initialCameraPosition: puntoInicial,
        onMapCreated: (GoogleMapController controller) => _controller.complete(controller),  
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.layers),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: (){
      
           if ( mapType == MapType.normal){
           mapType = MapType.satellite;
          }else{
            mapType = MapType.normal;
          }
          setState(() {});
        },
      ),
    );
  }

  Set<Marker> crearMarkers() {
    Set<Marker> markers = new Set<Marker>();
    markers.add(Marker(markerId: MarkerId('plaza'), position: LatLng(-13.1606, -74.2258), infoWindow: InfoWindow(title: 'Plaza Mayor')));
    markers.add(Marker(markerId: MarkerId('san_juan'), position: LatLng(-13.1803473,-74.2042528), infoWindow: InfoWindow(title: 'Himalaya con Girasoles - San Juan')));
    markers.add(Marker(markerId: MarkerId('nazarenas'), position: LatLng(-13.1544,-74.2115), infoWindow: InfoWindow(title: 'Jr. Ciro Alegría 1050 - Nazarenas')));
    markers.add(Marker(markerId: MarkerId('covadonga'), position: LatLng(-13.1381, -74.2251), infoWindow: InfoWindow(title: 'Covadonga - Ayacucho')));
    markers.add(Marker(markerId: MarkerId('yanmilla'), position: LatLng(-13.1480, -74.2005), infoWindow: InfoWindow(title: 'Av. Anckoteka - Andres Avelino Cáceres')));
    markers.add(Marker(markerId: MarkerId('yanama'), position: LatLng(-13.1770, -74.1968), infoWindow: InfoWindow(title: 'Av. Venezuela 694 - Santa Elena')));
    return markers;
  }
  Widget _crearMenu() {
    final prefs = new PreferenciasUsuario();
    return Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Segura App', style:TextStyle(fontSize: 30.0)),
              accountEmail: Text('Municipalidad Provinvial de Huamanga'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
              ),
            ),
            ListTile(
              title: Text('Visualizar lugares peligrosos'),
              leading: Icon(Icons.remove_red_eye, color: Theme.of(context).primaryColor,),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.pushNamed(context, 'vistaLugares');
              },
              
            ),
            ListTile(
              title: Text('Registrar Lugar Peligroso'),
              leading: Icon(Icons.add_location_alt, color: Theme.of(context).primaryColor,),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.pushNamed(context, 'registroLugares');
              },              
            ),
            ListTile(
              title: Text('Preferencias de usuario'),
              leading: Icon(Icons.settings, color: Theme.of(context).primaryColor,),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.pushNamed(context, 'preferencias');
              },
            ),
            ListTile(
              title: Text('Cerrar Sesión'),
              leading: Icon(Icons.logout, color: Theme.of(context).primaryColor,),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.pushNamed(context, 'login');
              },
            )   
          ],
        )
      );
  }

  
}