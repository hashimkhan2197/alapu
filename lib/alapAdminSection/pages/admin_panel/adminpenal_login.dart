import 'adminPanel_menu.dart';
import 'package:flutter/material.dart';
import '../../utils/color.dart';
import '../../widgets/btn_widget.dart';
import 'package:hexcolor/hexcolor.dart';

class AdminPanelLogin extends StatefulWidget {
  @override
  _AdminPanelLoginState createState() => _AdminPanelLoginState();
}

class _AdminPanelLoginState extends State<AdminPanelLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            _textInput(
                                hint: "Nombre de Usuario", icon: Icons.email),
                            SizedBox(
                              height: 10,
                            ),
                            _textInput(hint: "Contrasena", icon: Icons.vpn_key),

                            //Login button
                            Expanded(
                              child: Center(
                                child: ButtonWidget(
                                  onClick: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AdminPanelMenu(),
                                      ),
                                    );
                                  },
                                  btnText: "Ingresar Ahora",
                                ),
                              ),
                            ),

                            //Forgot Password
                            GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => RegPage(),
                                //   ),
                                // );
                              },
                              child: Text(
                                "Olvido Contrasena",
                                style: TextStyle(color: orangeColors),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
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
          Positioned(
            left: 0,
            bottom: 0,
            child: Image.asset(
              "assets/down.png",
              width: 100,
            ),
          ),
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
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }
}
