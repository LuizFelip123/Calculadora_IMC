import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightTextController = TextEditingController();
  TextEditingController heightTextController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();
  String infoText = 'Informe seus dados';
  void _resetTextFields() {
    weightTextController.text = '';
      heightTextController.text = '';
    setState(() {
      infoText = 'Informe seus dados';
    });
  }

  void calculate() {
    setState(
      () {
        double weight = double.parse(weightTextController.text);
        double height = double.parse(heightTextController.text) / 100;
        double imc = weight / (height * height);
        if (imc < 18.6) {
          infoText = 'Abaixo do peso! imc : (${imc.toStringAsPrecision(4)})';
        } else if (imc < 24.9) {
          infoText = 'Peso ideal! imc : (${imc.toStringAsPrecision(4)})';
        } else if (imc < 29.9) {
          infoText = 'Levemente acima do peso! imc : (${imc.toStringAsPrecision(4)})';
        } else if (imc < 34.9) {
          infoText = 'Obesidade grau I! imc : (${imc.toStringAsPrecision(4)})';
        } else if (imc <= 39.9) {
          infoText = 'Obesidade grau II! imc : (${imc.toStringAsPrecision(4)})';
        } else if (imc >= 40) {
          infoText = 'Obesidade grau III! imc : (${imc.toStringAsPrecision(4)})';
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _resetTextFields();
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key:_formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.person_outline,
                size: 120,
                color: Colors.green,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Peso (Kg)',
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: weightTextController,
                validator: (value) {
                  if(value!.isEmpty){
                    return "Insira seu peso!";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Altura (cm)',
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: heightTextController,
                validator: (value) {
                   if(value!.isEmpty){
                    return 'Insira sua altura';
                   }
                },
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                child: Container(
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        calculate();
                      }
                    },
                    child: Text(
                      'Calcular',
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),
                ),
              ),
              Text(
                infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
