import 'package:flutter/material.dart';
import '../utils/color.dart';

class ButtonWidget extends StatelessWidget {
  var btnText = "";
  var onClick;

  ButtonWidget({this.btnText, this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.only(left: 28.0, right: 28),
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 10,
                  offset: Offset(0, 5))
            ],
//            gradient: LinearGradient(
//                colors: [orangeColors, orangeLightColors],
//                end: Alignment.centerLeft,
//                begin: Alignment.centerRight),
            borderRadius: BorderRadius.all(
              Radius.circular(100),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            btnText,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
