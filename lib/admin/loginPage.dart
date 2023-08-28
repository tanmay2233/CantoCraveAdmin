// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, sort_child_properties_last, non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Theme/themes.dart';
import '../auth.dart';
import '../routes/routes.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> sigInWithEmailAndPassword() async {
    try {
      await Auth().sigInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _entryField(
      String hintText, TextEditingController controller, bool obscure) {
    return TextField(
      obscureText: obscure,
      style: TextStyle(color: Color.fromARGB(255, 172, 102, 75)),
      decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Vx.yellow500),
          ),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Vx.yellow500)),
          hintText: hintText,
          hintStyle: TextStyle(color: Color.fromARGB(255, 172, 102, 75))),
      controller: controller,
    );
  }

  Widget _errorMessage() {
    return Text(
      errorMessage == '' ? '' : '$errorMessage',
      style: TextStyle(color: MyTheme.fontColor),
    );
  }

  Widget _submitButton() {
    return ElevatedButton(
        onPressed: isLogin
            ? sigInWithEmailAndPassword
            : createUserWithEmailAndPassword,
        child: Text(isLogin ? 'Login' : 'Register'));
  }

  Widget _title() {
    return Text(isLogin ? 'Login' : 'Register');
  }

  // Widget _loginOrRegisterButton() {
  //   return TextButton(
  //       onPressed: () {
  //         setState(() {
  //           isLogin = !isLogin;
  //         });
  //       },
  //       child: Text(isLogin ? 'New User?..Register Here' : 'Login Instead',
  //           style: TextStyle(color: Color.fromARGB(255, 190, 85, 44))));
  // }

  Widget _LoginButton() {
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 214, 193, 6),
            Color.fromARGB(255, 190, 85, 44)
          ])),
      child: ElevatedButton(
        onPressed: () async {
          isLogin
              ? await sigInWithEmailAndPassword()
              : await createUserWithEmailAndPassword();
          if (errorMessage == '') {
            if(_emailController.text.trim() == 'tanmaykamleshjain@gmail.com'){
              Navigator.pushReplacementNamed(context, MyRoutes.adminPageRoute);
            }
            else{
              errorMessage = "You aren't an Admin";
            }
          }
        },
        child: Text(isLogin ? 'Login' : 'Register',
            style: TextStyle(
              color: Color.fromARGB(255, 240, 216, 166),
              fontWeight: FontWeight.bold,
            )),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false, // to avoid image to squeezing of image
    
        body: Material(
          child: Theme(
            data: MyLoginPageTheme.loginPageTheme(context),
            child: SafeArea(
              bottom: false,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                      MyTheme.canvasLightColor,
                      MyTheme.canvasDarkColor
                    ])),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.21,
                          vertical: MediaQuery.of(context).size.height * 0.15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Email",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 240, 203, 57)),
                            ),
                          ),
                          _entryField("Enter Email", _emailController, false),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.036),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Password",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 240, 203, 57)),
                            ),
                          ),
                          _entryField(
                              "Enter Password", _passwordController, true),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.036),
                          _LoginButton(),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.07,
                          ),
                          _errorMessage(),
                          // _loginOrRegisterButton(),
                          Image.asset("images/logo.png", height: size.height*0.15,)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
