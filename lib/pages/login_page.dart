import 'package:alapu/widgets/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:alapu/pages/regi_page.dart';
import 'package:alapu/utils/color.dart';
import 'package:alapu/widgets/btn_widget.dart';
import 'package:alapu/pages/menu_page.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  var _formKey = GlobalKey<FormState>();
  final _scacffoldKey = GlobalKey<ScaffoldState>();
  var _isLoading = false;

  ///Text Editing Controllers
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scacffoldKey,
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(bottom: 50),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 100,
                    ),

                    //alap logo
                    Container(
                      height: 130,
                      child: Image(image: AssetImage('assets/alap_logo.png')),
                    ),
                    SizedBox(
                      height: 80,
                    ),

                    //Login TextFields
                    Expanded(
                      //flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              _textInput(

                                  hint: "Email/Nombre de Usuario", icon: Icons.email,controller: emailController),
                              SizedBox(
                                height: 10,
                              ),
                              _passwordInput(hint: "Contrasena", icon: Icons.vpn_key,controller: passwordController),

                              //Login button
                              if(_isLoading)
                                SizedBox(height: 50,),
                              if (_isLoading)
                                CircularProgressIndicator(),
                              if (!_isLoading)
                              Expanded(
                                child: Center(
                                  child: ButtonWidget(
                                    onClick: () {
                                      if (_formKey.currentState.validate()) {
                                        //Only gets here if the fields pass
                                        _formKey.currentState.save();
                                        _login(emailController.text, passwordController.text, context);
                                      }
                                    },
                                    btnText: "Ingresar Ahora",
                                  ),
                                ),
                              ),

                              //Forgot Password
                              if (!_isLoading)
                              GestureDetector(
                                onTap: () {
                                  _resetPassword(emailController.text, context);

                                },
                                child: Text(
                                  "Olvido Contrasena",
                                  style: TextStyle(color: orangeColors),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              //Dont have account ?
                              if (!_isLoading)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("No tengo cuenta ? ",
                                      style: TextStyle(color: Colors.black)),

                                  //register ?
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => RegPage(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Registrate",
                                      style: TextStyle(color: orangeColors),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Image.asset(
              "assets/up.png",
              width: 100,
            ),
          ),
//          Positioned(
//            left: 0,
//            bottom: 0,
//            child: Image.asset(
//              "assets/down.png",
//              width: 100,
//            ),
//          ),
        ],
      ),
    );
  }

  Widget _textInput({controller, hint, icon}) {
    return Container(
      height: 60,
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: HexColor("#F2F2F5"),
          // color:Colors.g
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                offset: Offset(6, 2),
                blurRadius: 6.0,
                spreadRadius: 3.0),
            BoxShadow(
                color: Color.fromRGBO(255, 255, 255, 0.9),
                offset: Offset(-6, -2),
                blurRadius: 6.0,
                spreadRadius: 3.0)
          ]),
      padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value.isEmpty) {
            return "This field must not be empty.";
          }
          return null;
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }
  Widget _passwordInput({controller, hint, icon}) {
    return Container(
      height: 60,
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: HexColor("#F2F2F5"),
          // color:Colors.g
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                offset: Offset(6, 2),
                blurRadius: 6.0,
                spreadRadius: 3.0),
            BoxShadow(
                color: Color.fromRGBO(255, 255, 255, 0.9),
                offset: Offset(-6, -2),
                blurRadius: 6.0,
                spreadRadius: 3.0)
          ]),
      padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
      child: TextFormField(
        obscureText: true,
        controller: controller,
        validator: (value) {
          if (value.isEmpty) {
            return "This field must not be empty.";
          }
          return null;
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }

  void _login(email, password, BuildContext ctx) async {

    try {
      setState(() {
        _isLoading = true;
      });
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password);
      Navigator.of(context).pushNamedAndRemoveUntil(MAIN_SCREEN, (route) => false);
//      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
//        return HomePage();
//      }));
    } on PlatformException catch (err) {
      var message = "An error has occured, please check your credentials.";

      if (err.message != null) {
        message = err.message;
      }

      _scacffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          message,
        ),
        backgroundColor: Theme.of(ctx).errorColor,
      ));

      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);

      setState(() {
        _isLoading = false;
      });
    }
  }
  void _resetPassword(String email, BuildContext ctx) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      _scacffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          "A recovery email has been sent to you.",
        ),
        backgroundColor: Theme.of(ctx).primaryColor,
      ));
    } on PlatformException catch (err) {
      var message = "An error has occured, please check your credentials.";

      if (err.message != null) {
        message = err.message;
      }

      if (email == null || email.isEmpty) {
        message = "Please enter your registered email";
      }

      _scacffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          message,
        ),
        backgroundColor: Theme.of(ctx).errorColor,
      ));

      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);

      setState(() {
        _isLoading = false;
      });
    }
  }

}
