import 'package:flutter/material.dart';

class CanulaVenosaUnica extends StatefulWidget {
  final double fmax;

  CanulaVenosaUnica(this.fmax);

  @override
  _CanulaVenosaUnicaState createState() => _CanulaVenosaUnicaState();
}

class _CanulaVenosaUnicaState extends State<CanulaVenosaUnica> {
  double fmax;

  @override
  void initState() {
    fmax = widget.fmax;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        elevation: 0,
        title: Text(
          'CÁNULAS VENOSA ÚNICA',
          style: TextStyle(fontSize: 17),
        ),
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
                      'Medtronic® DLP™',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'punta recta una etapa',
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
            _tabledata('FMax', 'Medidas',
                Colors.blue[400], Colors.blue[600]),
            _tabledata(
                '< 200 ml ',
                ' 12 Fr',
                fmax <= 0.2 ? Colors.red : Colors.grey[200],
                fmax <= 0.2 ? Colors.red : Colors.grey[400]),
            _tabledata(
                '< 350 ml ',
                ' 14 Fr',
                fmax > 0.2 && fmax <= 0.35 ? Colors.red : Colors.grey[200],
                fmax > 0.2 && fmax <= 0.35 ? Colors.red : Colors.grey[400]),
            _tabledata(
                '< 450 ml ',
                ' 16 Fr',
                fmax > 0.35 && fmax <= 0.45 ? Colors.red : Colors.grey[200],
                fmax > 0.35 && fmax <= 0.45 ? Colors.red : Colors.grey[400]),
            _tabledata(
                '< 700 ml ',
                ' 18 Fr',
                fmax > 0.45 && fmax <= 0.7 ? Colors.red : Colors.grey[200],
                fmax > 0.45 && fmax <= 0.7 ? Colors.red : Colors.grey[400]),
            _tabledata(
                '< 850 ml ',
                ' 20 Fr',
                fmax > 0.7 && fmax <= 0.85 ? Colors.red : Colors.grey[200],
                fmax > 0.7 && fmax <= 0.85 ? Colors.red : Colors.grey[400]),
            _tabledata(
                '< 1100 ml ',
                ' 22 Fr',
                fmax > 0.85 && fmax <= 1.1 ? Colors.red : Colors.grey[200],
                fmax > 0.85 && fmax <= 1.1 ? Colors.red : Colors.grey[400]),
            _tabledata(
                '< 1400 ml ',
                ' 24 Fr',
                fmax > 1.1 && fmax <= 1.4 ? Colors.red : Colors.grey[200],
                fmax > 1.1 && fmax <= 1.4 ? Colors.red : Colors.grey[400]),
            _tabledata(
                '< 1800 ml ',
                ' 26 Fr',
                fmax > 1.4 && fmax <= 1.8 ? Colors.red : Colors.grey[200],
                fmax > 1.4 && fmax <= 1.8 ? Colors.red : Colors.grey[400]),
            _tabledata(
                '< 2300 ml ',
                ' 28 Fr',
                fmax > 1.8 && fmax <= 2.3 ? Colors.red : Colors.grey[200],
                fmax > 1.8 && fmax <= 2.3 ? Colors.red : Colors.grey[400]),
            _tabledata(
                '< 2800 ml ',
                ' 30 Fr',
                fmax > 2.3 && fmax <= 2.8 ? Colors.red : Colors.grey[200],
                fmax > 2.3 && fmax <= 2.8 ? Colors.red : Colors.grey[400]),
            _tabledata(
                '< 3500 ml ',
                ' 32 Fr',
                fmax > 2.8 && fmax <= 3.5 ? Colors.red : Colors.grey[200],
                fmax > 2.8 && fmax <= 3.5 ? Colors.red : Colors.grey[400]),
            _tabledata(
                '< 4200 ml ',
                ' 34 Fr',
                fmax > 3.5 && fmax <= 4.2 ? Colors.red : Colors.grey[200],
                fmax > 3.5 && fmax <= 4.2 ? Colors.red : Colors.grey[400]),
            _tabledata(
                '< 4700 ml ',
                ' 36 Fr',
                fmax > 4.2 && fmax <= 4.7 ? Colors.red : Colors.grey[200],
                fmax > 4.2 && fmax <= 4.7 ? Colors.red : Colors.grey[400]),
            _tabledata(
                '< 5300 ml ',
                ' 38 Fr',
                fmax > 4.7 && fmax <= 5.3 ? Colors.red : Colors.grey[200],
                fmax > 4.7 && fmax <= 5.3 ? Colors.red : Colors.grey[400]),
            _tabledata(
                '< 6200 ml ',
                ' 40 Fr',
                fmax > 5.3 && fmax <= 6.2 ? Colors.red : Colors.grey[200],
                fmax > 5.3 && fmax <= 6.2 ? Colors.red : Colors.grey[400]),
            _tabledata(
                '< 6200 ml ',
                ' 42 Fr',
                fmax > 5.3 && fmax <= 6.2 ? Colors.red : Colors.grey[200],
                fmax > 5.3 && fmax <= 6.2 ? Colors.red : Colors.grey[400]),

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
