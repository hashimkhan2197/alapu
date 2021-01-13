import 'package:flutter/material.dart';

class CanulasVenosas extends StatefulWidget {
  final double fmax;

  CanulasVenosas(this.fmax);

  @override
  _CanulasVenosasState createState() => _CanulasVenosasState();
}

class _CanulasVenosasState extends State<CanulasVenosas> {
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
          'CÁNULAS VENOSAS',
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
                      'punta metálica curva',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 10),
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
                    height: 75,
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Text(
                            'FMáx',
                            style: TextStyle(
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
                    height: 75,
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(height: 5),
                          Text(
                            'Medidas',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            'Vena Cava',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            'Superíor',
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
                    height: 75,
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(height: 5),
                          Text(
                            'Medidas',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            'Vena Cava',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            'Inferíor',
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
                '< 500 ml',
                '12 Fr',
                '12 Fr',
                fmax <= 0.5 ? Colors.red : Colors.grey[200],
                fmax <= 0.5 ? Colors.red : Colors.grey[400]),
            _tabledata(
                '< 750 ml',
                '12 Fr',
                '14 Fr',
                fmax > 0.5 && fmax <= 0.75 ? Colors.red : Colors.grey[200],
                fmax > 0.5 && fmax <= 0.75 ? Colors.red : Colors.grey[400]),
            _tabledata(
                '< 1000 ml',
                '12 Fr',
                '16 Fr',
                fmax > 0.75 && fmax <= 1.0 ? Colors.red : Colors.grey[200],
                fmax > 0.75 && fmax <= 1.0 ? Colors.red : Colors.grey[400]),
            _tabledata(
                '< 1200 ml',
                '14 Fr',
                '16 Fr',
                fmax > 1.0 && fmax <= 1.2 ? Colors.red : Colors.grey[200],
                fmax > 1.0 && fmax <= 1.2 ? Colors.red : Colors.grey[400]),
            _tabledata(
                '< 1500 ml',
                '16 Fr',
                '16 Fr',
                fmax > 1.2 && fmax <= 1.5 ? Colors.red : Colors.grey[200],
                fmax > 1.2 && fmax <= 1.5 ? Colors.red : Colors.grey[400]),
            _tabledata(
                '< 1800 ml',
                '16 Fr',
                '18 Fr',
                fmax > 1.5 && fmax <= 1.8 ? Colors.red : Colors.grey[200],
                fmax > 1.5 && fmax <= 1.8 ? Colors.red : Colors.grey[400]),
            _tabledata(
                '< 2000 ml',
                '16 Fr',
                '20 Fr',
                fmax > 1.8 && fmax <= 2.0 ? Colors.red : Colors.grey[200],
                fmax > 1.8 && fmax <= 2.0 ? Colors.red : Colors.grey[400]),
            _tabledata(
                '< 2400 ml',
                '18 Fr',
                '20 Fr',
                fmax > 2.0 && fmax <= 2.4 ? Colors.red : Colors.grey[200],
                fmax > 2.0 && fmax <= 2.4 ? Colors.red : Colors.grey[400]),
            _tabledata(
                '< 2500 ml',
                '20 Fr',
                '20 Fr',
                fmax > 2.4 && fmax <= 2.5 ? Colors.red : Colors.grey[200],
                fmax > 2.4 && fmax <= 2.5 ? Colors.red : Colors.grey[400]),
            _tabledata(
                '< 3000 ml',
                '20 Fr',
                '24 Fr',
                fmax > 2.5 && fmax <= 3.0 ? Colors.red : Colors.grey[200],
                fmax > 2.5 && fmax <= 3.0 ? Colors.red : Colors.grey[400]),
            _tabledata(
                '< 4000 ml',
                '24 Fr',
                '24 Fr',
                fmax > 3.0 && fmax <= 4.0 ? Colors.red : Colors.grey[200],
                fmax > 3.0 && fmax <= 4.0 ? Colors.red : Colors.grey[400]),
            _tabledata(
                '< 5000 ml',
                '24 Fr',
                '28 Fr',
                fmax > 4.0 && fmax <= 5.0 ? Colors.red : Colors.grey[200],
                fmax > 4.0 && fmax <= 5.0 ? Colors.red : Colors.grey[400]),
            _tabledata(
                '< 6000 ml',
                '28 Fr',
                '28 Fr',
                fmax > 5.0 && fmax <= 6.0 ? Colors.red : Colors.grey[200],
                fmax > 5.0 && fmax <= 6.0 ? Colors.red : Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}

Widget _tabledata(
    String tr1, String tr2, String tr3, Color color1, Color color2) {
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
//                color: Colors.black,
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
