import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  final String _limpar = 'Limpar';
  String _expressao = '';
  String _resultado = '';

  void _pressionarBotao(String valor) {
    setState(() {
      if (valor == _limpar) {
        _expressao = '';
        _resultado = '';
      } else if (valor == '=') {
        _calcularResultado();
      } else {
        _expressao += valor;
      }
    });
  }

  void _calcularResultado() {
    try {
      _resultado = _avaliarExpressao(_expressao).toString();
    } catch (e) {
      setState(() {
        _resultado = 'Expressão inválida';
      });
    } 
  }

  double _avaliarExpressao(String expressao) {
    expressao = expressao.replaceAll('x', '*');
    expressao = expressao.replaceAll('÷', '/');

    ExpressionEvaluator avaliador = const ExpressionEvaluator();
    double resultado = avaliador.eval(Expression.parse(expressao), {});
    return resultado;
  }

  Widget botao(String valor) {
    return TextButton(
      child: Text(
        valor,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      onPressed: () => _pressionarBotao(valor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Container(
            color: const Color.fromARGB(255, 167, 46, 141), 
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(16.0),
            child: Text(
              _expressao,
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(16.0),
            child: Text(
              _resultado,
              style: const TextStyle(
                  fontSize: 24, color: Color.fromARGB(255, 255, 255, 255)),
                  
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: GridView.count(
            crossAxisCount: 4,
            childAspectRatio: 2,
            children: [
              botao('7'),
              botao('8'),
              botao('9'),
              botao('÷'),
              botao('4'),
              botao('5'),
              botao('6'),
              botao('x'),
              botao('1'),
              botao('2'),
              botao('3'),
              botao('-'),
              botao('0'),
              botao('.'),
              botao('+'),
              botao('='),
            ],
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: botao(_limpar),
          ),
        ),
      ],
    );
  }
}
