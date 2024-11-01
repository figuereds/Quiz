import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const QuizScreen(title: 'Quiz App'),
    );
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key, required this.title});

  final String title;

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

//Padding

class _QuizScreenState extends State<QuizScreen> {
  int _questionIndex = 0;
  int _totalScore = 0;

  final List<Map<String, Object>> _questions = [
    {
      'questionText': 'Qual é a capital da França?', // 1
      'answers': [
        {'text': 'Paris', 'score': 1},
        {'text': 'Londres', 'score': 0},
        {'text': 'Roma', 'score': 0},
        {'text': 'Berlim', 'score': 0},
      ],
    },
    {
      'questionText': 'Qual é o maior planeta do Sistema Solar?', // 2
      'answers': [
        {'text': 'Terra', 'score': 0},
        {'text': 'Júpiter', 'score': 1},
        {'text': 'Marte', 'score': 0},
        {'text': 'Saturno', 'score': 0},
      ],
    },
    {
      'questionText': 'Quem pintou a Mona Lisa?', // 3
      'answers': [
        {'text': 'Vincent van Gogh', 'score': 0},
        {'text': 'Pablo Picasso', 'score': 0},
        {'text': 'Leonardo da Vinci', 'score': 1},
        {'text': 'Claude Monet', 'score': 0},
      ],
    },
    {
      'questionText': 'Qual é o animal terrestre mais rápido do mundo?', // 4
      'answers': [
        {'text': 'Elefante', 'score': 0},
        {'text': 'Guepardo', 'score': 1},
        {'text': 'Leão', 'score': 0},
        {'text': 'Cavalo', 'score': 0},
      ],
    },
    {
      'questionText': 'Qual é a fórmula química da água?', // 5
      'answers': [
        {'text': 'H2O', 'score': 1},
        {'text': 'O2H', 'score': 0},
        {'text': 'CO2', 'score': 0},
        {'text': 'HO2', 'score': 0},
      ],
    },
    {
      'questionText': 'Em que ano o homem pisou na Lua pela primeira vez?', // 6
      'answers': [
        {'text': '1965', 'score': 0},
        {'text': '1969', 'score': 1},
        {'text': '1975', 'score': 0},
        {'text': '1980', 'score': 0},
      ],
    },
    {
      'questionText': 'Quantos continentes existem na Terra?', // 7
      'answers': [
        {'text': '5', 'score': 0},
        {'text': '6', 'score': 0},
        {'text': '7', 'score': 1},
        {'text': '8', 'score': 0},
      ],
    },
    {
      'questionText': 'Qual é o elemento químico representado pelo símbolo “O”?', // 8
      'answers': [
        {'text': 'Ouro', 'score': 0},
        {'text': 'Oxigênio', 'score': 1},
        {'text': 'Ósmio', 'score': 0},
        {'text': 'Organônio', 'score': 0},
      ],
    },
    {
      'questionText': 'Qual é o país mais populoso do mundo?', // 9
      'answers': [
        {'text': 'Índia', 'score': 0},
        {'text': 'Estados Unidos', 'score': 0},
        {'text': 'China', 'score': 1},
        {'text': 'Brasil', 'score': 0},
      ],
    },
    {
      'questionText': 'Quantos graus tem um ângulo reto?', // 10
      'answers': [
        {'text': '45', 'score': 0},
        {'text': '90', 'score': 1},
        {'text': '180', 'score': 0},
        {'text': '360', 'score': 0},
      ],
    },
  ];

  

  void _answerQuestion(int score) {
    setState(() {
      _totalScore += score;
      _questionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _questionIndex < _questions.length
          ? Column(
              children: [ 
                Text(_questions[_questionIndex]['questionText'] as String),
                ...(_questions[_questionIndex]['answers']
                        as List<Map<String, Object>>)
                    .map((answer) {
                  return ElevatedButton(
                    onPressed: () => _answerQuestion(answer['score'] as int),
                    child: Text(answer['text'] as String),
                  );
                }).toList()
              ],
            )
          : Center(
              child: Text(
                'Parabéns! Sua pontuação foi: $_totalScore',
                style: const TextStyle(fontSize: 24),
              ),
            ),
    );
  }
}
