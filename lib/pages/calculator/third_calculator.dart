import 'package:flutter/material.dart';

class ThirdCalculator extends StatefulWidget {
  ThirdCalculator({Key key}) : super(key: key);

  @override
  _ThirdCalculatorState createState() => _ThirdCalculatorState();
}

class _ThirdCalculatorState extends State<ThirdCalculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[50],
        iconTheme: IconThemeData(color: Colors.red),
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
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(60, 4, 60, 0),
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        color: Colors.blue[900]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Dosis de Protamina',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(30, 3, 30, 0),
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        color: Colors.grey),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '4:1 (4 Parts Crystalloids to 1 Part Blood)',
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(50, 5, 50, 0),
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        color: Colors.red[700]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Composition',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        Text(
                          'Adult',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        Text(
                          'Pediatric',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _heading('Dummyname'),
                      _input(),
                      _input(),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _heading('Dummyname'),
                      _input(),
                      _input(),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _heading('Dummyname'),
                      _input(),
                      _input(),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _heading('Dummyname'),
                      _input(),
                      _input(),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _heading('Dummyname'),
                      _input(),
                      _input(),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _heading('Dummyname'),
                      _input(),
                      _input(),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(90, 4, 90, 0),
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        color: Colors.blue[900]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Induction Dose',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[_heading('Dummyname'), _longinput()],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _heading('Dummyname'),
                      _multilineinput(),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(70, 4, 70, 0),
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        color: Colors.blue[900]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Mantenance Dose',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[_heading('Dummyname'), _longinput()],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _heading('Dummyname'),
                      _multilineinput(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _input() {
  return Container(
    width: 80,
    height: 23,
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
    ),
  );
}

Widget _heading(String text) {
  return Container(
    height: 25,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      color: Colors.grey[500],
    ),
    padding: EdgeInsets.fromLTRB(20, 3, 20, 0),
    child: Text(
      text,
      style: TextStyle(fontSize: 16, color: Colors.black),
    ),
  );
}

Widget _longinput() {
  return Container(
    width: 180,
    height: 23,
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
    ),
  );
}

Widget _multilineinput() {
  return Container(
    width: 180,
    //height: 23,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      border: Border.all(
        color: Colors.blue[900],
        width: 1,
      ),
      color: Colors.grey[300],
    ),
    child: TextFormField(
      minLines: 3,
      maxLines: 10,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
    ),
  );
}
