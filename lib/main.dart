import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz do Universo Marvel',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const TelaInicial(),
    );
  }
}

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override // construção da tela
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Universo Marvel',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.redAccent,
                Colors.deepOrange,
                Colors.black,
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/marvel.jpg',
              width: 500,
              height: 500,
            ),
            const SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Bem vindo ao Quiz do Universo Marvel!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  // botão de reiniciar o quiz
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QuizScreen(title: 'Quiz'),
                      ),
                    );
                  },
                  child: const Text('Iniciar Quiz'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key, required this.title});

  final String title;

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _questionIndex = 0;
  int _totalScore = 0;

  final List<Map<String, Object>> _questions = [
    {
      'questionText': 'Qual é a capital da França?',
      'imageUrl':
          'https://static.vecteezy.com/ti/vetor-gratis/t2/15451717-bandeira-da-franca-bandeira-do-3d-vetor.jpg',
      'answers': [
        {'text': 'Paris', 'score': 1},
        {'text': 'Londres', 'score': 0},
        {'text': 'Roma', 'score': 0},
        {'text': 'Berlim', 'score': 0},
      ],
    },
    // Adicione outras perguntas conforme necessário
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
        centerTitle: true,
      ),
      body: Center(
        child: _questionIndex < _questions.length
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    _questions[_questionIndex]['imageUrl'] as String,
                    height: 200,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _questions[_questionIndex]['questionText'] as String,
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ...(_questions[_questionIndex]['answers']
                          as List<Map<String, Object>>)
                      .map((answer) {
                    return ElevatedButton(
                      onPressed: () => _answerQuestion(answer['score'] as int),
                      child: Text(answer['text'] as String),
                    );
                  }).toList(),
                ],
              )
            : Center(
                child: Text(
                  'Parabéns! Sua pontuação foi: $_totalScore',
                  style: const TextStyle(fontSize: 24),
                ),
              ),
      ),
    );
  }
}
