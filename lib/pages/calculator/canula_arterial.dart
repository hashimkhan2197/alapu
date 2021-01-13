import 'package:flutter/material.dart';

class CanulaArterial extends StatefulWidget {
  final double fmax;

  CanulaArterial(this.fmax);

  @override
  _CanulaArterialState createState() => _CanulaArterialState();
}

class _CanulaArterialState extends State<CanulaArterial> {
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
          'CÁNULAS FEMORALES ARTERIALES',
          style: TextStyle(fontSize: 17),
        ),
        backgroundColor: Colors.blue[900],
        iconTheme: IconThemeData(color: Colors.black),
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
            _tabledata('FMax', 'Medidas', Colors.blue[400],
                Colors.blue[600]),
            _tabledata(
                '< 700 ml ',
                ' 8 Fr',
                fmax <= 0.7 ? Colors.red : Colors.grey[200],
                fmax <= 0.7 ? Colors.red : Colors.grey[400]),
            _tabledata(
                '< 1250 ml ',
                ' 10 Fr',
                fmax > 0.7 && fmax <= 1.25 ? Colors.red : Colors.grey[200],
                fmax > 0.7 && fmax <= 1.25 ? Colors.red : Colors.grey[400]),
            _tabledata(
                '< 2000 ml ',
                ' 12 Fr',
                fmax > 1.25 && fmax <= 2.0 ? Colors.red : Colors.grey[200],
                fmax > 1.25 && fmax <= 2.0 ? Colors.red : Colors.grey[400]),
            _tabledata(
                '< 2500 ml ',
                ' 14 Fr',
                fmax > 2.0 && fmax <= 2.5 ? Colors.red : Colors.grey[200],
                fmax > 2.0 && fmax <= 2.5 ? Colors.red : Colors.grey[400]),
            _tabledata(
                '< 3000 ml ',
                ' 15 Fr',
                fmax > 2.5 && fmax <= 3.0 ? Colors.red : Colors.grey[200],
                fmax > 2.5 && fmax <= 3.0 ? Colors.red : Colors.grey[400]),
            _tabledata(
                '< 4100 ml ',
                ' 17 Fr',
                fmax > 3.0 && fmax <= 4.1 ? Colors.red : Colors.grey[200],
                fmax > 3.0 && fmax <= 4.1 ? Colors.red : Colors.grey[400]),
            _tabledata(
                '< 5500 ml ',
                ' 19 Fr',
                fmax > 4.1 && fmax <= 5.5 ? Colors.red : Colors.grey[200],
                fmax > 4.1 && fmax <= 5.5 ? Colors.red : Colors.grey[400]),
            _tabledata(
                '> 5500 ml ',
                ' 21,23,25 Fr',
                fmax > 5.5 ? Colors.red : Colors.grey[200],
                fmax > 5.5 ? Colors.red : Colors.grey[400]),
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
