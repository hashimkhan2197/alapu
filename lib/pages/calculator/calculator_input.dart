import 'package:alapu/pages/calculator/calculatornextinput.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class CalculatorInput extends StatefulWidget {
  CalculatorInput({Key key}) : super(key: key);

  @override
  _CalculatorInputState createState() => _CalculatorInputState();
}

class _CalculatorInputState extends State<CalculatorInput> {
  var _formKey = GlobalKey<FormState>();

  ///selector variables
  var sexoSelector = 'f';
  var sexoIndex = 1;
  var estaturaSelector = 'cm';
  var estaturaIndex = 1;
  var pesoSelector = 'kg';
  var pesoIndex = 1;

  ///Text Editing Controllers
  TextEditingController edadController = TextEditingController(text: '');
  TextEditingController hematocritoDeseadoController = TextEditingController(text: '');
  TextEditingController estaturaController = TextEditingController(text: '');
  TextEditingController pesoController = TextEditingController(text: '');
  TextEditingController hematocritoInicialController = TextEditingController(text: '');

  @override
  void dispose() {
    edadController.dispose();
    hematocritoDeseadoController.dispose();
    estaturaController.dispose();
    pesoController.dispose();
    hematocritoInicialController.dispose();
    super.dispose();
  }

  var _value = 1;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.grey[50],
            iconTheme: IconThemeData(color: Colors.black),
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),

                  ///alap logo
                  Container(
                    height: 100,
                    child: Image(image: AssetImage('assets/alap_logo.png')),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      //Calculator Logo
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/calculator.png'),
                        radius: 30,
                        backgroundColor: Colors.white,
                      ),
                      //heading
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
//                          color: Colors.blue[900],
                        ),
                        padding: EdgeInsets.fromLTRB(60, 0, 60, 0),
                        child: Text(
                          '\t\t',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            _heading('Sexo'),
                            SizedBox(
                              width: 25,
                            ),
                            //toggle button
                            ToggleSwitch(
                              minWidth: 60.0,
                              minHeight: 25,
                              initialLabelIndex: sexoIndex,
                              cornerRadius: 10.0,
                              activeFgColor: Colors.white,
                              inactiveBgColor: Colors.grey,
                              inactiveFgColor: Colors.white,
                              labels: ['M', 'F'],
                              //icons: [Icons.mars, Icons.venus],
                              activeBgColors: [Colors.blue, Colors.pink],
                              onToggle: (index) {
                                setState(() {
                                  sexoIndex = index;
                                });
                                if (index == 0) {
                                  sexoSelector = 'm';
                                } else if (index == 1) {
                                  sexoSelector = 'f';
                                }
                              },
                            ),
//                            _heading('Edad'),
//                            _input(controller: edadController),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            _heading('Edad '),
                            SizedBox(
                              width: 16,
                            ),
                            _input(controller: edadController),
                            Text(
                              '\t\taños',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            ///Change from HTC to Hematocrito Inicial, so use values of HTC in formulas
                            _heading('Hematocrito Inicial '),
                            SizedBox(
                              width: 6,
                            ),
                            _input(controller: hematocritoInicialController),
                            Text(
                              ' %',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            ///Change from Volumen de Cebado to Hematocrito Deseado
                            _heading('Hematocrito Deseado'),
                            SizedBox(
                              width: 6,
                            ),
                            _input(controller: hematocritoDeseadoController),
                            Text(
                              ' %',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            _heading('Estatura'),
                            SizedBox(width: 20,),
                            //toggle button
//                            ToggleSwitch(
//                              minWidth: 50.0,
//                              minHeight: 25,
//                              initialLabelIndex: estaturaIndex,
//                              cornerRadius: 10.0,
//                              activeFgColor: Colors.white,
//                              inactiveBgColor: Colors.grey,
//                              inactiveFgColor: Colors.white,
//                              labels: ['Cm', 'In'],
//                              //icons: [Icons.mars, Icons.venus],
//                              activeBgColors: [Colors.blue, Colors.pink],
//                              onToggle: (index) {
//                                setState(() {
//                                  estaturaIndex = index;
//                                });
//                                if (index == 0) {
//                                  estaturaSelector = 'cm';
//                                } else if (index == 1) {
//                                  estaturaSelector = 'in';
//                                }
//                              },
//                            ),
                            _input(controller: estaturaController),

                            Text(
                              '\t\tcm',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            _heading('   Peso   '),
                            SizedBox(width: 20,),
                            //toggle button
//                            ToggleSwitch(
//                              minWidth: 50.0,
//                              minHeight: 25,
//                              initialLabelIndex: pesoIndex,
//                              cornerRadius: 10.0,
//                              activeFgColor: Colors.white,
//                              inactiveBgColor: Colors.grey,
//                              inactiveFgColor: Colors.white,
//                              labels: ['Kg', 'Lb'],
//                              //icons: [Icons.mars, Icons.venus],
//                              activeBgColors: [Colors.blue, Colors.pink],
//                              onToggle: (index) {
//                                setState(() {
//                                  pesoIndex = index;
//                                });
//                                if (index == 0) {
//                                  pesoSelector = 'kg';
//                                } else if (index == 1) {
//                                  pesoSelector = 'lb';
//                                }
//                              },
//                            ),
                            _input(controller: pesoController),
                            Text(
                              '\t\tkg',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        //buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                              ),
                              child: RaisedButton(
                                color: Colors.red[900],
                                child: Text(
                                  'Calcular',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  bool isNumeric(String str) {
                                    try {
                                      var value = double.parse(str);
                                      return true;
                                    } on FormatException {
                                      return false;
                                    }
                                  }

                                  bool isEmpty = false;
                                  bool isNotNumber = false;
                                  if (edadController.text == "" ||
                                      hematocritoInicialController.text == "" ||
                                      hematocritoDeseadoController.text == '' ||
                                      estaturaController.text == "" ||
                                      pesoController.text == "") {
                                    isEmpty = true;
                                    showDialog(
                                        context: context,
                                        child: AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      18.0),
                                              side: BorderSide(
                                                color: Colors.red[400],
                                              )),
                                          title: Text("Input"),
                                          content: Text(
                                              "Complete todos los valores de entrada antes de continuar."),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text(
                                                "OK",
                                                style: TextStyle(
                                                    color: Colors.red[400]),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            )
                                          ],
                                        ));
                                  } else if (isNumeric(edadController.text) ==
                                          false ||
                                      isNumeric(hematocritoInicialController.text) == false ||
                                      isNumeric(hematocritoDeseadoController.text) ==
                                          false ||
                                      isNumeric(estaturaController.text) ==
                                          false ||
                                      isNumeric(pesoController.text) == false) {
                                    isNotNumber = true;
                                    showDialog(
                                        context: context,
                                        child: AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      18.0),
                                              side: BorderSide(
                                                color: Colors.red[400],
                                              )),
                                          title: Text("Input Types"),
                                          content: Text(
                                              "All inputs must be numbers"),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text(
                                                "OK",
                                                style: TextStyle(
                                                    color: Colors.red[400]),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            )
                                          ],
                                        ));
                                  }
                                  if (isEmpty == false &&
                                      isNotNumber == false) {
                                    //Only gets here if the fields pass
                                    _formKey.currentState.save();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CalculatorNextInput(
                                                  hematocritoDeseado: hematocritoDeseadoController.text,
                                                  edad: edadController.text,
                                                  estatura:
                                                      estaturaController.text,
                                                  estaturaSelector:
                                                      estaturaSelector,
                                                  hematocritoInicial: hematocritoInicialController.text,
                                                  peso: pesoController.text,
                                                  pesoSelector: pesoSelector,
                                                  sexoSelector: sexoSelector,
                                                )));
                                  }
                                },
                              ),
                            ),
                           ],
                        ),
                        SizedBox(
                          height: 15,
                        ),

                        //Result butoon
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RaisedButton(
                              padding: EdgeInsets.fromLTRB(50, 3, 50, 3),
                              color: Colors.grey[500],
                              textColor: Colors.white,
                              child: Text(
                                'Resultados',
                                style: TextStyle(fontSize: 18),
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
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
    );
  }
}

Widget _input({controller}) {
  return Container(
    width: 80,
    height: 25,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      border: Border.all(
        color: Colors.blue[900],
        width: 1,
      ),
      color: Colors.grey[300],
    ),
    child: TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
//      maxLength: 7,
    ),
  );
}

Widget _heading(String text) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      color: Colors.blue[900],
    ),
    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
    child: Text(
      text,
      softWrap: true,
      style: TextStyle(fontSize: 20, color: Colors.white),
    ),
  );
}

Widget _btn(String text, Color color, IconData icon, Color iconcolor) {
  return Container(
    height: 25,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
    child: RaisedButton.icon(
        color: color,
        icon: Icon(
          icon,
          color: iconcolor,
        ),
        label: Text(
          text,
          style: TextStyle(color: iconcolor),
        ),
        onPressed: () {}),
  );
}

Widget _button(String text, Color color, Color textcolor) {
  return Container(
    height: 25,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(40)),
    ),
    child: RaisedButton(
      color: color,
      child: Text(
        text,
        style: TextStyle(color: textcolor),
      ),
      onPressed: () {},
    ),
  );
}
