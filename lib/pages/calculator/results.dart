import 'package:alapu/pages/calculator/canula_arterial.dart';
import 'package:alapu/pages/calculator/canula_venosa.dart';
import 'package:alapu/pages/calculator/canulas_arteriales.dart';
import 'package:alapu/pages/calculator/canulas_venosas.dart';
import 'package:alapu/pages/calculator/canulavinosa_unica.dart';
import 'package:alapu/pages/calculator/oxigenadores.dart';
import 'package:flutter/material.dart';

class Resultscreen extends StatefulWidget {
  var peso;
  var fmax;
  var sc;
  var ebv;
  var bmi;

  Resultscreen({
    @required this.peso,
    @required this.fmax,
    @required this.sc,
    @required this.ebv,
    @required this.bmi,
  });

  @override
  _ResultscreenState createState() => _ResultscreenState();
}

class _ResultscreenState extends State<Resultscreen> {
  var fmax;

  ///Text Editing Controllers
  TextEditingController hbController = TextEditingController(text: '');
  TextEditingController po2artController = TextEditingController(text: '');
  TextEditingController po2venController = TextEditingController(text: '');
  TextEditingController icController = TextEditingController(text: '');
  TextEditingController satartController = TextEditingController(text: '');
  TextEditingController satvenController = TextEditingController(text: '');
  TextEditingController fcecController = TextEditingController(text: '');

  TextEditingController ebController = TextEditingController(text: '');
  TextEditingController krealController = TextEditingController(text: '');
  TextEditingController kidealController = TextEditingController(text: '');

  @override
  void dispose() {
    hbController.dispose();
    po2artController.dispose();
    po2venController.dispose();
    icController.dispose();
    satartController.dispose();
    satvenController.dispose();
    ebController.dispose();
    krealController.dispose();
    kidealController.dispose();
    fcecController.dispose();
    super.dispose();
  }

  var canulasArteriales = 1;
  var canulasVenosas = 1;
  var canulaVenosaUnica = 1;
  var canulaArterial = 1;
  var canulaVenosa = 1;

  ///variables to hold different values for the calculator
  double volumenTotalInduccin;
  double volumenSangraInduccin;
  double volumenCristaloideInduccin;
  double volumenTotalMainten;
  double volumenSangraMainten;
  double volumenCristaloideMainten;

  //--------------------------------
  ///Dosis SaintThomas
  double thomasInductionDropValue = 30.0;
  double thomasmaintenDropValue = 15.0;
  double dosisInductionThomas;
  double dosisMaintenThomas;

  //-----------------------------
  ///Surgerencia de Tubos Values
  String tuberiaArterial;
  String tuberiaVenosa;
  String cabezalArterial;

  //----------------------------------
  ///Calculas de Drogas Section
  double dosisDeHeparinaDropValue = 3.0;
  double dosisDeProtaminaDropValue = 1;
  double manitol1;

  double manitol2;

  double dosisDeHeparina;
  double dosisDeProtamina;
  double manitol;

  double bicarbonatodesodio;
  double bicarbonatodepotasio;
  double bicarbonatodecalcio;

  String bicarbonatodesodiotext = '';
  String bicarbonatodepotasiotext = '';
  String bicarbonatodecalciotext = '';

  ///Consumo de oxigeno Section
  double cao2;
  double cvo2;
  double do2art;
  double do2ven;
  double vo2;
  String cao2text = '';
  String cvo2text = '';
  String do2arttext = '';
  String do2ventext = '';
  String vo2text = '';

  @override
  void initState() {
    //DOSIS Section
    volumenTotalInduccin = widget.peso * 20;

    ///Limit the value
    if (volumenTotalInduccin > 1100) {
      volumenTotalInduccin = 1100;
    }
    volumenSangraInduccin = volumenTotalInduccin / 5;
    volumenCristaloideInduccin = volumenSangraInduccin * 4;
    volumenTotalMainten = widget.peso * 10;

    ///limit the value
    if (volumenTotalMainten > 550) {
      volumenTotalMainten = 550;
    }
    volumenSangraMainten = volumenTotalMainten / 5;
    volumenCristaloideMainten = volumenSangraMainten * 4;
    //--------------------------
    //Dosis Saint Thomas Section

    dosisInductionThomas = thomasInductionDropValue * widget.peso;

//    if(dosisInductionThomas > 1450){
//      dosisInductionThomas = 1450;
//    }
    dosisMaintenThomas = thomasmaintenDropValue * widget.peso;
//    if(dosisMaintenThomas > 750){
//      dosisMaintenThomas = 750;
//    }
    //--------------------
    //Surgerencia de Tubos Section
    fmax = widget.fmax.toStringAsFixed(2);
    fmax = double.parse(fmax);
    print(fmax.toString());
    if (fmax < 0.6) {
      tuberiaArterial = '3/16"';
      tuberiaVenosa = '3/16"';
      cabezalArterial = '1/4"';
    }
    if (fmax >= 0.6) {
      tuberiaArterial = '3/16"';
      tuberiaVenosa = '1/4"';
      cabezalArterial = '1/4"';
    }
    if (fmax >= 1.2) {
      tuberiaArterial = '1/4"';
      tuberiaVenosa = '3/8"';
      cabezalArterial = '1/4"';
    }
    if (fmax >= 2.0) {
      tuberiaArterial = '3/8"';
      tuberiaVenosa = '3/8"';
      cabezalArterial = '3/8"';
    }
    if (fmax >= 3.5) {
      tuberiaArterial = '3/8"';
      tuberiaVenosa = '1/2"';
      cabezalArterial = '1/2"';
    }
//    if (fmax >= 1.2) {
//      tuberiaArterial = '3/8"';
//      tuberiaVenosa = '3/8"';
//      cabezalArterial = '1/2"';
//    }
//    if (fmax >= 1.3) {
//      tuberiaArterial = '3/8"';
//      tuberiaVenosa = '1/2"';
//      cabezalArterial = '1/2"';
//    }
    //-----------------------
    //Calculas de Drogas Section
    dosisDeHeparina = widget.peso * dosisDeHeparinaDropValue * 100;
    dosisDeProtamina = (dosisDeProtaminaDropValue * dosisDeHeparina) / 100;
//    if (dosisDeProtamina > 50.0){
//      dosisDeProtamina = 50.0;
//    }
    bicarbonatodecalcio = (widget.peso * 50) / 100;
    bicarbonatodecalciotext = bicarbonatodecalcio.toStringAsFixed(2);
    manitol1 = 1.0;
    manitol2 = 18.0;
    manitol = (widget.peso * manitol1 * 100) / manitol2;
  }

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
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  //alap logo
                  Container(
                    //padding: EdgeInsets.fromLTRB(0, 0, 150, 0),
                    height: 100,
                    child: Image(image: AssetImage('assets/alap_logo.png')),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: <Widget>[
                      SizedBox(height: 20),
                      _heading('CÁNULAS'),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.fromLTRB(100, 4, 100, 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.red[800],
                        ),
                        child: Text(
                          'Sugerencia',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 20),
                      DropdownButton(
                          value: canulasArteriales,
                          items: [
                            DropdownMenuItem(
                              child: _contstantdatabig('Cánulas ARTERIALES'),
                              value: 1,
                            ),
                            DropdownMenuItem(
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CanulasArteriales(fmax),
                                    ),
                                  );
                                },
                                child: Text('Medtronic® DLP™punta recta'),
                              ),
                              value: 2,
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              canulasArteriales = value;
                            });
                          }),

                      SizedBox(
                        height: 10,
                      ),
                      DropdownButton(
                          value: canulasVenosas,
                          items: [
                            DropdownMenuItem(
                              child: _contstantdatabig('Cánulas VENOSAS'),
                              value: 1,
                            ),
                            DropdownMenuItem(
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CanulasVenosas(fmax),
                                    ),
                                  );
                                },
                                child:
                                    Text('Medtronic® DLP™punta metálica curva'),
                              ),
                              value: 2,
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              canulasVenosas = value;
                            });
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      DropdownButton(
                          value: canulaVenosaUnica,
                          items: [
                            DropdownMenuItem(
                              child: _contstantdatabig('Cánula VENOSA UNICA'),
                              value: 1,
                            ),
                            DropdownMenuItem(
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CanulaVenosaUnica(fmax),
                                    ),
                                  );
                                },
                                child: Text(
                                    'Medtronic® DLP™Una etapa, punta recta'),
                              ),
                              value: 2,
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              canulaVenosaUnica = value;
                            });
                          }),

                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(30, 7, 30, 7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.grey[600],
                        ),
                        child: Text(
                          'Cánulas FEMORALES',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DropdownButton(
                          value: canulaArterial,
                          items: [
                            DropdownMenuItem(
                              child: _contstantdatabig('Cánula ARTERIAL'),
                              value: 1,
                            ),
                            DropdownMenuItem(
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CanulaArterial(fmax),
                                    ),
                                  );
                                },
                                child: Text('BIO-MEDICUS™ARTERIAL FEMORAL'),
                              ),
                              value: 2,
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              canulaArterial = value;
                            });
                          }),

                      SizedBox(
                        height: 10,
                      ),
                      DropdownButton(
                          value: canulaVenosa,
                          items: [
                            DropdownMenuItem(
                              child: _contstantdatabig('Cánula VENOSA'),
                              value: 1,
                            ),
                            DropdownMenuItem(
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CanulaVenosa(fmax),
                                    ),
                                  );
                                },
                                child: Text('BIO-MEDICUS™VENOSAS FEMORAL'),
                              ),
                              value: 2,
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              canulaVenosa = value;
                            });
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      _heading('Sugerencia de Tubos'),
//                      SizedBox(
//                        height: 10,
//                      ),
//                      Container(
//                        padding: EdgeInsets.fromLTRB(100, 4, 100, 4),
//                        decoration: BoxDecoration(
//                          borderRadius: BorderRadius.all(Radius.circular(5)),
//                          color: Colors.red[800],
//                        ),
//                        child: Text(
//                          'sugerencia',
//                          style: TextStyle(fontSize: 18, color: Colors.white),
//                        ),
//                      ),
                      SizedBox(
                        height: 20,
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          _contstantdata('Tubería Arterial'),
                          _contstantdatasmall(tuberiaArterial)
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          _contstantdata('Tubería Venosa'),
                          _contstantdatasmall(tuberiaVenosa)
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          _contstantdata('Cabezal Arterial'),
                          _contstantdatasmall(cabezalArterial)
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      _heading('Oxigenadores'),
                      SizedBox(height: 20),
                      InkWell(
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          radius: 80,
                          backgroundImage: AssetImage('assets/tablepic.jpeg'),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OxigenadoresPicture(),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      ///alap id button
                      Padding(
                        padding: EdgeInsets.fromLTRB(100, 10, 100, 10),
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            color: Colors.blue,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Abrir',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(Icons.arrow_right)
                              ],
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OxigenadoresPicture(),
                                ),
                              );
                            }),
                      ),
                      SizedBox(height: 20),
                      _heading('Cardioplejía del Nido'),
                      SizedBox(height: 10),
                      //Componentes
                      Container(
                        width: MediaQuery.of(context).size.width -20,
                        padding: EdgeInsets.fromLTRB(4, 5, 0, 3),
//                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                              color: Colors.blue[900],
                              width: 2,
                            ),
                            color: Colors.blue[300]
                        ),
                        child: Column(
                          children: [

                            Text(
                              'Componentes',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20, color: Colors.red[700],fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 4,),
                            _referenceData('Plasmalyte®','1000 ml', Colors.blue[100]),
                            _referenceData('Bicarbonato de Sodio (8.4%)','13 ml (13 mEq)', Colors.blue[50]),
                            _referenceData('Cloruro de Potasio(2meq/ml)','13 ml (26 mEq)', Colors.blue[100]),
                            _referenceData('Sulfato de Magnesio(25%)','8 ml (2g)', Colors.blue[50]),
                            _referenceData('Lidocaína (2%)','6.5 ml', Colors.blue[100]),
                            _referenceData('Manitol (20%)','16 ml', Colors.blue[50]),
                            _referenceData2('Temperatura', '4 a 5 °C', Colors.blue[100]),
                            _referenceData2('Tiempo de Protección', '90 a 120 min', Colors.blue[50]),
                            _referenceData2('Relación 1:4', '1 parte de Sangre\n4 partes de Cristaloide', Colors.blue[100]),

                          ],
                        )
                      ),
//                      SizedBox(height: 15,),
//                      Container(
//                        padding: EdgeInsets.fromLTRB(30, 3, 30, 3),
//                        decoration: BoxDecoration(
//                          borderRadius: BorderRadius.all(Radius.circular(5)),
//                          color: Colors.red[900],
//                        ),
//                        child:
//                        Text(
//                          'Componentes',
//                          style: TextStyle(fontSize: 20, color: Colors.white),
//                        ),
//                      ),
//                      SizedBox(height: 20),
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceAround,
//                        children: [
//                          _componentesdata('PlasmaLyte®'),
//                          _resultdatasmall('1000 ml')
//                        ],
//                      ),
//                      SizedBox(height: 10),
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceAround,
//                        children: [
//                          _componentesdata('Bicarbonato de sodio ( 8.4% )'),
//                          _resultdatasmall('13 mll ( 13 mEq )')
//                        ],
//                      ),
//                      SizedBox(height: 10),
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceAround,
//                        children: [
//                          _componentesdata('Cloruro de Potasio ( 2 mEq/ml )'),
//                          _resultdatasmall('13 mll ( 26 mEq )')
//                        ],
//                      ),
//                      SizedBox(height: 10),
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceAround,
//                        children: [
//                          _componentesdata('Sulfato de Magnesio ( 25% )'),
//                          _resultdatasmall('8 ml ( 2g )')
//                        ],
//                      ),
//                      SizedBox(height: 10),
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceAround,
//                        children: [
//                          _componentesdata('Lidocaína'),
//                          _resultdatasmall('6.5 ml')
//                        ],
//                      ),
//                      SizedBox(height: 10),
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceAround,
//                        children: [
//                          _componentesdata('Manitol( 20% )'),
//                          _resultdatasmall('16 ml')
//                        ],
//                      ),
//
//                      SizedBox(height: 20),
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceAround,
//                        children: <Widget>[
//                          _contstantdata('Temperatura'),
//                          _contstantdata('4C - 5C')
//                        ],
//                      ),
//                      SizedBox(height: 10),
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceAround,
//                        children: <Widget>[
//                          _contstantdata('Tiempo de Protección'),
//                          _contstantdata('90 - 120 Minutos')
//                        ],
//                      ),
                      SizedBox(height: 20),
                      _heading('Dosis'),
//                      SizedBox(height: 10),
//                      Container(
//                        padding: EdgeInsets.fromLTRB(30, 3, 30, 3),
//                        decoration: BoxDecoration(
//                          borderRadius: BorderRadius.all(Radius.circular(5)),
//                          color: Colors.grey[800],
//                        ),
//                        child: Column(
//                          children: [
//                            Text(
//                              'Relación1:4',
//                              style:
//                                  TextStyle(color: Colors.white, fontSize: 18),
//                            ),
//                            Text(
//                              '( 1 parte de Sangre 4 Partes de Cristaloides )',
//                              style:
//                                  TextStyle(color: Colors.white, fontSize: 15),
//                            ),
//                          ],
//                        ),
//                      ),

                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.fromLTRB(30, 3, 30, 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.grey[300],
                        ),
                        child: Text(
                          'Inducción',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                          _contstantdata('Volumen total'),
                          SizedBox(
                            width: 8,
                          ),
                          _resultdatasmall(
                              volumenTotalInduccin.toStringAsFixed(1)),
                          Text(
                            'ml',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                          _contstantdata('Volumen de sangre'),
                          SizedBox(
                            width: 8,
                          ),
                          _resultdatasmall(
                              volumenSangraInduccin.toStringAsFixed(1)),
                          Text(
                            'ml',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                          _contstantdata('Volumen de Cristaloide'),
                          SizedBox(
                            width: 8,
                          ),
                          _resultdatasmall(
                              volumenCristaloideInduccin.toStringAsFixed(1)),
                          Text(
                            'ml',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      //Mantenimiento
                      Container(
                        padding: EdgeInsets.fromLTRB(30, 3, 30, 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.grey[300],
                        ),
                        child: Text(
                          'Mantenimiento',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                          _contstantdata('Volumen total'),
                          SizedBox(
                            width: 8,
                          ),
                          _resultdatasmall(
                              volumenTotalMainten.toStringAsFixed(1)),
                          Text(
                            'ml',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                          _contstantdata('Volumen de sangre'),
                          SizedBox(
                            width: 8,
                          ),
                          _resultdatasmall(
                              volumenSangraMainten.toStringAsFixed(1)),
                          Text(
                            'ml',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                          _contstantdata('Volumen de Cristaloide'),
                          SizedBox(
                            width: 8,
                          ),
                          _resultdatasmall(
                              volumenCristaloideMainten.toStringAsFixed(1)),
                          Text(
                            'ml',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),

                      _heading('Saint Thomas II'),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width -20,
                          padding: EdgeInsets.fromLTRB(4, 5, 0, 3),
//                        height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              border: Border.all(
                                color: Colors.blue[900],
                                width: 2,
                              ),
                              color: Colors.blue[300]
                          ),
                          child: Column(
                            children: [

                              Text(
                                'Composición',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 20, color: Colors.red[700],fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 4,),
                              _referenceData('Cloruro de Sodio','110 mmol/l', Colors.blue[100]),
                              _referenceData('Cloruro de Potasio ','16 mmol/l', Colors.blue[50]),
                              _referenceData('Sulfato de Magnesio','16 mmol/l', Colors.blue[100]),
                              _referenceData('Cloruro de Calcio','1,2 mmol/l', Colors.blue[50]),
                              _referenceData('Bicarbonato de Sodio','10 mmol/l', Colors.blue[100]),
                              _referenceData2('Temperatura', '4 °C', Colors.blue[50]),
                              _referenceData2('Tiempo de Protección', '20 min', Colors.blue[100]),

                            ],
                          )
                      ),
//                      Container(
//                        padding: EdgeInsets.fromLTRB(100, 4, 100, 4),
//                        decoration: BoxDecoration(
//                          borderRadius: BorderRadius.all(Radius.circular(5)),
//                          color: Colors.red[800],
//                        ),
//                        child: Text(
//                          'Composición',
//                          style: TextStyle(fontSize: 18, color: Colors.white),
//                        ),
//                      ),
//                      SizedBox(
//                        height: 20,
//                      ),
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceAround,
//                        children: <Widget>[
//                          _contstantdata('Na +'),
//                          _contstantdatasmall('110 mmol/l')
//                        ],
//                      ),
//                      SizedBox(
//                        height: 10,
//                      ),
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceAround,
//                        children: <Widget>[
//                          _contstantdata('K +'),
//                          _contstantdatasmall('16 mmol/l')
//                        ],
//                      ),
//                      SizedBox(
//                        height: 10,
//                      ),
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceAround,
//                        children: <Widget>[
//                          _contstantdata('Mg2 +'),
//                          _contstantdatasmall('16 mmol/l')
//                        ],
//                      ),
//                      SizedBox(
//                        height: 10,
//                      ),
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceAround,
//                        children: <Widget>[
//                          _contstantdata('Ca2 +'),
//                          _contstantdatasmall('1.2 mmol/l')
//                        ],
//                      ),
//                      SizedBox(height: 10),
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceAround,
//                        children: <Widget>[
//                          _contstantdata('NaHCO3'),
//                          _contstantdatasmall('10 mmol/l')
//                        ],
//                      ),
                      SizedBox(
                        height: 20,
                      ),
                      _heading('Dosis de Inducción'),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          _contstantdata('Temperatura'),
                          _contstantdata('4C')
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
//                      DropdownButton(
//                          value: _val,
//                          items: [
//                            DropdownMenuItem(
//                              child: _contstantdata('Dosis'),
//                              value: 1,
//                            ),
//                            DropdownMenuItem(
//                              child: Text('15 ml'),
//                              value: 2,
//                            ),
//                            DropdownMenuItem(
//                              child: Text('10 ml'),
//                              value: 3,
//                            ),
//                          ],
//                          onChanged: (value) {
//                            setState(() {
//                              _val = value;
//                            });
//                          }),
//                      _resultdata('')
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                            width: 110,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              color: Colors.grey[300],
                              border: Border.all(
                                color: Colors.blue[900],
                                width: 1,
                              ),
                            ),
                            child: Text(
                              "Dosis",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ),
//                          _contstantdata('Dosis'),
                          DropdownButton(
                              value: thomasInductionDropValue,
                              items: [
                                DropdownMenuItem(
                                  child: Text('30 ml'),
                                  value: 30.0,
                                ),
                                DropdownMenuItem(
                                  child: Text('20 ml'),
                                  value: 20.0,
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  thomasInductionDropValue = value;
                                  dosisInductionThomas =
                                      thomasInductionDropValue * widget.peso;
//                                  if(dosisInductionThomas > 1450){
//                                    dosisInductionThomas = 1450;
//                                  }
                                });
                              }),
                          _contstantdatasmall(
                              dosisInductionThomas.toStringAsFixed(1)),
                          Text(
                            'ml',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          _contstantdata(' Tiempo de Protección'),
                          _contstantdata('20 Min')
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      _heading('Dosis de Mentenimiento'),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          _contstantdata('Temperatura'),
                          _contstantdata('4C ')
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
//                          _contstantdata('Dosis'),
//                      DropdownButton(
//                          value: val,
//                          items: [
//                            DropdownMenuItem(
//                              child: _contstantdata('Dosis'),
//                              value: 1,
//                            ),
//                            DropdownMenuItem(
//                              child: Text('15 ml'),
//                              value: 2,
//                            ),
//                            DropdownMenuItem(
//                              child: Text('10 ml'),
//                              value: 3,
//                            ),
//                          ],
//                          onChanged: (value) {
//                            setState(() {
//                              val = value;
//                            });
//                          }),
//                      _resultdata('')
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                            width: 110,
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(5)),
                              color: Colors.grey[300],
                              border: Border.all(
                                color: Colors.blue[900],
                                width: 1,
                              ),
                            ),
                            child: Text(
                              "Dosis",
                              textAlign: TextAlign.center,
                              style:
                              TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ),
                          DropdownButton(
                              value: thomasmaintenDropValue,
                              items: [
                                DropdownMenuItem(
                                  child: Text('15 ml'),
                                  value: 15.0,
                                ),
                                DropdownMenuItem(
                                  child: Text('10 ml'),
                                  value: 10.0,
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  thomasmaintenDropValue = value;
                                  dosisMaintenThomas =
                                      thomasmaintenDropValue * widget.peso;
//                                  if(dosisMaintenThomas > 750){
//                                    dosisMaintenThomas = 750;
//                                  }
                                });
                              }),
                          _contstantdatasmall(
                              dosisMaintenThomas.toStringAsFixed(1)),
                          Text(
                            'ml',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      _heading('Cálculos de Drogas'),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          _contstantdata('Dosis de Heparina'),
                          DropdownButton(
                              value: dosisDeHeparinaDropValue,
                              items: [
                                DropdownMenuItem(
                                  child: Text('3mg/kg'),
                                  value: 3.0,
                                ),
                                DropdownMenuItem(
                                  child: Text('4mg/kg'),
                                  value: 4.0,
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  dosisDeHeparinaDropValue = value;
                                  dosisDeHeparina = dosisDeHeparinaDropValue *
                                      widget.peso *
                                      100;
                                });
                              }),
                          _contstantdatasmall(
                              dosisDeHeparina.toStringAsFixed(1)),
                          Text(
                            'UI',
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          _contstantdata('Dosis de Protamina'),
                          DropdownButton(
                              value: dosisDeProtaminaDropValue,
                              items: [
                                DropdownMenuItem(
                                  child: Text(' 1:1'),
                                  value: 1.0,
                                ),
                                DropdownMenuItem(
                                  child: Text(' 1:1.5'),
                                  value: 1.5,
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  dosisDeProtaminaDropValue = value;
                                  dosisDeProtamina =
                                      (dosisDeProtaminaDropValue *
                                              dosisDeHeparina) /
                                          100;
//                                  if (dosisDeProtamina > 50.0){
//                                    dosisDeProtamina = 50.0;
//                                  }
                                });
                              }),
                          _contstantdatasmall(
                              dosisDeProtamina.toStringAsFixed(2)),
                          Text(
                            'mg',
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          _contstantdata('Bicarbonato de Sodio'),
                          _input('EB', ebController),
                          _contstantdatasmall(bicarbonatodesodiotext),
                          Text(
                            'mEq',
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          _contstantdata('Gluconato de Calcio'),
                          SizedBox(
                            width: 8,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          _contstantdatasmall(bicarbonatodecalciotext),
                          Text(
                            'mg',
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          _contstantdata('Cloruro de Potasio'),
                          Column(
                            children: [
                              _input('K real', krealController),
                              SizedBox(height: 5),
                              _input('K ideal', kidealController),
                            ],
                          ),
                          _contstantdatasmall(bicarbonatodepotasiotext),
                          Text(
                            'mEq',
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          _contstantdatasmall('Manitol'),
                          Column(
                            children: [
                              DropdownButton(
                                  value: manitol1,
                                  items: [
                                    DropdownMenuItem(
                                      child: Text('Adulto'),
                                      value: 1.0,
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Pediátrico'),
                                      value: 0.5,
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      manitol1 = value;
                                      manitol = (widget.peso * manitol1 * 100) /
                                          manitol2;
                                    });
                                  }),
                              DropdownButton(
                                  value: manitol2,
                                  items: [
                                    DropdownMenuItem(
                                      child: Text('18%'),
                                      value: 18.0,
                                    ),
                                    DropdownMenuItem(
                                      child: Text('20%'),
                                      value: 20.0,
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      manitol2 = value;
                                      manitol = (widget.peso * manitol1 * 100) /
                                          manitol2;
                                    });
                                  }),
                            ],
                          ),
                          _contstantdatasmall(manitol.toStringAsFixed(2)),
                          Text(
                            'ml',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(
                            padding: EdgeInsets.fromLTRB(50, 3, 50, 3),
                            color: Colors.red,
                            textColor: Colors.white,
                            child: Text(
                              'Calcular',
                              style: TextStyle(fontSize: 18),
                            ),
                            onPressed: () {
                              ///finction to confirm inputs are numbers
                              bool isNumeric(String str) {
                                try {
                                  var value = double.parse(str);
                                  return true;
                                } on FormatException {
                                  return false;
                                }
                              }

                              ///function to check if ebValue is negative
                              bool isNegative(String str){
                                try{
                                  var value = double.parse(str);
                                  if (value < 0){
                                    return true;
                                  }else{
                                    return false;
                                  }

                                } on FormatException{
                                  return false;
                                }
                              }

                              ///ebValue check to be negative
                              bool ebchecker = false;
                              bool isEmpty = false;
                              bool isNotNumber = false;
                              if (ebController.text == "" ||
                                  krealController.text == "" ||
                                  kidealController.text == '') {
                                isEmpty = true;
                                showDialog(
                                    context: context,
                                    child: AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(18.0),
                                          side: BorderSide(
                                            color: Colors.red[400],
                                          )),
                                      title: Text("Entradas"),
                                      content: Text(
                                          "Por favor complete todos los campos de entrada"),
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
                              } else if (isNumeric(ebController.text) ==
                                      false ||
                                  isNumeric(krealController.text) == false ||
                                  isNumeric(kidealController.text) == false) {
                                isNotNumber = true;
                                showDialog(
                                    context: context,
                                    child: AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(18.0),
                                          side: BorderSide(
                                            color: Colors.red[400],
                                          )),
                                      title: Text("Tipos de entrada"),
                                      content:
                                          Text("Todas las entradas deben ser números."),
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
                              } else if (isNegative(ebController.text) == false) {
                                ebchecker = true;
                                showDialog(
                                    context: context,
                                    child: AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          new BorderRadius.circular(18.0),
                                          side: BorderSide(
                                            color: Colors.red[400],
                                          )),
                                      title: Text("EB Valor"),
                                      content:
                                      Text("La entrada debe ser un número negativo."),
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
                              if (isEmpty == false && isNotNumber == false && ebchecker== false) {
                                //Only gets here if the fields pass
                                setState(() {
                                  bicarbonatodesodio = (widget.peso *
                                          0.3 *
                                          double.parse(ebController.text)) /
                                      2;
                                  bicarbonatodepotasio = (double.parse(
                                              kidealController.text) -
                                          double.parse(krealController.text)) *
                                      0.3 *
                                      widget.peso;
                                  if (bicarbonatodesodio < 0) {
                                    bicarbonatodesodio =
                                        bicarbonatodesodio * -1.0;
                                  }
                                  bicarbonatodesodiotext =
                                      bicarbonatodesodio.toStringAsFixed(2);
                                  bicarbonatodepotasiotext =
                                      bicarbonatodepotasio.toStringAsFixed(2);
                                });
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      _heading('TRANSPORTE DE OXÍGENO'),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 18,
                          ),
                          _input2('Hb', hbController),
                          Text(
                            '  g/dl            ',
                            style: TextStyle(fontSize: 16),
                          ),
                          _input2('PO2 Art', po2artController),
                          Text(
                            '  mmHg',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 18,
                          ),
                          _input2('IC', icController),
                          Text(
                            ' lt/min/m2  ',
                            style: TextStyle(fontSize: 16),
                          ),
                          _input2('PO2 ven', po2venController),
                          Text(
                            '  mmHg',
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 18,
                          ),
                          _input2('SatO2 Art', satartController),
                          Text(
                            '  %                ',
                            style: TextStyle(fontSize: 16),
                          ),
                          _input2('SatO2 ven', satvenController),
                          Text(
                            '  %',
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 18,
                          ),
                          _input2('Flujo CEC', fcecController),
                          Text(
                            '   lt/min',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          _componentesdataOxigeno(
                              'Contenido Arterial de Oxígeno'),
                          _contstantdatasmall(cao2text),
                          Text(
                            'ml/dl',
                            style: TextStyle(fontSize: 14),
                          )
                        ],
                      ),

                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          _componentesdataOxigeno(
                              'Contenido Venoso de Oxígeno'),
                          _contstantdatasmall(cvo2text),
                          Text(
                            'ml/dl',
                            style: TextStyle(fontSize: 14),
                          )
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          _componentesdataOxigeno(
                              'Entrega de Oxígeno Arterial'),
                          _contstantdatasmall(do2arttext),
                          Text(
                            'ml/min',
                            style: TextStyle(fontSize: 14),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          _componentesdataOxigeno('Entrega de Oxígeno Venoso'),
                          _contstantdatasmall(do2ventext),
                          Text(
                            'ml/min',
                            style: TextStyle(fontSize: 14),
                          )
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
//                          _componentesdataOxigeno('Consumo de Oxigeno'),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                            width: 175,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              color: Colors.grey[300],
                              border: Border.all(
                                color: Colors.blue[900],
                                width: 1,
                              ),
                            ),
                            child: Text(
                              'Consumo de Oxígeno',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              color: Colors.grey[300],
                              border: Border.all(
                                color: Colors.blue[900],
                                width: 1,
                              ),
                            ),
                            child: Text(
                              vo2text,
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black,fontWeight: FontWeight.w500),
                            ),
                          ),
                          Text(
                            'ml/min',
                            style: TextStyle(fontSize: 14),
                          ),
//                          _contstantdatasmall(vo2text)
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ///Calculating Results
                          RaisedButton(
                            padding: EdgeInsets.fromLTRB(50, 3, 50, 3),
                            color: Colors.red,
                            textColor: Colors.white,
                            child: Text(
                              'Calcular',
                              style: TextStyle(fontSize: 18),
                            ),
                            onPressed: () {
                              ///function to check if all inputs are numbers
                              bool isNumeric(String str) {
                                try {
                                  var value = double.parse(str);
                                  return true;
                                } on FormatException {
                                  return false;
                                }
                              }

                              /// function to check if Flujo CEC is less than 10
                              bool isLTten(String str){
                                try{
                                  var value = double.parse(str);
                                  if (value < 10){
                                    return true;
                                  }else{
                                    return false;
                                  }
                                }on FormatException{
                                  return false;
                                }
                              }

                              bool flujoChecker = false;
                              bool isEmpty = false;
                              bool isNotNumber = false;
                              if (hbController.text == "" ||
                                  po2artController.text == "" ||
                                  po2venController.text == '' ||
                                  icController.text == "" ||
                                  satartController.text == "" ||
                                  satvenController.text == "" ||
                                  fcecController.text == "") {
                                isEmpty = true;
                                showDialog(
                                    context: context,
                                    child: AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(18.0),
                                          side: BorderSide(
                                            color: Colors.red[400],
                                          )),
                                      title: Text("Entrada"),
                                      content: Text(
                                          "Por favor complete todos los campos de entrada."),
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
                              } else if (isNumeric(hbController.text) ==
                                      false ||
                                  isNumeric(po2artController.text) == false ||
                                  isNumeric(po2venController.text) == false ||
                                  isNumeric(icController.text) == false ||
                                  isNumeric(satartController.text) == false ||
                                  isNumeric(satvenController.text) == false ||
                                  isNumeric(fcecController.text) == false) {
                                isNotNumber = true;
                                showDialog(
                                    context: context,
                                    child: AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(18.0),
                                          side: BorderSide(
                                            color: Colors.red[400],
                                          )),
                                      title: Text("Tipos de entrada"),
                                      content:
                                          Text("Todas las entradas deben ser números."),
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
                              }else if (isLTten(fcecController.text) == false) {
                                flujoChecker = true;
                                showDialog(
                                    context: context,
                                    child: AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          new BorderRadius.circular(18.0),
                                          side: BorderSide(
                                            color: Colors.red[400],
                                          )),
                                      title: Text("Flujo CEC"),
                                      content:
                                      Text("El valor debe ser menor que 10.0"),
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
                              if (isEmpty == false && isNotNumber == false && flujoChecker == false) {
                                //Only gets here if the fields pass
                                setState(() {
                                  cao2 = (double.parse(hbController.text) *
                                          double.parse(satartController.text) *
                                          1.34 /
                                          100) +
                                      (double.parse(po2artController.text) *
                                          0.003);

                                  cvo2 = (double.parse(hbController.text) *
                                          double.parse(satvenController.text) *
                                          1.34 /
                                          100) +
                                      (double.parse(po2venController.text) *
                                          0.003);

                                  do2art = double.parse(fcecController.text) *
                                      cao2 *
                                      10;
                                  do2ven = double.parse(fcecController.text) *
                                      cvo2 *
                                      10;
                                  vo2 = (double.parse(fcecController.text) *
                                      (cao2 - cvo2) *
                                      10);
                                  cao2text = cao2.toStringAsFixed(2);
                                  cvo2text = cvo2.toStringAsFixed(2);
                                  do2arttext = do2art.toStringAsFixed(2);
                                  do2ventext = do2ven.toStringAsFixed(2);
                                  vo2text = vo2.toStringAsFixed(2);
                                });
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ]),
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
      ],
    );
  }
}

Widget _heading(String text) {
  return Container(
    padding: EdgeInsets.fromLTRB(50, 3, 50, 3),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      color: Colors.blue[900],
    ),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 20, color: Colors.white),
    ),
  );
}

Widget _contstantdata(String text) {
  return Container(
    padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
    width: 150,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      color: Colors.grey[300],
      border: Border.all(
        color: Colors.blue[900],
        width: 1,
      ),
    ),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 14, color: Colors.black),
    ),
  );
}

Widget _componentesdata(String text) {
  return Container(
    padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
    width: 200,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      color: Colors.grey[300],
      border: Border.all(
        color: Colors.blue[900],
        width: 1,
      ),
    ),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 14, color: Colors.black),
    ),
  );
}

Widget _componentesdataOxigeno(String text) {
  return Container(
    padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
    width: 200,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      color: Colors.grey[300],
      border: Border.all(
        color: Colors.blue[900],
        width: 1,
      ),
    ),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 14, color: Colors.black),
    ),
  );
}

Widget _contstantdatasmall(String text) {
  return Container(
    padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
    width: 70,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      color: Colors.grey[300],
      border: Border.all(
        color: Colors.blue[900],
        width: 1,
      ),
    ),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 14, color: Colors.black),
    ),
  );
}

Widget _contstantdatabig(String text) {
  return Container(
    padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
    width: 275,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      color: Colors.grey[300],
      border: Border.all(
        color: Colors.blue[900],
        width: 1,
      ),
    ),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 15, color: Colors.black),
    ),
  );
}

Widget _resultdata(String text) {
  return Container(
    width: 170,
    height: 100,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      color: Colors.grey[300],
      border: Border.all(
        color: Colors.blue[900],
        width: 1,
      ),
    ),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 16, color: Colors.black),
    ),
  );
}

Widget _resultdatasmall(String text) {
  return Container(
    padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
    width: 110,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      color: Colors.grey[300],
      border: Border.all(
        color: Colors.blue[900],
        width: 1,
      ),
    ),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 14, color: Colors.black),
    ),
  );
}

Widget _resultdatabig(String text) {
  return Container(
    padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
    width: 280,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      color: Colors.grey[300],
      border: Border.all(
        color: Colors.blue[900],
        width: 1,
      ),
    ),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 12, color: Colors.black),
    ),
  );
}

Widget _input(String hint, controller) {
  return Container(
    width: 60,
    height: 30,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      border: Border.all(
        color: Colors.blue[900],
        width: 1,
      ),
      color: Colors.grey[300],
    ),
    child: TextFormField(
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
      ),
    ),
  );
}

Widget _referenceData(String st1,String st2 , Color c1){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        flex:7,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 2),
//          color: Colors.blue[300],
          child: Text(
            st1,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
        ),
      ),
//                                SizedBox(width: 10,),
      Expanded(
        flex:6,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 4,vertical: 2
          ),
          color: c1,
          child: Text(
            st2,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
        ),
      ),
    ],
  );
}
Widget _referenceData2(String st1,String st2 , Color c1){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        flex:7,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 2,horizontal: 6),
//          color: Colors.blue[300],
          child: Text(
            st1,
            textAlign: TextAlign.end,
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
        ),
      ),
//                                SizedBox(width: 10,),
      Expanded(
        flex:6,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 4,vertical: 2
          ),
          color: c1,
          child: Text(
            st2,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
        ),
      ),
    ],
  );
}
Widget _input2(String hint, controller) {
  return Container(
    width: 90,
    height: 40,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      border: Border.all(
        color: Colors.blue[900],
        width: 1,
      ),
      color: Colors.grey[300],
    ),
    child: TextFormField(
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
      ),
    ),
  );
}
