import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Calculadora de IMC',
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  String _infoText = "Aguardando entradas";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetFields() {
    setState(() {
      weightController.text = "";
      heightController.text = "";
      _infoText = "Aguardando entradas";
    });
  }

  void _calculate() {
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100;
    double imc = weight / (height * height);
    print(imc);
    setState(() {
      if (imc < 18.6) {
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(2)})";
      } else if (imc >= 18.6 && imc <= 24.0) {
        _infoText = "Peso ideal (${imc.toStringAsPrecision(2)})";
      } else if (imc >= 24.0 && imc < 29.9) {
        _infoText = "Levemente acima (${imc.toStringAsPrecision(2)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade grau I (${imc.toStringAsPrecision(2)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade grau II (${imc.toStringAsPrecision(2)})";
      } else if (imc >= 39.9) {
        _infoText = "Obesidade grau II (${imc.toStringAsPrecision(2)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calculadora de IMC'),
          centerTitle: true,
          backgroundColor: Colors.lightGreen,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(Icons.accessibility_new,
                      size: 120.0, color: Colors.lightGreen),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Peso (kg)",
                      labelStyle: TextStyle(color: Colors.lightGreen),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.lightGreen, fontSize: 20.0),
                    controller: weightController,
                    validator: (value) {
                      if(value.isEmpty) {
                        return "Insira seu peso!";
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle(color: Colors.lightGreen),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.lightGreen, fontSize: 20.0),
                    controller: heightController,
                    validator: (value) {
                      if(value.isEmpty) {
                        return "Insira seu peso!";
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          if(_formKey.currentState.validate()) {
                            _calculate();
                          }
                        },
                        child: Text(
                          "Calcular",
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                        ),
                        color: Colors.lightGreen,

                      ),
                    ),
                  ),
                  Text(
                    "$_infoText",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25.0, color: Colors.lightGreen),
                  )
                ],
              ),
            )));
  }
}
