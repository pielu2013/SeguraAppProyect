import 'package:flutter/material.dart';
import 'package:proyectoseguraap/src/models/coordenadas_model.dart';
import 'package:proyectoseguraap/src/providers/marcadores_provider.dart';
import 'package:proyectoseguraap/src/utils/utils.dart' as utils;

class LugaresRegistroPage extends StatefulWidget {

  @override
  _LugaresRegistroPageState createState() => _LugaresRegistroPageState();
}

class _LugaresRegistroPageState extends State<LugaresRegistroPage> {
  final formKey = GlobalKey<FormState>();
  final scafoldkey = GlobalKey<ScaffoldState>();
  final marcadoresProvider = new MarcadoresProvider();

  CoordenadasModel marcador = new  CoordenadasModel();
  bool _guardando = false;
  
   @override
  Widget build(BuildContext context) {

    final CoordenadasModel prodData = ModalRoute.of(context).settings.arguments;
    if( prodData != null ){
      marcador = prodData;
    }
    return Scaffold(
      key: scafoldkey,
      appBar: AppBar(
        title: Text('Registrar Lugares'),
        actions: [
          // Icon(Icons)
        ],
        
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _crearDireccion(),
                _lat(),
                _long(),
                _crearBoton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearDireccion() {
    return TextFormField(
      initialValue: marcador.direccin,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Dirección'
      ),
      onSaved: (value) => marcador.direccin = value,
      validator: (value) {
        if ( value.length <3 ){
          return 'Ingrese la dirección';
        }else{
          return null;
        }
      },
    );
  }

  Widget _lat() {
    return TextFormField(
      initialValue: marcador.latitud.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Latitud'
      ),
      onSaved: (value) => marcador.latitud = double.parse(value),
      validator: ( value ) {
        if ( utils.isNumeric(value) ){
          return null;
        }else{
          return 'sólo números';
        }
      },
    );
  }

  Widget _long() {
    return TextFormField(
      initialValue: marcador.longitud.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Longitud'
      ),
      onSaved: (value) => marcador.longitud = double.parse(value),
      validator: ( value ) {
        if ( utils.isNumeric(value) ){
          return null;
        }else{
          return 'sólo números';
        }
      },
    );
  }

  Widget _crearBoton() {
    return RaisedButton.icon(
      icon: Icon(Icons.save), 
      label: Text('Salvar'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      color: Colors.redAccent,
      textColor: Colors.white,
      onPressed: ( _guardando )? null : _submit
    );
  }

  void _submit(){

    if(!formKey.currentState.validate()) return;

    formKey.currentState.save();

    
    setState(() {
      _guardando = true; 
    });

    if( marcador.id == null ){
      marcadoresProvider.crearMarcador(marcador);
    }else{
      marcadoresProvider.editarMarcador(marcador);
    }

    mostrarSnackbar('Registro Guardado');

    Navigator.pop(context);

  }

  void mostrarSnackbar(String mensaje){
    final snackbar =SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );

    scafoldkey.currentState.showSnackBar(snackbar);

  } 


}