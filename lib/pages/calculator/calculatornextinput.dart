import 'package:alapu/pages/calculator/results.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class CalculatorNextInput extends StatefulWidget {
  final String sexoSelector;
  final String estaturaSelector;
  final String pesoSelector;
  final String edad;
  final String hematocritoInicial;
  final String hematocritoDeseado;
  final String estatura;
  final String peso;

  CalculatorNextInput(
      {@required this.sexoSelector,
      @required this.estaturaSelector,
      @required this.pesoSelector,
      @required this.edad,
      @required this.hematocritoInicial,
      @required this.hematocritoDeseado,
      @required this.estatura,
      @required this.peso});

  @override
  _CalculatorNextInputState createState() => _CalculatorNextInputState();
}

class _CalculatorNextInputState extends State<CalculatorNextInput> {
  ///Converting some received values to formula scales
  var talla;

  var peso;

  ///variables for some results
  var sc;

  var ebv;
  var cpbhct;
  var bmi;
  var hi;
  var hd;
  var cpec;

  ///calculating values for fmax
  var fmax1;
  var fmax2;
  var fmax3;
  var fmax4;
  var fmax5;
  var fmax6;
  var fmax7;
  var fmax8;
  var fmax9;
  var fmax10;

  @override
  void initState() {
    ///converting estatura to talla for formula(m2)
    talla = double.parse(widget.estatura);
    if (widget.estaturaSelector == 'cm') {
      talla = (talla * 0.01).toStringAsFixed(2);
    } else if (widget.estaturaSelector == 'in') {
      talla = (talla * 0.025).toStringAsFixed(2);
    }
    talla = double.parse(talla);

    ///converting peso to kg
    peso = double.parse(widget.peso);
    if (widget.pesoSelector == 'kg') {
      peso = (peso).toStringAsFixed(2);
    } else if (widget.pesoSelector == 'lb') {
      peso = (peso * 0.453).toStringAsFixed(2);
    }
    peso = double.parse(peso);

    ///ebv
    if (peso <= 10) {
      ebv = peso * 85;
    } else if (peso <= 20) {
      ebv = peso * 80;
    } else if (peso <= 30) {
      ebv = peso * 75;
    } else if (peso <= 40) {
      ebv = peso * 65;
    } else {
      ebv = peso * 60;
    }

    ///Calculation for cpec
    hi = double.parse(widget.hematocritoInicial);
    hd = double.parse(widget.hematocritoDeseado);
    cpec = (hi*ebv/hd) - ebv;


    sc = sqrt((talla*100) * peso / 3600).toStringAsFixed(2);
    sc = double.parse(sc);
    bmi = (peso / pow(talla, 2)).toStringAsFixed(2);
    bmi = double.parse(bmi);


    ///fmax values
    fmax1 = sc * 0.5;
    fmax2 = sc * 1.0;
    fmax3 = sc * 1.5;
    fmax4 = sc * 1.8;
    fmax5 = sc * 2.0;
    fmax6 = sc * 2.2;
    fmax7 = sc * 2.4;
    fmax8 = sc * 2.6;
    fmax9 = sc * 2.8;
    fmax10 = sc * 3.0;

    print(talla.toString() + 'talla');
    print(bmi.toString() + 'bmi');
    print(sc.toString() + 'sc');
    print(peso.toString() + 'peso');
    print(ebv.toString() + 'ebv');

    super.initState();
  }

  bool val1 = false;
  bool val2 = false;
  bool val3 = false;
  bool val4 = false;
  bool val5 = false;
  bool val6 = false;
  bool val7 = false;
  bool val8 = false;
  bool val9 = false;
  bool val10 = false;

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
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                //alap logo
                Container(
                  //padding: EdgeInsets.fromLTRB(0, 0, 150, 0),
                  height: 100,
                  child: Image(image: AssetImage('assets/alap_logo.png')),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
//                          SizedBox(width: 16,),
                          _heading('Superficie Corporal'),
                          SizedBox(width: 6,),
                          _displayresult(sc.toString()),
                          Text('\tm²',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),

                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
//                          SizedBox(width: 16,),
                          _heading('Volemia'),
                          SizedBox(width: 25,),
                          _displayresult(ebv.toStringAsFixed(1)),
                          Text('\t\tml',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
//                          _heading('CPB HCT'),
//                          _displayresult(''),
                        ///BMI Changed to IMC so just remember
//                          SizedBox(width: 16,),
                          _heading('IMC'),
                          SizedBox(
                            width: 25,
                          ),
                          _displayresult(bmi.toString()),
                          Text('\t\tkg/m²',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        ],
                      ),SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[

                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              color: Colors.blue[900],
                            ),
                            padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                            child: Text(
                              'Cristaloide para el Cebado',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
//                          SizedBox(width: 16,),
//                          _heading('Cristaloide para el Cebado'),
                          SizedBox(width: 8,),
                          _displayresult(cpec.toStringAsFixed(1)),
                          Text(' ml',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width -60,
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
//                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                              color: Colors.blue[900],
                              width: 1,
                            ),
                            color: Colors.blue[900]),
                        child: Text(
                          'Flujos de Bomba',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 26, color: Colors.white,fontWeight: FontWeight.w500),
                        ),
//                        Column(
//                          mainAxisSize: MainAxisSize.min,
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          children: <Widget>[
//                            Text(
//                              'Indice Cardíaco / Gasto Cardiaco',
//                              style:
//                                  TextStyle(fontSize: 18, color: Colors.white),
//                            ),
//                            SizedBox(
//                              height: 6,
//                            ),
//                            Text(
//                              'Lt/min/m2  /  Lt/min',
//                              style: TextStyle(fontSize: 17, color: Colors.red),
//                            )
//                          ],
//                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    color: Colors.blue[600],
                                  ),
                                  padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                                  child: Text(
                                    'Índice Cardíaco',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20, color: Colors.white),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    color: Colors.blue[600],
                                  ),
                                  padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                                  child: Text(
                                    'Gasto Cardíaco',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  'L/min/m²',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18, color: Colors.red),
                                ),
//                                _headingIC('IC'),
                                Text("        "),
                                Text(
                                  'L/min',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18, color: Colors.red),
                                ),
//                                _headingIC('GC'),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                _heading('0.5'),
                                Checkbox(
                                  value: val1,
                                  onChanged: (bool value) {
                                    setState(() {
                                      val1 = value;
                                    });
                                  },
                                ),
                                _displayresult((sc * 0.5).toStringAsFixed(2)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                _heading('1.0'),
                                Checkbox(
                                  value: val2,
                                  onChanged: (bool value) {
                                    setState(() {
                                      val2 = value;
                                    });
                                  },
                                ),
                                _displayresult((sc * 1.0).toStringAsFixed(2)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                _heading('1.5'),
                                Checkbox(
                                  value: val3,
                                  onChanged: (bool value) {
                                    setState(() {
                                      val3 = value;
                                    });
                                  },
                                ),
                                _displayresult((sc * 1.5).toStringAsFixed(2)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                _heading('1.8'),
                                Checkbox(
                                  value: val4,
                                  onChanged: (bool value) {
                                    setState(() {
                                      val4 = value;
                                    });
                                  },
                                ),
                                _displayresult((sc * 1.8).toStringAsFixed(2)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                _heading('2.0'),
                                Checkbox(
                                  value: val5,
                                  onChanged: (bool value) {
                                    setState(() {
                                      val5 = value;
                                    });
                                  },
                                ),
                                _displayresult((sc * 2.0).toStringAsFixed(2)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                _heading('2.2'),
                                Checkbox(
                                  value: val6,
                                  onChanged: (bool value) {
                                    setState(() {
                                      val6 = value;
                                    });
                                  },
                                ),
                                _displayresult((sc * 2.2).toStringAsFixed(2)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                _heading('2.4'),
                                Checkbox(
                                  value: val7,
                                  onChanged: (bool value) {
                                    setState(() {
                                      val7 = value;
                                    });
                                  },
                                ),
                                _displayresult((sc * 2.4).toStringAsFixed(2)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                _heading('2.6'),
                                Checkbox(
                                  value: val8,
                                  onChanged: (bool value) {
                                    setState(() {
                                      val8 = value;
                                    });
                                  },
                                ),
                                _displayresult((sc * 2.6).toStringAsFixed(2)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                _heading('2.8'),
                                Checkbox(
                                  value: val9,
                                  onChanged: (bool value) {
                                    setState(() {
                                      val9 = value;
                                    });
                                  },
                                ),
                                _displayresult((sc * 2.8).toStringAsFixed(2)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                _heading('3.0'),
                                Checkbox(
                                  value: val10,
                                  onChanged: (bool value) {
                                    setState(() {
                                      val10 = value;
                                    });
                                  },
                                ),
                                _displayresult((sc * 3.0).toStringAsFixed(2)),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            RaisedButton(
                              color: Colors.blue[900],
                              child: Text(
                                'Continuar',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              onPressed: () {
                                bool fmaxSelected = false;
                                var fmaxValue = fmax1;
                                int fmaxCount = 0;

                                if (val1 == true ||
                                    val2 == true ||
                                    val3 == true ||
                                    val4 == true ||
                                    val5 == true ||
                                    val6 == true ||
                                    val7 == true ||
                                    val8 == true ||
                                    val9 == true ||
                                    val10 == true) {
                                  fmaxSelected = true;
                                }

                                if(fmaxSelected == false){

                                  showDialog(
                                      context: context,
                                      child: AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            new BorderRadius
                                                .circular(18.0),
                                            side: BorderSide(
                                              color: Colors.red[400],
                                            )),
                                        title: Text("Fmax Selection"),
                                        content:
                                        Text("Seleccione un valor para Flujo maximo antes de continuar."),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text(
                                              "OK",
                                              style: TextStyle(
                                                  color:
                                                  Colors.red[400]),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      ));
                                }
                                if(val1 == true){
                                  fmaxValue = fmax1;
                                  fmaxCount+=1;
                                }
                                if(val2 == true){
                                  fmaxValue = fmax2;
                                  fmaxCount+=1;
                                }
                                if(val3 == true){
                                  fmaxValue = fmax3;
                                  fmaxCount+=1;
                                }
                                if(val4 == true){
                                  fmaxValue = fmax4;
                                  fmaxCount+=1;
                                }
                                if(val5 == true){
                                  fmaxValue = fmax5;
                                  fmaxCount+=1;
                                }
                                if(val6 == true){
                                  fmaxValue = fmax6;
                                  fmaxCount+=1;
                                }
                                if(val7 == true){
                                  fmaxValue = fmax7;
                                  fmaxCount+=1;
                                }
                                if(val8 == true){
                                  fmaxValue = fmax8;
                                  fmaxCount+=1;
                                }
                                if(val9 == true){
                                  fmaxValue = fmax9;
                                  fmaxCount+=1;
                                }
                                if(val10 == true){
                                  fmaxValue = fmax10;
                                  fmaxCount+=1;
                                }

                                if(fmaxCount > 1){

                                  showDialog(
                                      context: context,
                                      child: AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            new BorderRadius
                                                .circular(18.0),
                                            side: BorderSide(
                                              color: Colors.red[400],
                                            )),
                                        title: Text("Fmax Selection"),
                                        content:
                                        Text("Seleccione solo el 1 valor  para Fmax."),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text(
                                              "OK",
                                              style: TextStyle(
                                                  color:
                                                  Colors.red[400]),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      ));
                                }

                                if(fmaxSelected == true && fmaxCount == 1){

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Resultscreen(
                                            peso: peso,
                                            bmi: bmi,
                                            ebv: ebv,
                                            sc: sc,
                                            fmax: fmaxValue,
                                          )));
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Image.asset(
            "assets/up.png",
            width: 80,
          ),
        ),
        Positioned(
          left: 0,
          bottom: 0,
          child: Image.asset(
            "assets/down.png",
            width: 80,
          ),
        ),
      ],
    );
  }
}

Widget _heading(String text) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      color: Colors.blue[900],
    ),
    padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
    child: Text(
      text,
      style: TextStyle(fontSize: 20, color: Colors.white),
    ),
  );
}

Widget _headingIC(String text) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      color: Colors.grey,
    ),
    padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
    child: Text(
      text,
      style: TextStyle(fontSize: 20, color: Colors.white),
    ),
  );
}

Widget _displayresult(String text) {
  return Container(
    width: 90,
    height: 23,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(6)),
      color: Colors.grey[300],
      border: Border.all(
        color: Colors.blue[900],
        width: 1,
      ),
    ),
    padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 16, color: Colors.black),
    ),
  );
}
