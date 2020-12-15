import 'package:flutter/material.dart';
import 'package:proyectoseguraap/src/bloc/provider.dart';
import 'package:proyectoseguraap/src/pages/login_page.dart';
import 'package:proyectoseguraap/src/pages/lugares_registro_page.dart';
import 'package:proyectoseguraap/src/pages/mapa_page.dart';
import 'package:proyectoseguraap/src/pages/preferencia_usuarios_page.dart';
import 'package:proyectoseguraap/src/pages/registro_page.dart';
import 'package:proyectoseguraap/src/pages/vista_lugares_peligrosos_page.dart';
import 'package:proyectoseguraap/src/preferencias_usuario/preferencias_usuario.dart';
 
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
    await prefs.initPrefs();
  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final prefs = new PreferenciasUsuario();
    print(prefs.token);

    return Provider(
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'login',
      routes: {
        'login'          : ( _ ) => LoginPage(),
        'mapa'           : ( _ ) => MapaPage(),
        'registro'       : ( _ ) => RegistroPage(),
        'registroLugares': ( _ ) => LugaresRegistroPage(),
        'vistaLugares'   : ( _ ) => VistaLugaresPage(),
        'preferencias'   : ( _ ) => SettingsPage(),
      },
      theme: ThemeData(
        primaryColor: Colors.redAccent
      ),
    )
    );
    
  }
}