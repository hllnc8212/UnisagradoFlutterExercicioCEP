import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bem vindo ao Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bem vindo ao Flutter'),
        ),
        body: CepWidget()));
  }
}


class CepWidget extends StatefulWidget {  // classe que gerencia a criação do objeto
 @override
 _CepWidgetState createState() => _CepWidgetState(); // singleton - cira uma única instância
}

class _CepWidgetState extends State<CepWidget> {
  var _controller = TextEditingController(text: ''); // quando cria uma caixa de texto, precisa ter um controller
  String _text = 'Insira um Cep';
  String _logradouro = '';
  String _bairro = '';
  String _localidade = '';
  String _uf = '';
  String _ddd = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        RaisedButton(
          onPressed: onButtonPressCep,
          child: const Text('Consultar', style: TextStyle(fontSize: 20)),
        ),
        Text('$_text'),
        TextField(
          controller: _controller, // como se fosse input - entrada de dados
        ),
        Text('$_logradouro'),
        Text('$_bairro'),
        Text('$_localidade'),
        Text('$_uf'),
        Text('$_ddd'),
    ]),
  );
 }

  onButtonPressCep() async {
    // Realizando Request
    String url = 'https://viacep.com.br/ws/${_controller.text}/json/';
    Response response = await get(url);
    // Capturando Response
    String content = response.body;
    if (response.statusCode == 200) {
        print('Response body : ${content}');
        try {
          final parsed = jsonDecode(content).cast<String, dynamic>();
          setState(() { // quando precisa alterar o estado de um compoenente, precisa do setState
            _logradouro = parsed["logradouro"];
            _bairro = parsed["bairro"];
            _localidade = parsed["localidade"];
            _uf = parsed["uf"];
            _ddd = parsed["ddd"];
          });
        } catch (Ex) {
          print("Erro ao decodificar JSON : $Ex");
        }
      }
    }
  }

