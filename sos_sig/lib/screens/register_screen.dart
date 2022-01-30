// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sos_sig/providers/providers.dart';
import 'package:sos_sig/services/services.dart';
import 'package:sos_sig/ui/ui.dart';
import 'package:sos_sig/widgets/widgets.dart';


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackground(
            child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 50),
          CardContainer(
            child: Column(
              children: [
                SizedBox(height: 10),
                Text('Crear Cuenta',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 20.0,
                      decorationStyle: TextDecorationStyle.wavy,
                    )),
                SizedBox(height: 30),
                ChangeNotifierProvider(
                  create: (_) => RegisterFormProvider(), 
                  child: _LoginForm()
                )
              ],
            ),
          ),
          SizedBox(height: 50),
          Text('Ya tienes Una Cuenta?',
              style: TextStyle(fontSize: 18, color: Colors.blueGrey)),
          TextButton(
            child: Text('Iniciar Sesion',
                style:
                    TextStyle(fontSize: 18, color: Colors.blueGrey.shade700)),
            style: ButtonStyle(
                overlayColor:
                    MaterialStateProperty.all(Colors.blueGrey.withOpacity(0.1)),
                shape: MaterialStateProperty.all(StadiumBorder())),
            onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
          ),
          SizedBox(height: 50),
        ],
      ),
    )));
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final registerForm = Provider.of<RegisterFormProvider>(context);
    return Container(
      child: Form(
        key: registerForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              //controller: name,
              style: TextStyle(fontSize: 15.0, color: Colors.blueGrey),
              autocorrect: false,
              keyboardType: TextInputType.name,
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'UAGRM',
                  labelText: 'Nombre Completo',
                  prefixIcon: Icons.person_pin
              ),
              onChanged: ( value ) => registerForm.nombre=value,
              validator: ( value ) {
                  return ( value != null && value.length >= 4 ) 
                    ? null
                    : 'El Nombre debe de ser de 4 caracteres como Minimo';                                          
              },
            ),
            
            SizedBox(height: 30),
            TextFormField(
              //controller: email,
              style: TextStyle(fontSize: 15.0, color: Colors.blueGrey),
              autocorrect: false,
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'uagrm@gmail.com',
                labelText: 'Correo Electronico',
                prefixIcon: Icons.alternate_email_rounded,
              ),
              onChanged: ( value ) => registerForm.email = value,
              validator: ( value ) {
                  String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp  = new RegExp(pattern);
                  return regExp.hasMatch(value ?? '')
                    ? null
                    : 'El valor ingresado no luce como un correo';
              },
            ),
            SizedBox(height: 30),
            TextFormField(
              //controller: password,
              style: TextStyle(fontSize: 15.0, color: Colors.blueGrey),
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecorations.authInputDecoration(
                hintText: '*****',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_outline,
              ),
              onChanged: (value) => registerForm.password = value,
              validator: ( value ) {
                  return ( value != null && value.length >= 6 ) 
                    ? null
                    : 'La Contraseña debe de ser de 6 caracteres como Minimo';                                      
              },
            ),
            SizedBox(height: 30),
            TextFormField(
              //controller: cellphone,
              style: TextStyle(fontSize: 15.0, color: Colors.blueGrey),
              autocorrect: false,
              obscureText: false,
              keyboardType: TextInputType.number,
              decoration: InputDecorations.authInputDecoration(
                hintText: '76627246',
                labelText: 'Celular',
                prefixIcon: Icons.phone_android_rounded,
              ),
              onChanged: (value) => registerForm.celular = value,
              validator: ( value ) {
                  return ( value != null && value.length == 8 ) 
                    ? null
                    : 'Un Numero De Celular consta de 8 Digitos';                                      
              },
            ),
            SizedBox(height: 30),
            
            MaterialButton(
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: Colors.blueGrey,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: Text(
                    registerForm.isLoading 
                    ? 'Espere'
                    : 'Registrarse',
                  style: TextStyle( color: Colors.white ),
                  )
                ),
                onPressed: registerForm.isLoading ? null : () async {
                  FocusScope.of(context).unfocus();
                  final authService = Provider.of<AuthService>(context, listen: false);
                  if(!registerForm.isValidForm()) return;
                  registerForm.isLoading = true;
                  // TODO: validar si el login es correcto
                  final String errorMessage = await authService.createUser(registerForm.email, registerForm.password);
                  
                  if ( errorMessage.contains('null') ) {
                    Navigator.pushReplacementNamed(context, 'login');
                  } else {
                    print( errorMessage );
                    registerForm.isLoading = false;  
                  }
                }
            )
          ],
        ),
      ),
    );
  }
}
