import 'package:flutter/material.dart';
import 'package:proyectoseguraap/src/bloc/provider.dart';
import 'package:proyectoseguraap/src/models/coordenadas_model.dart';

import 'package:proyectoseguraap/src/providers/marcadores_provider.dart';

class VistaLugaresPage extends StatefulWidget {

  @override
  _VistaLugaresPageState createState() => _VistaLugaresPageState();
}

class _VistaLugaresPageState extends State<VistaLugaresPage> {
    final marcadoresProvider = new MarcadoresProvider(); 

  @override
  Widget build(BuildContext context) {

    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Lugares Registrados'),
      ),
      body: _crearListado(),
      // floatingActionButton: _crearBoton( context),
    );
  }

  Widget  _crearListado() {
    
    return FutureBuilder(
      future: marcadoresProvider.cargarMarcadores(),
      builder: (BuildContext context, AsyncSnapshot<List<CoordenadasModel>> snapshot){
        if( snapshot.hasData){

          final marcadores = snapshot.data;
          return ListView.builder(
            itemCount: marcadores.length,
            itemBuilder: (context, i) => _crearItem( context, marcadores[i] )
          );
        }else{
          return Center( child: CircularProgressIndicator(),);
        }
      },  
    );

  }

  Widget _crearItem(BuildContext context, CoordenadasModel coordenada){
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.redAccent,
      ),
      onDismissed: (direccion){
        marcadoresProvider.borrarLugar(coordenada.id);
      },
      child: ListTile(
        leading: Icon( Icons.map, color: Theme.of(context).primaryColor,),
        title: Text('${coordenada.direccin}'),
        subtitle: Text('${coordenada.latitud}  ---  ${coordenada.longitud}'),
        onTap: () => Navigator.pushNamed(context, 'registroLugares', arguments: coordenada).then((value){setState((){});}),
        // onTap: () => Navigator.pushNamed(context, 'registroLugares', arguments: coordenada ),
      ),
    );
  }
}