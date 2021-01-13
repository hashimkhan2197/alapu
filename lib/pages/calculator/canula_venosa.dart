import 'package:flutter/material.dart';

class CanulaVenosa extends StatefulWidget {
  final double fmax;

  CanulaVenosa(this.fmax);

  @override
  _CanulaVenosaState createState() => _CanulaVenosaState();
}

class _CanulaVenosaState extends State<CanulaVenosa> {
  double fmax;

  @override
  void initState() {
    fmax = widget.fmax;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CÁNULAS FEMORALES VENOSAS',
          style: TextStyle(fontSize: 17),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.blue[900],
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        //padding: EdgeInsets.only(bottom: 20),
        child: ListView(
          children: <Widget>[
            Container(
              color: Colors.blue[400],
              height: 90,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    Text(
                      'Medtronic',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'BIO-MEDICUS™',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      color: Colors.red,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(6),
                      child: Text(
                        'Rojo sugerido',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.blue[400],
                    height: 50,
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Text(
                            'FMax',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.blue[600],
                    height: 50,
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Text(
                            'Medidas',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            _tabledata(
                '< 2300 ml',
                '15 Fr',
                fmax <= 2.3 ? Colors.red : Colors.grey[200],
                fmax <= 2.3 ? Colors.red : Colors.grey[400]),
            _tabledata(
                '< 3200 ml',
                '17 Fr',
                fmax > 2.3 && fmax <= 2.2 ? Colors.red : Colors.grey[200],
                fmax > 2.3 && fmax <= 3.2 ? Colors.red : Colors.grey[400]),
            _tabledata(
                '< 4400 ml',
                '19 Fr',
                fmax > 3.2 && fmax <= 4.4 ? Colors.red : Colors.grey[200],
                fmax > 3.2 && fmax <= 4.4 ? Colors.red : Colors.grey[400]),
            _tabledata(
                '< 5600 ml',
                '21 Fr',
                fmax > 4.4 && fmax <= 5.6 ? Colors.red : Colors.grey[200],
                fmax > 4.4 && fmax <= 5.6 ? Colors.red : Colors.grey[400]),
            _tabledata(
                '> 5600 ml',
                '23,25,27,29 Fr',
                fmax > 5.6 ? Colors.red : Colors.grey[200],
                fmax > 5.6 ? Colors.red : Colors.grey[400]),
            ],
        ),
      ),
    );
  }
}

Widget _tabledata(String tr1, String tr2, Color color1, Color color2) {
  return Row(
    children: [
      Expanded(
        flex: 1,
        child: Container(
          decoration: BoxDecoration(
            //border: Border.all(color: Colors.black),
            color: color1,
          ),
          height: 50,
          child: Center(
            child: Text(
              tr1,
              style: TextStyle(
                //color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: Container(
          decoration: BoxDecoration(
            //border: Border.all(color: Colors.black),
            color: color2,
          ),
          height: 50,
          child: Center(
            child: Text(
              tr2,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
