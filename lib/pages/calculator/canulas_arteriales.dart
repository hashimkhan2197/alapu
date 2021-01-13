import 'package:flutter/material.dart';

class CanulasArteriales extends StatefulWidget {
  final double fmax;

  CanulasArteriales(this.fmax);

  @override
  _CanulasArterialesState createState() => _CanulasArterialesState();
}

class _CanulasArterialesState extends State<CanulasArteriales> {
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
          'CÁNULAS ARTERIALES',
          style: TextStyle(fontSize: 17),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(bottom: 20),
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
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'punta recta',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
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
            _tabledata('Medidas','FMáx','    ',  Colors.blue[500],
                Colors.blue[500]),
            _tabledata(
                ' 6 Fr',
                ' - ',
                '< 300 ml',
                Colors.grey[400],
                 Colors.grey[200]),
            _tabledata(
                ' 8 Fr',
                '< 800 ml ',
                '< 500 ml',
                fmax <= 0.8 ? Colors.red : Colors.grey[400],
                 Colors.grey[200]),
            _tabledata(
                ' 10 Fr',
                '< 1250 ml ',
                '< 1100 ml',
                fmax > 0.8 && fmax <= 1.25 ? Colors.red : Colors.grey[400],
                 Colors.grey[200]),
            _tabledata(
                ' 12 Fr',
                '< 2400 ml ',
                '< 1800 ml',
                fmax > 1.25 && fmax <= 2.4 ? Colors.red : Colors.grey[400],
                 Colors.grey[200]),
            _tabledata(
                ' 14 Fr',
                '< 3700 ml ',
                '< 2500 ml',
                fmax > 2.4 && fmax <= 3.7 ? Colors.red : Colors.grey[400],
                 Colors.grey[200]),
            _tabledata(
                ' 16 Fr',
                '< 4500 ml ',
                '< 3200 ml',
                fmax > 3.7 && fmax <= 4.5 ? Colors.red : Colors.grey[400],
                 Colors.grey[200]),
            _tabledata(
                ' 18 Fr',
                '< 5500 ml ',
                '< 3200 ml',
                fmax > 4.5 && fmax <= 5.5 ? Colors.red : Colors.grey[400],
                 Colors.grey[200]),
            _tabledata(
                ' 20 Fr',
                '< 6000 ml ',
                '< 4700 ml',
                fmax > 5.5 && fmax <= 6.0 ? Colors.red : Colors.grey[400],
                 Colors.grey[200]),
            _tabledata(
                ' 22 Fr',
                '> 6000 ml ',
                '< 5800 ml',
                fmax > 6.0 ? Colors.red : Colors.grey[400],
                Colors.grey[200]),
            _tabledata(
                ' 24 Fr',
                '> 6000 ml ',
                '< 7000 ml',
                fmax > 6.0 ? Colors.red : Colors.grey[400],
                Colors.grey[200]),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      //border: Border.all(color: Colors.black),
                      color: Colors.grey[400],
                    ),
                    height: 70,
                    child: Center(
                      child: Text(
                        '   ',
                        style: TextStyle(
                          fontSize: 16,
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
                      color: Colors.grey[400],
                    ),
                    height: 70,
                    child: Center(
                      child: Text(
                        "Sugerencias considerando la viscosidad",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
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
                      color: Colors.grey[200],
                    ),
                    height: 70,
                    child: Center(
                      child: Text(
                        "Valores en agua",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget _tabledata(String tr1, String tr2,String tr3, Color color1, Color color2) {
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
            color: color1,
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
              tr3,
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
