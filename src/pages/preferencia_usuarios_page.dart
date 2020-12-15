import 'package:flutter/material.dart';
import 'package:proyectoseguraap/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  bool _colorSecundario;
  int _genero;
  String _nombre = 'usuario';

  TextEditingController _textController;

  final prefs = new PreferenciasUsuario();

  @override
  void initState() {
    super.initState();

    // _genero = prefs.genero;
  //   _colorSecundario = prefs.colorSecundario;

    _textController = new TextEditingController( text: _nombre );
    // _textController = new TextEditingController( text: prefs.nombreUsuario );
  }
  

  _setSelectedRadio( int valor ) {
    // 
    // prefs.genero = valor;
    _genero = valor;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preferencias'),
        // backgroundColor: (prefs.colorSecundario) ? Colors.teal : Colors.blue,
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(5.0),
            child: Text('Settings', style: TextStyle( fontSize: 45.0, fontWeight: FontWeight.bold ),),
          ),

          Divider(),

          SwitchListTile(
            // value: _colorSecundario,
            value: true,
            title: Text('Color secundario'),
            onChanged: ( value ){ 
              setState(() {
              _colorSecundario = value;
              // prefs.colorSecundario = value;
              });

            },
          ),

          RadioListTile(
            value: 1,
            title: Text('Masculino'),
            groupValue: _genero,
            // groupValue: 1,
            onChanged: _setSelectedRadio,
          ),
          
          RadioListTile(
            value: 2,
            title: Text('Femenino'),
            groupValue: _genero,
            // groupValue:2,
            onChanged: _setSelectedRadio
          ),

          Divider(),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                helperText: 'Nombre de la persona usando el teléfono',
              ),
              onChanged: (value){
                // prefs.nombreUsuario = value;
              },
            ),
          )
          


        ],
      )
    );
  }
}