import 'package:flutter/material.dart';
import 'package:proyectoseguraap/src/bloc/provider.dart';
import 'package:proyectoseguraap/src/providers/usuario_provider.dart';
import 'package:proyectoseguraap/src/utils/utils.dart';

class RegistroPage extends StatelessWidget {

  final usuarioProvider = new UsuarioProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _crearFondo( context ),
          _loginForm( context ),
        ],
      )
    );
  }

  Widget _crearFondo( BuildContext context) {

    final size = MediaQuery.of(context).size;

    final fondo = Container(
      height: size.height*0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Colors.redAccent[100],
            Colors.redAccent,
            Colors.red[400],
            Colors.red
          ]
        )
      ),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.05)
      ),
    );

    return Stack(
      children: [
        fondo,
        Positioned(top: 90.0, left: 30.0, child: circulo),
        Positioned(top: -40.0, right: -30.0, child: circulo),
        Positioned(bottom: -50.0, right: -10.0, child: circulo),
        Positioned(bottom: 120.0, right: 20.0, child: circulo),
        Positioned(bottom: -50.0, left: -20.0, child: circulo),

        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: [
              Icon( Icons.person_pin_circle, color: Colors.white, size: 100.0),
              SizedBox( height: 10.0, width: double.infinity, ), 
              Text('Segura App', style: TextStyle( color: Colors.white, fontSize: 25.0))
            ],
          )
        )

        
        

      ],
    );
  }

  Widget _loginForm(BuildContext context) {

    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    

    return SingleChildScrollView(
      child: Column(
        children: [

          SafeArea(
            child: Container(
              height: 200.0, 
            ),
          ),

          Container(
            width: size.width*0.85,
            padding: EdgeInsets.symmetric(vertical: 50.0),
            margin: EdgeInsets.symmetric(vertical: 30.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow:[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3.0
                )
              ]
            ),
            child: Column(
              children: [
                Text('Resgistrarse', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 60.0,),
                _crearEmail(bloc),
                SizedBox(height: 30.0,),
                _crearPassword(bloc),
                SizedBox(height: 30.0,),
                _crearBoton(bloc)
              ],
            ),
          ),

          FlatButton(
            child: Text('¿Ya tienes cuenta?'),
            onPressed: ()=> Navigator.pushReplacementNamed(context, 'login'),
          ),
          SizedBox(height: 100.0,)
        ],
      ),
    );
  }

  Widget _crearEmail(LoginBloc bloc) {

    return StreamBuilder(
      stream: bloc.emailStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.alternate_email, color: Theme.of(context).primaryColor),
             hintText: 'ejemplo@correo.com',
             labelText: 'Correo electrónico',
             counterText: snapshot.data,
              errorText: snapshot.error
            ),
            onChanged: bloc.changeEmail,
          ),
         );
      },
    );

    
  }

  Widget _crearPassword(LoginBloc bloc) {

    return StreamBuilder(
      stream: bloc.passwordStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){ 

        return Container( 
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock, color: Theme.of(context).primaryColor),
              labelText: 'Contraseña',
              counterText: snapshot.data,
              errorText: snapshot.error
            ),
            onChanged: bloc.changePassword
          ),
        );
      },
    );
  }

  Widget _crearBoton(LoginBloc bloc){

    //formValidStream

    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('Registrar'),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
          ),
          elevation: 0.0,
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          onPressed: snapshot.hasData? ()=> _register(bloc, context): null,
        );
      },
    );
  } 

  _register(LoginBloc bloc, BuildContext context) async{

    final info = await usuarioProvider.nuevoUsuario(bloc.email, bloc.password);

    if ( info['ok'] ){
      Navigator.pushReplacementNamed(context, 'login');
    }else{
      mostarAlerta(context, info['mensaje']);
    }
    // Navigator.pushReplacementNamed(context, 'mapa');

  }
}